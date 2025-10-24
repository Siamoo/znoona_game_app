import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_results_screen.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/Quiz/empty_quiz_body.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/Quiz/room_game_header.dart';
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
  List<Question> _currentQuestions = [];
  int _currentQuestionIndex = 0;
  Map<String, String?> _currentPlayerAnswers = {};
  String? _currentSelectedAnswer;
  int _currentCorrectCount = 0;
  List<RoomPlayer> _currentPlayers = [];

  @override
  void initState() {
    super.initState();
    _currentQuestions = widget.questions;
    // Start with initial state using the passed questions
    _currentPlayers = [];
    context.read<RoomCubit>().startQuiz(widget.questions);
    context.read<RoomCubit>().watchPlayerAnswers(widget.room.id);
  }

  Future<void> _selectAnswer(String answer) async {
    final currentUserId = _getCurrentUserId();
    final currentQuestion = _currentQuestions[_currentQuestionIndex];

    // Check if user already answered
    if (_currentPlayerAnswers.containsKey(currentUserId) &&
        _currentPlayerAnswers[currentUserId] != null) {
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
    await context.read<RoomCubit>().selectAnswer(answer);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomCubit, RoomState>(
      listener: (context, state) {
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
                final mutablePlayerAnswers = Map<String, String?>.from(
                  playerAnswers,
                );
                setState(() {
                  _currentQuestions = questions;
                  _currentQuestionIndex = currentQuestionIndex;
                  _currentPlayerAnswers = mutablePlayerAnswers;
                  _currentSelectedAnswer = selectedAnswer;
                  _currentCorrectCount = correctCount;
                  _currentPlayers = players;
                });
              },

          quizFinished: (totalQuestions, correctAnswers, players) {
            _navigateToResultsScreen();
          },
        );
      },
      child: BlocBuilder<RoomCubit, RoomState>(
        builder: (context, state) {
          return state.maybeWhen(
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
                  return _buildQuizContent(
                    questions: questions,
                    currentQuestionIndex: currentQuestionIndex,
                    remainingTime: remainingTime,
                    playerAnswers: playerAnswers,
                    selectedAnswer: selectedAnswer,
                    correctCount: correctCount,
                    players: players,
                  );
                },
            orElse: () => _buildQuizContent(
              questions: _currentQuestions,
              currentQuestionIndex: _currentQuestionIndex,
              remainingTime: widget.room.timerDuration,
              playerAnswers: _currentPlayerAnswers,
              selectedAnswer: _currentSelectedAnswer,
              correctCount: _currentCorrectCount,
              players: _currentPlayers,
            ),
          );
        },
      ),
    );
  }

  void _navigateToResultsScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ZnoonaNavigate.pushReplacementTo(
          context,
          RoomResultsScreen(roomId: widget.room.id),
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
      return EmptyQuizBody(roomCode: widget.room.code);
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
                title: 'Room',
                icon: Icons.close,
                otherText:
                    '${currentQuestionIndex + 1}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${questions.length}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
              ),

              RoomGameHeader(
                context: context,
                remainingTime: remainingTime,
                playerAnswers: playerAnswers,
                players: players,
                correctCount: correctCount,
                totalQuestions: questions.length,
                 currentUserId: currentUserId,
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
}
