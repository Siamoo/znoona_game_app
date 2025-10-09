import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/create_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_player_answers_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_question_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_rooms_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/join_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/leave_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/reset_answers_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/start_game_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/submit_answer_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/watch_player_answers_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/watch_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({
    required this.createRoomUseCase,
    required this.joinRoomUseCase,
    required this.leaveRoomUseCase,
    required this.getRoomsStreamUseCase,
    required this.getRoomPlayersStreamUseCase,
    required this.getRoomQuestionsUseCase,
    required this.startGameUseCase,
    required this.watchRoomUseCase,
    required this.getQuestionUseCase,
    required this.getQuestionsUseCase,
    required this.submitAnswerUseCase,
    required this.getPlayerAnswersUseCase,
    required this.resetAnswersUseCase,
    required this.watchPlayerAnswersUseCase,
  }) : super(const RoomState.initial());

  final CreateRoomUseCase createRoomUseCase;
  final JoinRoomUseCase joinRoomUseCase;
  final LeaveRoomUseCase leaveRoomUseCase;
  final GetRoomsStreamUseCase getRoomsStreamUseCase;
  final GetRoomPlayersStreamUseCase getRoomPlayersStreamUseCase;
  final GetRoomQuestionsUseCase getRoomQuestionsUseCase;
  final StartGameUseCase startGameUseCase;
  final WatchRoomUseCase watchRoomUseCase;
  final GetQuestionUseCase getQuestionUseCase;
  final GetQuestionsUseCase getQuestionsUseCase;
  final SubmitAnswerUseCase submitAnswerUseCase;
  final GetPlayerAnswersUseCase getPlayerAnswersUseCase;
  final ResetAnswersUseCase resetAnswersUseCase;
  final WatchPlayerAnswersUseCase watchPlayerAnswersUseCase;

  StreamSubscription<dynamic>? _roomsSub;
  StreamSubscription<dynamic>? _playersSub;
  StreamSubscription<dynamic>? _roomWatcher;
  StreamSubscription<dynamic>? _roomsSubscription;
  StreamSubscription<dynamic>? _answersSub;

  // Quiz-specific variables
  Timer? _questionTimer;
  int _remainingTime = 15;
  int _currentQuestionIndex = 0;
  int _correctCount = 0;
  String? _selectedAnswer;
  List<Question> _questions = [];
  Map<String, String?> _playerAnswers = {}; // playerId -> selectedAnswer
  List<RoomPlayer> _currentPlayers = [];
  String? _currentRoomId; // Track current room ID
  Timer? _answersPollTimer;

  // 🔹 إنشاء روم جديد
  // Update when creating/joining rooms
  Future<void> createRoom({
    required String categoryId,
  }) async {
    emit(const RoomState.loading());

    final result = await createRoomUseCase(categoryId: categoryId);

    result.fold(
      (failure) {
        emit(RoomState.error(failure));
        print('❌ Create room failed: $failure');
      },
      (room) async {
        print('✅ Room created: ${room.id} (${room.code})');

        _currentRoomId = room.id; // SET CURRENT ROOM ID

        watchRoom(room.id);
        watchRoomPlayers(room.id);

        emit(RoomState.roomLoaded(room));
      },
    );
  }

  Future<void> joinRoom({required String code}) async {
    emit(const RoomState.loading());

    final result = await joinRoomUseCase(code: code);

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        _roomsSubscription?.cancel();

        _roomsSubscription = getRoomsStreamUseCase().listen((either) {
          if (isClosed) return;

          either.fold(
            (failure) => emit(RoomState.error(failure)),
            (rooms) {
              try {
                final room = rooms.firstWhere((r) => r.code == code);
                print('✅ Joined room found: ${room.id}');

                _currentRoomId = room.id; // SET CURRENT ROOM ID

                watchRoom(room.id);
                watchRoomPlayers(room.id);

                emit(RoomState.joined(room));
              } catch (_) {
                emit(const RoomState.error('Room not found!'));
              }
            },
          );
        });
      },
    );
  }

  String _getCurrentRoomId() {
    if (_currentRoomId == null) {
      throw Exception('No current room ID found');
    }
    return _currentRoomId!;
  }

  // 🔹 مغادرة الروم
  Future<void> leaveRoom({
    required String roomId,
  }) async {
    // إلغاء جميع الاشتراكات الحالية لتفادي التحديث بعد الإغلاق
    await _roomsSubscription?.cancel();
    await _roomsSub?.cancel();
    await _playersSub?.cancel();
    await _roomWatcher?.cancel();
    _questionTimer?.cancel();

    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;

    final result = await leaveRoomUseCase(roomId: roomId);

    if (isClosed) return; // 🔹 حماية إضافية من emit بعد الإغلاق

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        print('🧭 leaveRoom');
        emit(const RoomState.left());
      },
    );
  }

  // 🔹 مراقبة جميع الغرف
  void watchRooms() {
    _roomsSub?.cancel();
    _roomsSub = getRoomsStreamUseCase().listen((either) {
      if (isClosed) return; // 🔹 تأكد قبل emit
      either.fold(
        (failure) {
          emit(RoomState.error(failure));
          print(failure);
        },
        (rooms) {
          print('🧭 watchRooms update: ${rooms.length}');
          emit(RoomState.roomsUpdated(rooms));
        },
      );
    });
  }

  // 🔹 مراقبة لاعبي الروم
  // 🔹 مراقبة لاعبي الروم
  void watchRoomPlayers(String roomId) {
    _playersSub?.cancel();
    _playersSub = getRoomPlayersStreamUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (players) {
          print('🧭 watchRoomPlayers update: ${players.length} players');
          print(
            '🧭 Players: ${players.map((p) => '${p.username} (${p.userId})').toList()}',
          );

          _currentPlayers = players;
          emit(RoomState.playersUpdated(players));

          // Check if all players have answered in quiz mode
          if (_isInQuizMode()) {
            print('🔍 In quiz mode, checking if all players answered...');
            _checkAllPlayersAnswered();
          }
        },
      );
    });
  }

  // 🔹 مراقبة حالة الروم
  void watchRoom(String roomId) {
    _roomWatcher?.cancel();
    _roomWatcher = watchRoomUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (room) {
          if (room == null) {
            print('⚠️ watchRoom returned null (temporary)');
            return;
          }

          print('🧭 watchRoom update: ${room.status}');
          if (room.status == 'started') {
            emit(const RoomState.gameStarted());
          } else {
            emit(RoomState.roomUpdated(room));
          }
        },
      );
    });
  }

  // 🔹 بدء اللعبة
  // 🔹 بدء اللعبة
  Future<void> startGame(String roomId) async {
    emit(const RoomState.loading());

    try {
      // First update room status to 'playing' via the use case
      final startResult = await startGameUseCase(roomId);

      if (isClosed) return;

      startResult.fold(
        (failure) => emit(RoomState.error(failure)),
        (_) async {
          print('🚀 Room status updated to playing, now loading questions...');

          // Then load questions for the quiz
          final questionsResult = await getRoomQuestions(roomId);

          if (isClosed) return;

          questionsResult.fold(
            (failure) => emit(RoomState.error(failure)),
            (roomQuestions) async {
              final questionIds = roomQuestions
                  .map((rq) => rq.questionId)
                  .toList();

              if (questionIds.isEmpty) {
                emit(const RoomState.error('No questions found for this room'));
                return;
              }

              // Use the use case directly to get questions (returns Either)
              final actualQuestionsResult = await getQuestionsUseCase(
                questionIds,
              );

              if (isClosed) return;

              actualQuestionsResult.fold(
                (failure) => emit(RoomState.error(failure)),
                (questions) {
                  print(
                    '✅ Questions loaded successfully, starting quiz with ${questions.length} questions',
                  );
                  // Start the quiz with the loaded questions
                  startQuiz(questions);
                },
              );
            },
          );
        },
      );
    } on Exception catch (e) {
      if (isClosed) return;
      emit(RoomState.error(e.toString()));
    }
  }

  // 🔹 تحميل أسئلة الروم
  Future<Either<String, List<RoomQuestion>>> getRoomQuestions(
    String roomId,
  ) async {
    try {
      final result = await getRoomQuestionsUseCase(roomId);
      return result;
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  /// ❓ Get single question
  Future<void> getQuestion(String questionId) async {
    emit(const RoomState.loading());

    final result = await getQuestionUseCase(questionId);

    if (isClosed) return;

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (question) => emit(RoomState.questionLoaded(question)),
    );
  }

  /// ❓ Get multiple questions
  Future<void> getQuestions(List<String> questionIds) async {
    emit(const RoomState.loading());

    final result = await getQuestionsUseCase(questionIds);

    if (isClosed) return;

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (questions) => emit(RoomState.questionsListLoaded(questions)),
    );
  }

