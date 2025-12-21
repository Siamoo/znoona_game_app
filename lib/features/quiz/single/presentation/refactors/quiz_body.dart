import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/cubit/questions_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/screen/results_screen.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/option_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

  void _showFullScreenImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        backgroundColor: Colors.black,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 3,
              initialScale: PhotoViewComputedScale.contained,
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              loadingBuilder: (context, event) => Center(
                child: CircularProgressIndicator(
                  color: ZnoonaColors.main(context),
                ),
              ),
            ),
            Positioned(
              top: 50.h,
              right: 20.w,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30.sp,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add Google Drive URL conversion function
  String? _convertGoogleDriveUrl(String? url) {
    if (url == null || url.isEmpty) return null;

    if (url.contains('drive.google.com')) {
      final regex = RegExp(r'/d/([a-zA-Z0-9_-]+)');
      final match = regex.firstMatch(url);

      if (match != null) {
        final fileId = match.group(1);
        return 'https://drive.google.com/uc?export=view&id=$fileId';
      }
    }

    return url;
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
            // Convert Google Drive URL if needed
            final imageUrl = _convertGoogleDriveUrl(question.image);

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView(
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
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.sp),

                      if (imageUrl != null && imageUrl.isNotEmpty)
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showFullScreenImage(imageUrl),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  height: 200.h,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: ZnoonaColors.main(context),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      height: 200.h,
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.broken_image,
                                              size: 50.sp,
                                              color: ZnoonaColors.text(
                                                context,
                                              ).withOpacity(0.5),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              'Failed to load image',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: ZnoonaColors.text(
                                                  context,
                                                ).withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Tap image to zoom',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ZnoonaColors.text(
                                  context,
                                ).withOpacity(0.7),
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20.sp),
                          ],
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            question.question,
                            style: GoogleFonts.scheherazadeNew(
                              fontSize: imageUrl != null && imageUrl.isNotEmpty
                                  ? 18.sp
                                  : 22.sp, // Adjust font size if image is present
                              fontWeight: FontWeight.bold,
                              color: ZnoonaColors.text(context),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.sp),
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
                          SizedBox(height: 20.sp), // Extra space at bottom
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
