import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/cubit/questions_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/screen/results_screen.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/option_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:vibration/vibration.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({
    required this.categoryId,
    required this.categoryName,
    required this.timerDuration,
    super.key,
  });

  final String categoryId;
  final String categoryName;
  final int timerDuration;

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  int currentQuestionIndex = 0;
  int remainingTime = 0; // Will be initialized with timerDuration
  Timer? timer;
  String? selectedAnswer;
  int correctCount = 0;
  bool _hasPlayedTimerWarning = false;

  List<Question> get questions =>
      context.read<QuestionsCubit>().state.maybeWhen(
        loaded: (q) => q,
        orElse: () => <Question>[],
      );

  @override
  void initState() {
    super.initState();
    context.read<QuestionsCubit>().loadQuestions(widget.categoryId);
    remainingTime = widget.timerDuration;
  }

  void startTimer() {
    timer?.cancel();
    setState(() {
      remainingTime = widget.timerDuration;
      _hasPlayedTimerWarning = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime > 0) {
        setState(() => remainingTime--);

        // Play timer warning sound in last 3 seconds only
        if (remainingTime <= 3 &&
            remainingTime > 0 &&
            !_hasPlayedTimerWarning) {
          _hasPlayedTimerWarning = true;
          _playTimerWarningSound();
          _showTimerWarning();
        }
      } else {
        t.cancel();
        _vibrateTimeFinished(); // Add vibration when time finishes
        goToNextQuestion();
      }
    });
  }

  Future<void> _vibrateWrongAnswer() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isVibrationEnabled) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 200); // Short vibration for wrong answer
      }
    }
  }

  Future<void> _vibrateTimeFinished() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isVibrationEnabled) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(pattern: [500, 200, 500]);
      }
    }
  }

  void _showTimerWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ZnoonaTexts.tr(context, LangKeys.lastThreeSeconds)),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.orange,
      ),
    );
  }

  // Audio helper methods
  Future<void> _playCorrectSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playCorrectSound();
    }
  }

  Future<void> _playWrongSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playWrongSound();
    }
  }

  Future<void> _playTimerWarningSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playTimerWarningSound();
    }
  }

  Future<void> _playWinSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playWinSound();
    }
  }

  Future<void> _playGoodResultSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playGoodResultSound();
    }
  }

  Future<void> _playBadResultSound() async {
    final appState = context.read<AppCubit>().state;
    if (appState.isSoundEnabled) {
      await GetIt.I<AudioService>().playBadResultSound();
    }
  }

  void selectAnswer(String answer, String correctAnswer) {
    final appState = context.read<AppCubit>().state;

    setState(() {
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        correctCount++;
        if (appState.isSoundEnabled) {
          _playCorrectSound();
        }
      } else {
        // Wrong answer - play sound and vibrate
        if (appState.isSoundEnabled) {
          _playWrongSound();
        }
        _vibrateWrongAnswer(); // Add vibration for wrong answer
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
        _hasPlayedTimerWarning = false;
      });
      startTimer();
    } else {
      // Play result sound based on score
      final appState = context.read<AppCubit>().state;
      final double scorePercentage = correctCount / questions.length * 100;

      if (appState.isSoundEnabled) {
        if (scorePercentage >= 70) {
          _playWinSound();
        } else if (scorePercentage >= 50) {
          _playGoodResultSound();
        } else {
          _playBadResultSound();
        }
      }

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
    // Check if the image URL is valid before showing
    if (imageUrl.isEmpty) return;

    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: ZnoonaColors.main(context),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      ZnoonaTexts.tr(context, LangKeys.loadingImage),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        size: 60.sp,
                        color: Colors.white54,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        ZnoonaTexts.tr(context, LangKeys.failedToLoadImage),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        ZnoonaTexts.tr(context, LangKeys.imageMovedOrDeleted),
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              heroAttributes: PhotoViewHeroAttributes(
                tag: imageUrl,
                transitionOnUserGestures: true,
              ),
              enableRotation: true,
              basePosition: Alignment.center,
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              right: 20.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 20.h,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    ZnoonaTexts.tr(context, LangKeys.pinchToZoom),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    ZnoonaTexts.tr(context, LangKeys.rotateDevice),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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

  String _formatTime(int seconds) {
    if (seconds >= 60) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return seconds.toString().padLeft(2, '0');
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      CustomAppBar(
                        title: widget.categoryName,
                      ),
                      SizedBox(height: 300.sp),
                      Center(
                        child: Text(
                          ZnoonaTexts.tr(context, LangKeys.noQuestionsFound),
                        ),
                      ),
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
                      SizedBox(height: 20.h),

                      // Timer with progress indicator
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: remainingTime / widget.timerDuration,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              remainingTime > widget.timerDuration * 0.3
                                  ? Colors.green
                                  : remainingTime > widget.timerDuration * 0.1
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                            minHeight: 8.h,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          SizedBox(height: 10.h),
                          _buildSoundAndVibrationControl(),
                        ],
                      ),
                      SizedBox(height: 20.sp),

                      if (imageUrl != null && imageUrl.isNotEmpty)
                        Column(
                          children: [
                            Text(
                              ZnoonaTexts.tr(context, LangKeys.tapImageToZoom),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: ZnoonaColors.text(
                                  context,
                                ).withOpacity(0.7),
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5.h),
                            GestureDetector(
                              onTap: () => _showFullScreenImage(imageUrl),
                              child: Hero(
                                tag: imageUrl,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[200],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: ZnoonaColors.main(context),
                                          strokeWidth: 2.0,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.image_not_supported,
                                                size: 50.sp,
                                                color: ZnoonaColors.text(
                                                  context,
                                                ).withOpacity(0.5),
                                              ),
                                              SizedBox(height: 10.h),
                                              Text(
                                                ZnoonaTexts.tr(
                                                  context,
                                                  LangKeys.imageNotAvailable,
                                                ),
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
                                  : 22.sp,
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
                          SizedBox(height: 20.sp),

                          // Updated sound and vibration control
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

  // Updated method to include vibration control
  Widget _buildSoundAndVibrationControl() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: ZnoonaColors.main(context).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vibration control
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<AppCubit>().toggleVibration(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: ZnoonaColors.main(context),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          appState.isVibrationEnabled
                              ? Icons.vibration
                              : Icons.not_interested,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            appState.isVibrationEnabled
                                ? ZnoonaTexts.tr(
                                    context,
                                    LangKeys.disableVibration,
                                  )
                                : ZnoonaTexts.tr(
                                    context,
                                    LangKeys.enableVibration,
                                  ),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  '${_formatTime(remainingTime)}',
                  style: GoogleFonts.beiruti(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: remainingTime > widget.timerDuration * 0.3
                        ? Colors.green
                        : remainingTime > widget.timerDuration * 0.1
                        ? Colors.orange
                        : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.read<AppCubit>().toggleSound(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: ZnoonaColors.main(context),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          appState.isSoundEnabled
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            appState.isSoundEnabled
                                ? ZnoonaTexts.tr(
                                    context,
                                    LangKeys.disableSound,
                                  )
                                : ZnoonaTexts.tr(
                                    context,
                                    LangKeys.enableSound,
                                  ),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