/// 🚀 Start the quiz with questions
void startQuiz(List<Question> questions) {
  _questions = questions;
  _currentQuestionIndex = 0;
  _correctCount = 0;
  _selectedAnswer = null;
  _playerAnswers.clear();
  _remainingTime = 15;

  print('🚀 Starting quiz with ${questions.length} questions');
  print('🚀 Current players: ${_currentPlayers.map((p) => p.username).toList()}');

  // Clear any existing answers in database first
  _clearExistingAnswers(_getCurrentRoomId());

  // Start REAL-TIME answers monitoring
  _watchPlayerAnswers(_getCurrentRoomId());

  _startQuestionTimer();

  emit(
    RoomState.quizStarted(
      questions: _questions,
      currentQuestionIndex: _currentQuestionIndex,
      remainingTime: _remainingTime,
      playerAnswers: _playerAnswers,
      selectedAnswer: _selectedAnswer,
      correctCount: _correctCount,
      isWaitingForPlayers: false,
      players: _currentPlayers,
    ),
  );
}


  /// 🧹 Clear any existing answers when starting quiz
  Future<void> _clearExistingAnswers(String roomId) async {
    print('🧹 CLEARING: Any existing answers before starting quiz');
    final resetResult = await resetAnswersUseCase(roomId);
    resetResult.fold(
      (failure) => print('❌ Failed to clear existing answers: $failure'),
      (_) => print('✅ Existing answers cleared'),
    );
  }

