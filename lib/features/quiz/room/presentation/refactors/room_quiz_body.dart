import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/progressive_results_screen.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/widgets/option_button.dart';

class RoomQuizBody extends StatefulWidget {
  const RoomQuizBody({
    required this.room,
    required this.questions,
    super.key,
  });
  final Room room;
  final List<Question> questions;

  @override
  State<RoomQuizBody> createState() => _RoomQuizBodyState();
}

class _RoomQuizBodyState extends State<RoomQuizBody> {
  Timer? _timer;
  List<Question> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  int _currentRemainingTime = 15;
  Map<String, String?> _currentPlayerAnswers = {};
  String? _currentSelectedAnswer;
  int _currentCorrectCount = 0;
  List<RoomPlayer> _currentPlayers = [];

  @override
  void initState() {
    super.initState();
    _currentQuestions = widget.questions;
    context.read<RoomCubit>().startQuiz(widget.questions);
    context.read<RoomCubit>().watchPlayerAnswers(widget.room.id);
  }

  void _startTimer() {
    _timer?.cancel();
    _currentRemainingTime = 15;

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_currentRemainingTime > 0) {
        setState(() {
          _currentRemainingTime--;
        });
      } else {
        t.cancel();
        print('⏰ Time up in UI');
      }
    });
  }

  void _selectAnswer(String answer) {
    final currentUserId = _getCurrentUserId();
    final currentQuestion = _currentQuestions[_currentQuestionIndex];

    // Prevent double answering
    if (_currentPlayerAnswers.containsKey(currentUserId) &&
        _currentPlayerAnswers[currentUserId] != null) {
      return;
    }

    if (_currentRemainingTime <= 0) {
      return;
    }

    _currentSelectedAnswer = answer;
    _currentPlayerAnswers = Map<String, String?>.from(_currentPlayerAnswers);
    _currentPlayerAnswers[currentUserId] = answer;

    final isCorrect = answer == currentQuestion.correctAnswer;
    if (isCorrect) {
      _currentCorrectCount++;
    }

    _emitQuizState();

    // Submit answer to database
    context.read<RoomCubit>().selectAnswer(answer);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
        print('🎯 ROOM QUIZ LISTENER: ${state.runtimeType}');

        state.whenOrNull(
          quizStarted:
              (
                questions,
                currentQuestionIndex,
                remainingTime,
                playerAnswers,
                selectedAnswer,
                correctCount,
                isWaitingForPlayers,
                players,
              ) {
                print(
                  '🔄 Updating quiz state - Question: ${currentQuestionIndex + 1}, '
                  'Time: $remainingTime',
                );

                final mutablePlayerAnswers = Map<String, String?>.from(
                  playerAnswers,
                );

                setState(() {
                  _currentQuestions = questions;
                  _currentQuestionIndex = currentQuestionIndex;
                  _currentRemainingTime = remainingTime;
                  _currentPlayerAnswers = mutablePlayerAnswers;
                  _currentSelectedAnswer = selectedAnswer;
                  _currentCorrectCount = correctCount;
                  _currentPlayers = players;
                });

                // Start timer if not already running and time is > 0
                if ((_timer == null || !_timer!.isActive) &&
                    remainingTime > 0) {
                  _startTimer();
                }
              },

          quizFinished: (totalQuestions, correctAnswers, players) {
            print('🏁 Quiz finished - navigating to results');
            _timer?.cancel();
            _navigateToResultsScreen();
          },
        );
      },
      child: _buildQuizContent(
        questions: _currentQuestions.isNotEmpty
            ? _currentQuestions
            : widget.questions,
        currentQuestionIndex: _currentQuestionIndex,
        remainingTime: _currentRemainingTime,
        playerAnswers: _currentPlayerAnswers,
        selectedAnswer: _currentSelectedAnswer,
        correctCount: _currentCorrectCount,
        players: _currentPlayers,
      ),
    );
  }

  void _navigateToResultsScreen() {
    print('🚀 Navigating to results screen for room: ${widget.room.id}');

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProgressiveResultsScreen(roomId: widget.room.id),
          ),
        );
      }
    });
  }

  void _emitQuizState() {
    if (mounted) {
      setState(() {});
    }
  }

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }

  Widget _buildQuizContent({
    required List<Question> questions,
    required int currentQuestionIndex,
    required int remainingTime,
    required Map<String, String?> playerAnswers,
    required String? selectedAnswer,
    required int correctCount,
    required List<RoomPlayer> players,
  }) {
    if (questions.isEmpty) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomAppBar(title: 'Room ${widget.room.code}'),
              SizedBox(height: 300.sp),
              const Center(child: Text('No questions found.')),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestionIndex];
    final currentUserId = _getCurrentUserId();
    final hasAnswered =
        playerAnswers.containsKey(currentUserId) &&
        playerAnswers[currentUserId] != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Room ${widget.room.code}',
                icon: Icons.close,
                otherText:
                    '${currentQuestionIndex + 1}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${questions.length}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
              ),

              _buildGameHeader(
                remainingTime,
                playerAnswers,
                players,
                correctCount,
                questions.length,
              ),

              SizedBox(height: 40.sp),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    question.question,
                    style: GoogleFonts.beiruti(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...question.options.map((option) {
                    final isSelected = option == selectedAnswer;
                    final isCorrect = option == question.correctAnswer;

                    return OptionButton(
                      option: option,
                      isSelected: isSelected,
                      selectedAnswer: selectedAnswer,
                      onTap: hasAnswered ? null : () => _selectAnswer(option),
                      isCorrect: isCorrect,
                      remainingTime: remainingTime,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameHeader(
    int remainingTime,
    Map<String, String?> playerAnswers,
    List<RoomPlayer> players,
    int correctCount,
    int totalQuestions,
  ) {
    final currentUserId = _getCurrentUserId();
    final hasAnswered =
        playerAnswers.containsKey(currentUserId) &&
        playerAnswers[currentUserId] != null;

    final connectedPlayers = players.where((p) => p.isConnected).toList();
    final answeredPlayers = connectedPlayers
        .where(
          (p) =>
              playerAnswers.containsKey(p.userId) &&
              playerAnswers[p.userId] != null,
        )
        .length;
    final totalConnected = connectedPlayers.length;
    final progress = totalConnected > 0
        ? answeredPlayers / totalConnected
        : 0.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '⏳ $remainingTime',
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context),
                  ),
                ),
                if (remainingTime <= 5)
                  Text(
                    'Time running out!',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            Text(
              'Score: $correctCount/$totalQuestions',
              style: GoogleFonts.beiruti(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ZnoonaColors.text(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.sp),

        // Time running out warning
        if (remainingTime <= 5)
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, color: Colors.orange, size: 16.sp),
                SizedBox(width: 8.sp),
                Text(
                  'Time running out! Answer quickly!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(height: 50.sp),

        SizedBox(height: 8.sp),

        // Players Status with progress
        _buildPlayersStatus(
          playerAnswers,
          players,
          progress,
          answeredPlayers,
          totalConnected,
        ),
      ],
    );
  }

  Widget _buildPlayersStatus(
    Map<String, String?> playerAnswers,
    List<RoomPlayer> players,
    double progress,
    int answeredPlayers,
    int totalConnected,
  ) {
    if (players.isEmpty) return const SizedBox();

    return Column(
      children: [
        // Progress bar
        Container(
          width: double.infinity,
          height: 8.sp,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.sp),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 8.sp,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.sp),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: MediaQuery.of(context).size.width * progress,
                height: 8.sp,
                decoration: BoxDecoration(
                  color: _getProgressColor(progress),
                  borderRadius: BorderRadius.circular(4.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.sp),

        // Players list
        Wrap(
          spacing: 8.sp,
          children: players.where((p) => p.isConnected).map((player) {
            final hasAnswered =
                playerAnswers.containsKey(player.userId) &&
                playerAnswers[player.userId] != null;
            return Chip(
              label: Text(player.username),
              backgroundColor: hasAnswered ? Colors.green : Colors.orange,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
              avatar: hasAnswered
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : Icon(Icons.person, size: 16.sp, color: Colors.white),
            );
          }).toList(),
        ),

        // Progress text
        Text(
          '$answeredPlayers/$totalConnected players answered',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.5) return Colors.orange;
    if (progress < 1.0) return Colors.blue;
    return Colors.green;
  }
}
