import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/cubit/questions_cubit.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/screen/results_screen.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/widgets/option_button.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });
  final String categoryId;
  final String categoryName;

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  int currentQuestionIndex = 0;
  int remainingTime = 15;
  Timer? timer;
  String? selectedAnswer;
  int correctCount = 0;

  List<Question> get questions =>
      context.read<QuestionsCubit>().state.maybeWhen(
        loaded: (q) => q,
        orElse: () => <Question>[],
      );

  @override
  void initState() {
    super.initState();
    context.read<QuestionsCubit>().loadQuestions(widget.categoryId);
  }

  void startTimer() {
    timer?.cancel();
    setState(() => remainingTime = 15);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime > 0) {
        setState(() => remainingTime--);
      } else {
        t.cancel();
        goToNextQuestion();
      }
    });
  }

  void selectAnswer(String answer, String correctAnswer) {
    setState(() {
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        correctCount++;
      }
    });
    timer?.cancel();

    Future.delayed(const Duration(seconds: 2), goToNextQuestion);
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
      startTimer();
    } else {
      ZnoonaNavigate.pushReplacementTo(
        context,
        ResultsScreen(
          totalQuestions: questions.length,
          correctAnswers: correctCount,
        ),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (msg) => Center(child: Text(msg)),
          loaded: (questions) {
            if (questions.isEmpty) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: widget.categoryName,
                      ),
                      SizedBox(height: 300.sp),
                      const Center(child: Text('No questions found.')),
                    ],
                  ),
                ),
              );
            }

            if (timer == null || !timer!.isActive) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                startTimer();
              });
            }

            final question = questions[currentQuestionIndex];

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: widget.categoryName,
                        icon: Icons.close,
                        otherText:
                            '${currentQuestionIndex + 1}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${questions.length}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
                      ),
                      Text(
                        '⏳ $remainingTime',
                        style: GoogleFonts.beiruti(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                        ),
                      ),
                      SizedBox(height: 80.sp),
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
                              onTap: () =>
                                  selectAnswer(option, question.correctAnswer),
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
          },
        );
      },
    );
  }
}