/// ⏱️ Start timer for current question
void _startQuestionTimer() {
  _questionTimer?.cancel();
  _remainingTime = 15;

  _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (_remainingTime > 0) {
      _remainingTime--;
      _emitQuizState();
      
      // Optional: Add a check when time is running low
      if (_remainingTime <= 5) {
        print('⏳ Time running low: $_remainingTime seconds remaining');
      }
    } else {
      timer.cancel();
      // SCENARIO 1: Time finished
      _handleTimeUp();
    }
  });
}

/// ✅ Player selects an answer
Future<void> selectAnswer(String answer) async {
  final currentUser = _getCurrentUserId();
  final currentQuestion = _questions[_currentQuestionIndex];

  // Don't allow answering if already answered or time is up
  if (_playerAnswers.containsKey(currentUser) &&
      _playerAnswers[currentUser] != null) {
    print('⚠️ User $currentUser already answered');
    return;
  }

  if (_remainingTime <= 0) {
    print('⚠️ Time is up, cannot answer');
    return;
  }

  print('🎯 User $currentUser selected answer: $answer');

  // Store answer locally immediately for better UX
  _selectedAnswer = answer;
  _playerAnswers[currentUser] = answer;

  // Check if answer is correct
  final isCorrect = answer == currentQuestion.correctAnswer;
  if (isCorrect) {
    _correctCount++;
    print('✅ Correct answer! Total correct: $_correctCount');
  } else {
    print('❌ Wrong answer. Correct was: ${currentQuestion.correctAnswer}');
  }

  // Emit state immediately for better UX
  _emitQuizState();

  // Store answer in database for all players to see
  final result = await submitAnswerUseCase(
    roomId: _getCurrentRoomId(),
    userId: currentUser,
    selectedAnswer: answer,
    isCorrect: isCorrect,
  );

  result.fold(
    (failure) => print('❌ Failed to submit answer to database: $failure'),
    (_) => print('✅ Answer submitted to database successfully'),
  );

  // SCENARIO 2: Check if all players answered after this answer
  _checkAllPlayersAnswered();
}

/// 👥 Check if all players have answered current question
void _checkAllPlayersAnswered() {
  if (_currentPlayers.isEmpty) {
    print('⚠️ No players found to check answers');
    return;
  }

  // Count active/connected players
  final activePlayers = _currentPlayers.where((player) => player.isConnected).toList();
  
  if (activePlayers.isEmpty) {
    print('⚠️ No active players to check answers');
    return;
  }

  // Count how many active players have answered
  final answeredPlayers = activePlayers.where(
    (player) => _playerAnswers[player.userId] != null
  ).length;

  final allCurrentPlayersAnswered = answeredPlayers == activePlayers.length;

  print('🎯 Players answered: $answeredPlayers/${activePlayers.length}');
  print('🎯 All players answered: $allCurrentPlayersAnswered');

  // SCENARIO 2: All players answered - move to next question
  if (allCurrentPlayersAnswered && _remainingTime > 0) {
    print('🎉 ALL players have answered! Moving to next question immediately...');
    _questionTimer?.cancel();
    _moveToNextQuestion();
  }
}
/// ⏰ Handle time up for current question
void _handleTimeUp() {
  print('⏰ Time\'s up! Moving to next question...');
  _questionTimer?.cancel();
  
  // SCENARIO 1: Time finished - move to next question
  _moveToNextQuestion();
}

