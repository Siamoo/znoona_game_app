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
  List<Question> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  int _currentRemainingTime = 15;
  Map<String, String?> _currentPlayerAnswers = {};
  String? _currentSelectedAnswer;
  int _currentCorrectCount = 0;
  bool _currentIsWaitingForPlayers = false;
  List<RoomPlayer> _currentPlayers = [];

  @override
  void initState() {
    super.initState();
    _currentQuestions = widget.questions;
    context.read<RoomCubit>().startQuiz(widget.questions);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_currentRemainingTime > 0) {
        setState(() {
          _currentRemainingTime--;
        });
      } else {
        t.cancel();
      }
    });
  }

  void _selectAnswer(String answer) {
    final currentUserId = _getCurrentUserId();

    setState(() {
      _currentSelectedAnswer = answer;
      _currentPlayerAnswers = Map<String, String?>.from(_currentPlayerAnswers);
      _currentPlayerAnswers[currentUserId] = answer;
    });

    context.read<RoomCubit>().selectAnswer(answer);
  }

  void _showQuizResults(int totalQuestions, int correctAnswers) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Finished!'),
        content: Text('Your score: $correctAnswers/$totalQuestions'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
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
        print('🎯 ROOM QUIZ LISTENER: ${state.runtimeType}');

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
            print('🔄 Updating quiz state - Question: ${currentQuestionIndex + 1}');

            final mutablePlayerAnswers = Map<String, String?>.from(playerAnswers);

            setState(() {
              _currentQuestions = questions;
              _currentQuestionIndex = currentQuestionIndex;
              _currentRemainingTime = remainingTime;
              _currentPlayerAnswers = mutablePlayerAnswers;
              _currentSelectedAnswer = selectedAnswer;
              _currentCorrectCount = correctCount;
              _currentIsWaitingForPlayers = isWaitingForPlayers;
              _currentPlayers = players;
            });

            if ((_timer == null || !_timer!.isActive) &&
                !isWaitingForPlayers &&
                remainingTime > 0) {
              _startTimer();
            }
          },
          // REMOVED questionResults listener - no more results screen
          quizFinished: (totalQuestions, correctAnswers, players) {
            _timer?.cancel();
            _showQuizResults(totalQuestions, correctAnswers);
          },
        );
      },
      child: _buildQuizContent(
        questions: _currentQuestions.isNotEmpty ? _currentQuestions : widget.questions,
        currentQuestionIndex: _currentQuestionIndex,
        remainingTime: _currentRemainingTime,
        playerAnswers: _currentPlayerAnswers,
        selectedAnswer: _currentSelectedAnswer,
        correctCount: _currentCorrectCount,
        isWaitingForPlayers: _currentIsWaitingForPlayers,
        players: _currentPlayers,
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
    final hasAnswered = playerAnswers.containsKey(currentUserId) && 
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
                isWaitingForPlayers,
                players,
                correctCount,
                questions.length,
              ),

              SizedBox(height: 40.sp),

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
                        onTap: (hasAnswered || isWaitingForPlayers)
                            ? null
                            : () => _selectAnswer(option),
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
  final currentUserId = _getCurrentUserId();
  final hasAnswered = playerAnswers.containsKey(currentUserId) && 
                      playerAnswers[currentUserId] != null;

  return Column(
    children: [
      // Timer and Score
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

      // SCENARIO 2: All players answered message
      if (isWaitingForPlayers)
        Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.green,
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

      // SCENARIO 1: Time running low warning
      if (remainingTime <= 5 && !isWaitingForPlayers)
        Container(
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '⏰ Time running out! Answer quickly!',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.orange,
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
  Widget _buildPlayersStatus(
    Map<String, String?> playerAnswers,
    List<RoomPlayer> players,
  ) {
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
          children: players.map((player) {
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

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? 'unknown';
  }
}
