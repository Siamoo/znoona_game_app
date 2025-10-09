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

  @override
  void initState() {
    super.initState();
    // Start the quiz with the provided questions
    context.read<RoomCubit>().startQuiz(widget.questions);
  }

  void _startTimer(int remainingTime) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime > 0) {
        remainingTime--;
        // Timer updates are handled by cubit, we just track locally for UI
      } else {
        t.cancel();
      }
    });
  }

  void _selectAnswer(String answer, String correctAnswer) {
    final currentUserId = _getCurrentUserId();
    
    // Send answer to RoomCubit for multiplayer synchronization
    context.read<RoomCubit>().selectAnswer(answer);
  }

  void _showQuizResults(int totalQuestions, int correctAnswers) {
    // Show results dialog or navigate to results screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Finished!'),
        content: Text('Your score: $correctAnswers/$totalQuestions'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to room
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
        state.whenOrNull(
          quizStarted: (
            questions,
            currentQuestionIndex,
            remainingTime,
            playerAnswers,
            selectedAnswer,
            correctCount,
            isWaitingForPlayers,
            players,
          ) {
            // Start/restart timer when question changes
            if ((_timer == null || !_timer!.isActive) && 
                !isWaitingForPlayers && 
                remainingTime > 0) {
              _startTimer(remainingTime);
            }
          },
          questionTimeUp: (players) {
            _timer?.cancel();
          },
          allPlayersAnswered: (players) {
            _timer?.cancel();
          },
          quizFinished: (totalQuestions, correctAnswers, players) {
            _timer?.cancel();
            _showQuizResults(totalQuestions, correctAnswers);
          },
        );
      },
      child: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          return state.maybeWhen(
            quizStarted: (
              questions,
              currentQuestionIndex,
              remainingTime,
              playerAnswers,
              selectedAnswer,
              correctCount,
              isWaitingForPlayers,
              players,
            ) => _buildQuizContent(
              questions: questions,
              currentQuestionIndex: currentQuestionIndex,
              remainingTime: remainingTime,
              playerAnswers: playerAnswers,
              selectedAnswer: selectedAnswer,
              correctCount: correctCount,
              isWaitingForPlayers: isWaitingForPlayers,
              players: players,
            ),
            questionTimeUp: (players) => _buildTimeUpContent(),
            allPlayersAnswered: (players) => _buildAllAnsweredContent(),
            quizFinished: (total, correct, players) => _buildResultsContent(total, correct),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildQuizContent({
    required List<Question> questions,
    required int currentQuestionIndex,
    required int remainingTime,
    required Map<String, String?> playerAnswers,
    required String? selectedAnswer,
    required int correctCount,
    required bool isWaitingForPlayers,
    required List<RoomPlayer> players,
  }) {
    if (questions.isEmpty) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomAppBar(
                title: 'Room ${widget.room.code}',
              ),
              SizedBox(height: 300.sp),
              const Center(child: Text('No questions found.')),
            ],
          ),
        ),
      );
    }

    final question = questions[currentQuestionIndex];
    final currentUserId = _getCurrentUserId();
    final hasAnswered = playerAnswers.containsKey(currentUserId) && 
                       playerAnswers[currentUserId] != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              // App Bar with room info
              CustomAppBar(
                title: 'Room ${widget.room.code}',
                icon: Icons.close,
                otherText:
                    '${currentQuestionIndex + 1}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${questions.length}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
              ),

              // Timer and Players Status
              _buildGameHeader(
                remainingTime, 
                playerAnswers, 
                isWaitingForPlayers, 
                players,
                correctCount,
                questions.length,
              ),

              SizedBox(height: 40.sp),

              // Question and Options
              Expanded(
                child: Column(
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
                        onTap: (hasAnswered || isWaitingForPlayers) ? null : () =>
                            _selectAnswer(option, question.correctAnswer),
                        isCorrect: isCorrect,
                        remainingTime: remainingTime,
                      );
                    }),
                  ],
                ),
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
    bool isWaitingForPlayers,
    List<RoomPlayer> players,
    int correctCount,
    int totalQuestions,
  ) {
    return Column(
      children: [
        // Timer and Score
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '⏳ $remainingTime',
              style: GoogleFonts.beiruti(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ZnoonaColors.text(context),
              ),
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

        // Waiting message if all players answered
        if (isWaitingForPlayers)
          Container(
            padding: EdgeInsets.all(8.sp),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '🎉 All players answered! Moving to next question...',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        SizedBox(height: 8.sp),

        // Players Status
        _buildPlayersStatus(playerAnswers, players),
      ],
    );
  }

  Widget _buildPlayersStatus(Map<String, String?> playerAnswers, List<RoomPlayer> players) {
    if (players.isEmpty) return const SizedBox();

    return Column(
      children: [
        Text(
          'Players Status:',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.sp),
        Wrap(
          spacing: 8.sp,
          children: players.map((RoomPlayer player) {
            final hasAnswered = playerAnswers.containsKey(player.userId) && 
                               playerAnswers[player.userId] != null;
            return Chip(
              label: Text(player.username),
              backgroundColor: hasAnswered ? Colors.green : Colors.orange,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTimeUpContent() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_off, size: 64.sp, color: Colors.orange),
              SizedBox(height: 16.sp),
              Text(
                'Time\'s Up!',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.sp),
              Text(
                'Moving to next question...',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAllAnsweredContent() {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 64.sp, color: Colors.green),
              SizedBox(height: 16.sp),
              Text(
                'All Players Answered!',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.sp),
              Text(
                'Moving to next question...',
                style: TextStyle(fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsContent(int totalQuestions, int correctAnswers) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, size: 64.sp, color: Colors.amber),
              SizedBox(height: 16.sp),
              Text(
                'Quiz Finished!',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.sp),
              Text(
                'Score: $correctAnswers/$totalQuestions',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 16.sp),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Room'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }
}