/// ➡️ Move to next question (REPLACES _showQuestionResults)
void _moveToNextQuestion() {
  print('➡️ Moving to next question...');
  
  // Cancel current stream to prevent old data
  _answersSub?.cancel();
  
  if (_currentQuestionIndex < _questions.length - 1) {
    // Move to next question
    _currentQuestionIndex++;
    _selectedAnswer = null;
    _playerAnswers.clear();
    
    print('➡️ NOW on question ${_currentQuestionIndex + 1}');
    
    // Reset answers in database for new question
    _resetAnswersForNewQuestion();
    
    // Restart timer and stream
    _startQuestionTimer();
    _refreshAnswersStream(_getCurrentRoomId());
    
    _emitQuizState();
    
  } else {
    // Quiz finished
    print('🏁 QUIZ FINISHED!');
    _questionTimer?.cancel();
    _answersSub?.cancel();
    emit(RoomState.quizFinished(
      totalQuestions: _questions.length,
      correctAnswers: _correctCount,
      players: _currentPlayers,
    ));
  }
}

/// 🔄 Reset answers for new question
Future<void> _resetAnswersForNewQuestion() async {
  print('🔄 RESET: Resetting answers for new question...');
  
  try {
    final resetResult = await resetAnswersUseCase(_getCurrentRoomId());
    resetResult.fold(
      (failure) => print('❌ Failed to reset answers: $failure'),
      (_) => print('✅ Answers reset for new question'),
    );
    
    // Wait a bit for database to process
    await Future.delayed(const Duration(milliseconds: 500));
    
  } catch (e) {
    print('❌ Reset failed: $e, continuing anyway');
  }
}

/// 🔄 Emit current quiz state
void _emitQuizState() {
  final allPlayersAnswered = _currentPlayers.isNotEmpty &&
      _currentPlayers.every((player) => _playerAnswers[player.userId] != null);

  print('🔄 Emitting quiz state - All players answered: $allPlayersAnswered');
  print('🔄 Current players count: ${_currentPlayers.length}');
  print('🔄 Answers count: ${_playerAnswers.length}');

  emit(
    RoomState.quizStarted(
      questions: _questions,
      currentQuestionIndex: _currentQuestionIndex,
      remainingTime: _remainingTime,
      playerAnswers: _playerAnswers,
      selectedAnswer: _selectedAnswer,
      correctCount: _correctCount,
      isWaitingForPlayers: allPlayersAnswered,
      players: _currentPlayers,
    ),
  );
}


  /// 🔍 Check if we're in quiz mode
  bool _isInQuizMode() {
    return state is _QuizStarted ||
        state is _QuestionTimeUp ||
        state is _AllPlayersAnswered;
  }

  /// 🆔 Get current user ID
  String _getCurrentUserId() {
    // You'll need to implement this based on your auth system
    // For example:
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }

  /// ➡️ Implementation of going to next question
