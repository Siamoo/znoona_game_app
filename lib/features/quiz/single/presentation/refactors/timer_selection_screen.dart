import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/screen/quiz_screen.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/question_timer_title.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/selected_timer_display.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/widgets/timer_option.dart';

class TimerSelectionScreen extends StatefulWidget {
  const TimerSelectionScreen({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  final String categoryId;
  final String categoryName;

  @override
  State<TimerSelectionScreen> createState() => _TimerSelectionScreenState();
}

class _TimerSelectionScreenState extends State<TimerSelectionScreen> {
  int _selectedTimerDuration = 15; // Default to 15 seconds

  // Timer options
  final List<int> timerOptions = [
    15,
    30,
    60,
    120,
    300,
    600,
    900,
    1800,
  ]; // 15s, 30s, 1m, 2m, 5m 10m, 15m, 30m

  String _formatTimerDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds ${ZnoonaTexts.tr(context, LangKeys.seconds)}';
    } else if (seconds < 3600) {
      final minutes = seconds ~/ 60;
      final remainingSeconds = seconds % 60;
      if (remainingSeconds == 0) {
        return '$minutes ${ZnoonaTexts.tr(context, LangKeys.minute)}';
      }
      return '$minutes ${ZnoonaTexts.tr(context, LangKeys.minute)} $remainingSeconds ${ZnoonaTexts.tr(context, LangKeys.seconds)}';
    } else {
      final hours = seconds ~/ 3600;
      final minutes = (seconds % 3600) ~/ 60;
      return '$hours ${ZnoonaTexts.tr(context, LangKeys.hour)} $minutes ${ZnoonaTexts.tr(context, LangKeys.minute)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  title: ZnoonaTexts.tr(context, LangKeys.selectTimer),
                ),
                SizedBox(height: 20.h),

                // Title
                CustomFadeInDown(
                  duration: const Duration(milliseconds: 850),
                  child: Column(
                    children: [
                      Text(
                        ZnoonaTexts.tr(
                          context,
                          LangKeys.chooseTimeForEachQuestion,
                        ),
                        style: TextStyle(
                          fontSize: 20.h,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        ZnoonaTexts.tr(
                          context,
                          LangKeys.timerSelectionDescription,
                        ),
                        style: TextStyle(
                          fontSize: 14.h,
                          color: ZnoonaColors.text(context).withAlpha(150),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                // Timer Selection Section
                CustomFadeInDown(
                  duration: const Duration(milliseconds: 700),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ZnoonaColors.bluePinkDark(context).withAlpha(30),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ZnoonaColors.bluePinkDark(
                          context,
                        ).withAlpha(100),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const QuestionTimerTitle(),
                        SizedBox(height: 16.h),
                        Text(
                          ZnoonaTexts.tr(context, LangKeys.selectTimerDuration),
                          style: TextStyle(
                            fontSize: 14.h,
                            color: ZnoonaColors.text(context).withAlpha(150),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Timer Options Grid
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 300.h,
                          ),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8.w,
                                  mainAxisSpacing: 8.h,
                                  childAspectRatio: 1.5,
                                ),
                            itemCount: timerOptions.length,
                            itemBuilder: (context, index) {
                              final duration = timerOptions[index];
                              return TimerOption(
                                duration: duration,
                                formattedDuration: _formatTimerDuration(
                                  duration,
                                ),
                                isSelected: _selectedTimerDuration == duration,
                                onSelected: (selectedDuration) {
                                  setState(() {
                                    _selectedTimerDuration = selectedDuration;
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Selected Timer Display
                        SelectedTimerDisplay(
                          selectedTimerDuration: _selectedTimerDuration,
                          formattedDuration: _formatTimerDuration(
                            _selectedTimerDuration,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                // Start Quiz Button
                CustomFadeInDown(
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: CustomLinearButton(
                      height: 60.h,
                      onPressed: () {
                        ZnoonaNavigate.pushTo(
                          context,
                          QuizScreen(
                            categoryId: widget.categoryId,
                            categoryName: widget.categoryName,
                            timerDuration: _selectedTimerDuration,
                          ),
                        );
                      },
                      child: Text(
                        ZnoonaTexts.tr(context, LangKeys.startGame),
                        style: TextStyle(
                          fontSize: 18.h,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
