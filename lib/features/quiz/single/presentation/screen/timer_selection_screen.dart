import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/screen/quiz_screen.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                title: ZnoonaTexts.tr(context, LangKeys.selectTimer),
              ),
              SizedBox(height: 40.h),

              // Title
              Text(
                ZnoonaTexts.tr(context, LangKeys.chooseTimeForEachQuestion),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),

              Text(
                ZnoonaTexts.tr(context, LangKeys.timerSelectionDescription),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),

              // Timer Options
              Expanded(
                child: ListView.builder(
                  itemCount: timerOptions.length,
                  itemBuilder: (context, index) {
                    final duration = timerOptions[index];
                    final isSelected = _selectedTimerDuration == duration;

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 20.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTimerDuration = duration;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          padding: EdgeInsets.all(20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[600],
                                    size: 24.sp,
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    _formatTimerDuration(duration),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).primaryColor,
                                  size: 24.sp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Start Quiz Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to QuizScreen with selected timer duration
                    ZnoonaNavigate.pushTo(
                      context,
                      QuizScreen(
                        categoryId: widget.categoryId,
                        categoryName: widget.categoryName,
                        timerDuration: _selectedTimerDuration,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 60.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    ZnoonaTexts.tr(context, LangKeys.startGame),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