Future<void> _goToNextQuestionImpl() async {
  if (_currentQuestionIndex < _questions.length - 1) {
    // CANCEL stream FIRST
    _answersSub?.cancel();
    
    print('➡️ MOVING to next question...');
    
    // Clear local state IMMEDIATELY
    _currentQuestionIndex++;
    _selectedAnswer = null;
    _playerAnswers.clear();
    
    print('➡️ NOW on question ${_currentQuestionIndex + 1}');
    
    // Reset answers in database
    try {
      await resetAnswersUseCase(_getCurrentRoomId());
      print('✅ Answers reset for new question');
      
      // Wait for database to process
      await Future.delayed(const Duration(milliseconds: 2000));
      
    } catch (e) {
      print('❌ Reset failed: $e, continuing anyway');
    }
    
    // RESTART the answers stream AFTER reset
    _refreshAnswersStream(_getCurrentRoomId());
    
    _startQuestionTimer();
    _emitQuizState();
    
  } else {
    // Quiz finished
    _questionTimer?.cancel();
    _answersSub?.cancel();
    emit(RoomState.quizFinished(
      totalQuestions: _questions.length,
      correctAnswers: _correctCount,
      players: _currentPlayers,
    ));
  }
}



  /// 🔄 Polling for player answers
  void _startAnswerPolling(String roomId) {
    _answersPollTimer?.cancel();

    print('🔄 STARTING answer polling for room: $roomId');

    _answersPollTimer = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) async {
      if (isClosed) {
        timer.cancel();
        return;
      }

      print('🔄 POLLING: Checking for player answers...');

      final result = await getPlayerAnswersUseCase(roomId);
      result.fold(
        (failure) {
          print('❌ Polling failed: $failure');
        },
        (Map<String, String> answers) {
          print('🔄 POLLING: Got answers: $answers');
          print(
            '🔄 POLLING: Current players: ${_currentPlayers.map((p) => p.userId).toList()}',
          );

          // Convert Map<String, String> to Map<String, String?>
          final Map<String, String?> updatedAnswers = {};
          answers.forEach((key, value) {
            updatedAnswers[key] = value;
          });

          // Only update if answers changed
          if (_hasAnswersChanged(updatedAnswers)) {
            print('🔄 POLLING: Answers changed, updating state');
            _playerAnswers = updatedAnswers;

            if (_isInQuizMode()) {
              _emitQuizState();
              _checkAllPlayersAnswered();
            }
          } else {
            print('🔄 POLLING: No changes in answers');
          }
        },
      );
    });
  }

  /// 🔍 Check if answers have changed
  bool _hasAnswersChanged(Map<String, String?> newAnswers) {
    if (_playerAnswers.length != newAnswers.length) {
      print(
        '🔄 Answers changed: length different (${_playerAnswers.length} vs ${newAnswers.length})',
      );
      return true;
    }

    for (final entry in newAnswers.entries) {
      if (_playerAnswers[entry.key] != entry.value) {
        print(
          '🔄 Answers changed: ${entry.key} changed from ${_playerAnswers[entry.key]} to ${entry.value}',
        );
        return true;
      }
    }

    return false;
  }

  /// 🧪 Debug method to monitor state
  void _debugQuizState() {
    print(
      '🐛 DEBUG: Question $_currentQuestionIndex, Time $_remainingTime, Players ${_currentPlayers.length}',
    );
    print('🐛 DEBUG: Answers: $_playerAnswers');
    print(
      '🐛 DEBUG: All answered: ${_currentPlayers.every((p) => _playerAnswers[p.userId] != null)}',
    );
  }

  /// 🎯 Watch player answers in real-time
/// 🎯 Watch player answers in real-time
void _watchPlayerAnswers(String roomId) {
  _answersSub?.cancel();

  print('🎯 STARTING real-time player answers watcher for room: $roomId');
  print('🎯 Current question: ${_currentQuestionIndex + 1}');
  print('🎯 Current local answers: $_playerAnswers');

  _answersSub = watchPlayerAnswersUseCase(roomId).listen((either) {
    if (isClosed) return;
    
    either.fold(
      (failure) {
        print('❌ Real-time stream error: $failure');
        _startAnswerPolling(roomId);
      },
      (Map<String, String> answers) {
        print('🎯 REAL-TIME: Got answers: $answers');
        print('🎯 REAL-TIME: Current players: ${_currentPlayers.map((p) => p.userId).toList()}');
        
        // Convert Map<String, String> to Map<String, String?>
        final Map<String, String?> updatedAnswers = {};
        answers.forEach((key, value) {
          updatedAnswers[key] = value;
        });
        
        // Update the playerAnswers with real-time data
        _playerAnswers = updatedAnswers;
        print('🎯 UPDATED playerAnswers: $_playerAnswers');
        
        if (_isInQuizMode()) {
          _emitQuizState();
          _checkAllPlayersAnswered(); // Check again after updating answers
        }
      },
    );
  }, onError: (error) {
    print('❌ Real-time stream onError: $error');
    _startAnswerPolling(roomId);
  }, cancelOnError: true);
}

  /// 🔄 Force refresh the answers stream
  void _refreshAnswersStream(String roomId) {
    print('🔄 FORCE REFRESH: Restarting answers stream');

    _answersSub?.cancel();

    // Small delay to ensure clean restart
    Future.delayed(const Duration(milliseconds: 300), () {
      _watchPlayerAnswers(roomId);
    });
  }

  @override
  Future<void> close() async {
    print('🧹 Cleaning up RoomCubit...');
    _questionTimer?.cancel();
    _answersPollTimer?.cancel(); // Add this
    await _roomsSubscription?.cancel();
    await _roomsSub?.cancel();
    await _playersSub?.cancel();
    await _roomWatcher?.cancel();
    await _answersSub?.cancel(); // Add this
    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;
    _answersSub = null; // Add this
    _answersPollTimer = null; // Add this
    return super.close();
  }
}
