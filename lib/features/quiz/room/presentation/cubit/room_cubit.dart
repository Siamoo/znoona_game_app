import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/player_result.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/create_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_results_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_rooms_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/join_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/leave_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/mark_player_finished_usecase.dart';
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
    required this.getQuestionsUseCase,
    required this.submitAnswerUseCase,
    required this.resetAnswersUseCase,
    required this.watchPlayerAnswersUseCase,
    required this.markPlayerFinishedUseCase,
    required this.getRoomPlayersStreamResultsUseCase,
    required this.getRoomPlayersUseCase,
  }) : super(const RoomState.initial());

  final CreateRoomUseCase createRoomUseCase;
  final JoinRoomUseCase joinRoomUseCase;
  final LeaveRoomUseCase leaveRoomUseCase;
  final GetRoomsStreamUseCase getRoomsStreamUseCase;
  final GetRoomPlayersStreamUseCase getRoomPlayersStreamUseCase;
  final GetRoomQuestionsUseCase getRoomQuestionsUseCase;
  final StartGameUseCase startGameUseCase;
  final WatchRoomUseCase watchRoomUseCase;
  final GetQuestionsUseCase getQuestionsUseCase;
  final SubmitAnswerUseCase submitAnswerUseCase;
  final ResetAnswersUseCase resetAnswersUseCase;
  final WatchPlayerAnswersUseCase watchPlayerAnswersUseCase;
  final MarkPlayerFinishedUseCase markPlayerFinishedUseCase;
  final GetRoomPlayersStreamResultsUseCase getRoomPlayersStreamResultsUseCase;
  final GetRoomPlayersUseCase getRoomPlayersUseCase;

  StreamSubscription<dynamic>? _roomsSubscription;
  StreamSubscription<dynamic>? _roomsSub;
  StreamSubscription<dynamic>? _playersSub;
  StreamSubscription<dynamic>? _roomWatcher;
  StreamSubscription<dynamic>? _answersSub;
  StreamSubscription<Either<String, List<RoomPlayer>>>? _resultsSub;

  Timer? _questionTimer;
  int _remainingTime = 15;
  int _currentQuestionIndex = 0;
  int _correctCount = 0;
  String? _selectedAnswer;
  List<Question> _questions = [];
  Map<String, String?> _playerAnswers = {};
  List<RoomPlayer> _currentPlayers = [];
  String? _currentRoomId;
  Room? _currentRoom;

  void watchPlayerAnswers(String roomId) {
    _watchPlayerAnswers(roomId);
  }

  Future<void> createRoom({
    required String categoryId,
    required int timerDuration,
  }) async {
    emit(const RoomState.loading());

    final result = await createRoomUseCase(
      categoryId: categoryId,
      timerDuration: timerDuration,
    );

    result.fold(
      (failure) {
        emit(RoomState.error(failure));
        print('Create room failed: $failure');
      },
      (room) async {
        _currentRoomId = room.id;
        _currentRoom = room; // NEW: Set the current room

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
                _currentRoomId = room.id;
                _currentRoom = room; // NEW: Set the current room

                watchRoom(room.id);
                watchRoomPlayers(room.id);

                emit(RoomState.joined(room));
              } on Exception catch (_) {
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

  Future<void> leaveFromAllRooms() async {
    _roomsSubscription?.cancel();
    _roomsSub?.cancel();
    _playersSub?.cancel();
    _roomWatcher?.cancel();
    _questionTimer?.cancel();
    _answersSub?.cancel();

    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;
    _answersSub = null;

    _currentRoomId = null;
    _currentRoom = null;
    final result = await leaveRoomUseCase();

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (_) {
        emit(const RoomState.left());
      },
    );

    if (isClosed) return;
  }

  void watchRoom(String roomId) {
    _roomWatcher?.cancel();
    _roomWatcher = watchRoomUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (room) {
          if (room == null) return;

          _currentRoom = room; // NEW: Keep current room updated

          if (room.status == 'started') {
            emit(const RoomState.gameStarted());
          } else {
            emit(RoomState.roomUpdated(room));
          }
        },
      );
    });
  }

  void watchRoomPlayers(String roomId) {
    _playersSub?.cancel();
    _playersSub = getRoomPlayersStreamUseCase(roomId).listen((either) {
      if (isClosed) return;
      either.fold(
        (failure) => emit(RoomState.error(failure)),
        (players) {
          _currentPlayers = players;
          emit(RoomState.playersUpdated(players));
        },
      );
    });
  }

  Future<void> startGame(String roomId) async {
    emit(const RoomState.loading());

    try {
      final startResult = await startGameUseCase(roomId);

      if (isClosed) return;

      startResult.fold(
        (failure) => emit(RoomState.error(failure)),
        (_) async {
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

              final actualQuestionsResult = await getQuestionsUseCase(
                questionIds,
              );

              if (isClosed) return;

              actualQuestionsResult.fold(
                (failure) => emit(RoomState.error(failure)),
                (questions) {
                  // Pass the room's timer duration to startQuiz
                  startQuiz(
                    questions,
                    timerDuration: _currentRoom?.timerDuration,
                  );
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

  Future<void> getQuestions(List<String> questionIds) async {
    emit(const RoomState.loading());

    final result = await getQuestionsUseCase(questionIds);

    if (isClosed) return;

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (questions) => emit(RoomState.questionsListLoaded(questions)),
    );
  }

  void startQuiz(List<Question> questions, {int? timerDuration}) {
    _questions = questions;
    _currentQuestionIndex = 0;
    _correctCount = 0;
    _selectedAnswer = null;
    _playerAnswers.clear();

    // Use provided timerDuration, or room's timer, or default to 15
    _remainingTime = timerDuration ?? _currentRoom?.timerDuration ?? 15;

    _clearExistingAnswers(_getCurrentRoomId());
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

  Future<void> _clearExistingAnswers(String roomId) async {
    final resetResult = await resetAnswersUseCase(roomId);
    resetResult.fold(
      (failure) => print('Failed to clear existing answers: $failure'),
      (_) => print('Existing answers cleared'),
    );
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();

    _remainingTime = _currentRoom?.timerDuration ?? 15;

    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        _emitQuizState();
      } else {
        timer.cancel();
        print('⏰ Time finished - moving to next question');
        _handleTimeUp();
      }
    });
  }

  Future<void> selectAnswer(String answer) async {
    final currentUser = _getCurrentUserId();
    final currentQuestion = _questions[_currentQuestionIndex];

    if (_playerAnswers.containsKey(currentUser) &&
        _playerAnswers[currentUser] != null) {
      return;
    }

    if (_remainingTime <= 0) {
      return;
    }

    _selectedAnswer = answer;
    _playerAnswers[currentUser] = answer;

    final isCorrect = answer == currentQuestion.correctAnswer;
    if (isCorrect) {
      _correctCount++;
    }

    _emitQuizState();

    final result = await submitAnswerUseCase(
      roomId: _getCurrentRoomId(),
      userId: currentUser,
      selectedAnswer: answer,
      isCorrect: isCorrect,
    );

    result.fold(
      (failure) => print('Failed to submit answer to database: $failure'),
      (_) => print('Answer submitted to database successfully'),
    );
  }

  void _handleTimeUp() {
    _questionTimer?.cancel();
    _moveToNextQuestion();
  }

  void _moveToNextQuestion() {
    _answersSub?.cancel();

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _playerAnswers.clear();

      _resetAnswersForNewQuestion();
      _startQuestionTimer();
      _refreshAnswersStream(_getCurrentRoomId());

      _emitQuizState();

      print(
        '➡️ Moved to question ${_currentQuestionIndex + 1}/${_questions.length}',
      );
    } else {
      // QUIZ FINISHED - Emit quiz finished state
      _questionTimer?.cancel();
      _answersSub?.cancel();

      final totalQuestions = _questions.length;
      final correctAnswers = _correctCount;
      final finalScore = correctAnswers * 10;

      print(
        '🏁 Quiz finished! Questions: $totalQuestions, Correct: $correctAnswers',
      );

      // Emit quiz finished state first
      emit(
        RoomState.quizFinished(
          totalQuestions: totalQuestions,
          correctAnswers: correctAnswers,
          players: _currentPlayers,
        ),
      );

      // Then mark player as finished
      markPlayerFinished(
        roomId: _getCurrentRoomId(),
        finalScore: finalScore,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      );
    }
  }

  Future<void> _resetAnswersForNewQuestion() async {
    try {
      final resetResult = await resetAnswersUseCase(_getCurrentRoomId());
      resetResult.fold(
        (failure) => print('Failed to reset answers: $failure'),
        (_) => print('Answers reset for new question'),
      );
    } catch (e) {
      print('Reset failed: $e, continuing anyway');
    }
  }

  void _emitQuizState() {
    final allPlayersAnswered =
        _currentPlayers.isNotEmpty &&
        _currentPlayers.every(
          (player) => _playerAnswers[player.userId] != null,
        );

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

  bool _isInQuizMode() {
    return state is _QuizStarted;
  }

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }

  void _watchPlayerAnswers(String roomId) {
    _answersSub?.cancel();

    _answersSub = watchPlayerAnswersUseCase(roomId).listen(
      (either) {
        if (isClosed) return;

        either.fold(
          (failure) => print('Real-time stream error: $failure'),
          (Map<String, String> answers) {
            final Map<String, String?> updatedAnswers = {};
            answers.forEach((key, value) {
              updatedAnswers[key] = value;
            });

            _playerAnswers = updatedAnswers;

            if (_isInQuizMode()) {
              _emitQuizState();
            }
          },
        );
      },
      onError: (error) => print('Real-time stream onError: $error'),
      cancelOnError: true,
    );
  }

  void _refreshAnswersStream(String roomId) {
    _answersSub?.cancel();

    Future.delayed(const Duration(milliseconds: 100), () {
      _watchPlayerAnswers(roomId);
    });
  }

  Future<void> markPlayerFinished({
    required String roomId,
    required int finalScore,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final user = _getCurrentUserId();
    if (user == 'unknown') {
      emit(RoomState.error('User not logged in'));
      return;
    }

    try {
      print('🎯 Starting markPlayerFinished for user: $user');

      // STEP 1: First try to fix any broken state
      await _fixPlayerState(roomId, user);

      // STEP 2: Mark player as finished with comprehensive logging
      final result = await markPlayerFinishedUseCase(
        roomId: roomId,
        userId: user,
        finalScore: finalScore,
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          print('❌ Failed to mark player finished: $failure');
          // Try emergency fix
          _emergencyMarkFinished(
            roomId,
            user,
            finalScore,
            totalQuestions,
            correctAnswers,
          );
        },
        (_) {
          print('✅ Player marked as finished, starting results stream...');

          // STEP 3: Verify the update worked
          Future.delayed(const Duration(milliseconds: 500), () {
            if (isClosed) return;
            _verifyAndStartResults(
              roomId,
              user,
              totalQuestions,
              correctAnswers,
            );
          });
        },
      );
    } catch (e) {
      print('❌ Error in markPlayerFinished: $e');
      // Emergency fallback
      _emergencyMarkFinished(
        roomId,
        user,
        finalScore,
        totalQuestions,
        correctAnswers,
      );
    }
  }

  void _emergencyMarkFinished(
    String roomId,
    String userId,
    int finalScore,
    int totalQuestions,
    int correctAnswers,
  ) {
    print('🚨 Using emergency mark finished for user: $userId');

    _startProgressiveResultsStream(roomId, totalQuestions);
    _emitInitialFinishedState(roomId, totalQuestions, correctAnswers);
  }

  Future<void> _verifyAndStartResults(
    String roomId,
    String userId,
    int totalQuestions,
    int correctAnswers,
  ) async {
    try {
      // Verify the player was actually marked as finished
      final playersResult = await getRoomPlayersUseCase(roomId);

      playersResult.fold(
        (failure) {
          print('⚠️ Could not verify player state: $failure');
          // Start anyway
          _startProgressiveResultsStream(roomId, totalQuestions);
          _emitInitialFinishedState(roomId, totalQuestions, correctAnswers);
        },
        (players) {
          final currentPlayer = players.firstWhere(
            (p) => p.userId == userId,
            orElse: () => players.first,
          );

          print(
            '🔍 Verification - finished_quiz: ${currentPlayer.finishedQuiz}, '
            'finished_at: ${currentPlayer.finishedAt}',
          );

          if (!currentPlayer.finishedQuiz || currentPlayer.finishedAt == null) {
            print('🚨 Player not properly finished! Retrying...');
            // Retry the marking
            markPlayerFinishedUseCase(
              roomId: roomId,
              userId: userId,
              finalScore: currentPlayer.score, // Use existing score
            ).then((_) {
              _startProgressiveResultsStream(roomId, totalQuestions);
              _emitInitialFinishedState(roomId, totalQuestions, correctAnswers);
            });
          } else {
            // Everything is good
            _startProgressiveResultsStream(roomId, totalQuestions);
            _emitInitialFinishedState(roomId, totalQuestions, correctAnswers);
          }
        },
      );
    } catch (e) {
      print('❌ Error in verification: $e');
      // Start anyway
      _startProgressiveResultsStream(roomId, totalQuestions);
      _emitInitialFinishedState(roomId, totalQuestions, correctAnswers);
    }
  }

  Future<void> _fixPlayerState(String roomId, String userId) async {
    try {
      print('🔧 Preparing to fix player state for: $userId');
    } catch (e) {
      print('⚠️ Error in fixPlayerState: $e');
    }
  }

  void _startProgressiveResultsStream(String roomId, int totalQuestions) {
    _resultsSub?.cancel();

    _resultsSub = getRoomPlayersStreamResultsUseCase(roomId).listen(
      (either) {
        if (isClosed) return;

        either.fold(
          (failure) => print('Results stream error: $failure'),
          (players) {
            final results = _calculateProgressiveResults(
              players,
              totalQuestions,
            );
            final totalPlayers = results.length;
            final finishedPlayers = results.where((r) => r.finishedQuiz).length;
            final allFinished = finishedPlayers == totalPlayers;
            final userRank = _getUserRank(results);

            emit(
              RoomState.showingProgressiveResults(
                results: results,
                finishedPlayers: finishedPlayers,
                totalPlayers: totalPlayers,
                allPlayersFinished: allFinished,
                userRank: userRank,
              ),
            );

            if (allFinished) {
              _handleAllPlayersFinished(roomId);
            }
          },
        );
      },
      onError: (error) {
        print('Results stream onError: $error');
      },
    );
  }

  Future<void> _emitInitialFinishedState(
    String roomId,
    int totalQuestions,
    int correctAnswers,
  ) async {
    final result = await getRoomPlayersUseCase(roomId);

    if (isClosed) return;

    result.fold(
      (failure) => emit(RoomState.error(failure)),
      (players) {
        final totalPlayers = players.length;
        final finishedPlayers = players.where((p) => p.finishedQuiz).length;

        emit(
          RoomState.playerFinished(
            totalQuestions: totalQuestions,
            correctAnswers: correctAnswers,
            totalPlayers: totalPlayers,
            finishedPlayers: finishedPlayers,
          ),
        );
      },
    );
  }

  List<PlayerResult> _calculateProgressiveResults(
    List<RoomPlayer> players,
    int totalQuestions,
  ) {
    // Sort players by score (descending) and finished status
    final sortedPlayers = List<RoomPlayer>.from(players)
      ..sort((a, b) {
        // Finished players come before unfinished
        if (a.finishedQuiz && !b.finishedQuiz) return -1;
        if (!a.finishedQuiz && b.finishedQuiz) return 1;

        // Both finished - sort by score (desc) then finish time (asc)
        if (a.finishedQuiz && b.finishedQuiz) {
          if (a.score != b.score) return b.score.compareTo(a.score);

          // Handle null finished_at
          if (a.finishedAt == null && b.finishedAt == null) return 0;
          if (a.finishedAt == null) return 1; // Put nulls at the end
          if (b.finishedAt == null) return -1; // Put nulls at the end

          return a.finishedAt!.compareTo(b.finishedAt!);
        }

        // Both unfinished - sort by current score (desc)
        return b.score.compareTo(a.score);
      });

    final currentUserId = _getCurrentUserId();

    // Calculate ranks with ties handling
    return _assignRanksWithTies(sortedPlayers, totalQuestions, currentUserId);
  }

  List<PlayerResult> _assignRanksWithTies(
    List<RoomPlayer> sortedPlayers,
    int totalQuestions,
    String currentUserId,
  ) {
    final results = <PlayerResult>[];
    int currentRank = 1;
    int index = 0;

    while (index < sortedPlayers.length) {
      final currentPlayer = sortedPlayers[index];

      // If player is not finished, assign rank 0
      if (!currentPlayer.finishedQuiz) {
        results.add(
          _createPlayerResult(
            player: currentPlayer,
            rank: 0,
            totalQuestions: totalQuestions,
            currentUserId: currentUserId,
          ),
        );
        index++;
        continue;
      }

      // Find all players with the same score (ties)
      final currentScore = currentPlayer.score;
      final tiedPlayers = <RoomPlayer>[];

      int j = index;
      while (j < sortedPlayers.length &&
          sortedPlayers[j].finishedQuiz &&
          sortedPlayers[j].score == currentScore) {
        tiedPlayers.add(sortedPlayers[j]);
        j++;
      }

      // Assign the same rank to all tied players
      for (final tiedPlayer in tiedPlayers) {
        results.add(
          _createPlayerResult(
            player: tiedPlayer,
            rank: currentRank,
            totalQuestions: totalQuestions,
            currentUserId: currentUserId,
          ),
        );
      }

      // Move to next group and update rank
      index += tiedPlayers.length;
      currentRank += tiedPlayers.length;
    }

    return results;
  }

  PlayerResult _createPlayerResult({
    required RoomPlayer player,
    required int rank,
    required int totalQuestions,
    required String currentUserId,
  }) {
    return PlayerResult(
      userId: player.userId,
      username: player.username,
      score: player.score,
      correctAnswers: player.score ~/ 10, // Adjust based on your scoring
      totalQuestions: totalQuestions,
      rank: rank,
      isCurrentUser: player.userId == currentUserId,
      finishedQuiz: player.finishedQuiz,
      finishedAt: player.finishedAt,
      avatarUrl: player.avatarUrl,
    );
  }

  // KEEP all your existing helper methods:
  int _getUserRank(List<PlayerResult> results) {
    final currentUserId = _getCurrentUserId();
    final userResult = results.firstWhere(
      (result) => result.userId == currentUserId,
      orElse: () => results.firstWhere((r) => r.rank > 0),
    );
    return userResult.rank;
  }

  void _handleAllPlayersFinished(String roomId) {
    print('🎉 All players finished! Room: $roomId');
  }

  @override
  Future<void> close() async {
    _questionTimer?.cancel();
    await _roomsSubscription?.cancel();
    await _roomsSub?.cancel();
    await _playersSub?.cancel();
    await _roomWatcher?.cancel();
    await _answersSub?.cancel();
    await _resultsSub?.cancel();
    _roomsSubscription = null;
    _roomsSub = null;
    _playersSub = null;
    _roomWatcher = null;
    _answersSub = null;
    _resultsSub = null;
    _currentRoomId = null;
    _currentRoom = null;
    return super.close();
  }
}
