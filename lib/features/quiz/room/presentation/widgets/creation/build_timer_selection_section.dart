import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/creation/question_timer_title.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/creation/selected_timer_display.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/creation/timer_option.dart';

class BuildTimerSelectionSection extends StatelessWidget {
  const BuildTimerSelectionSection({
    required this.onSelected,
    required this.selectedTimerDuration,
    super.key,
  });

  final dynamic Function(int) onSelected;
  final int selectedTimerDuration;

  // Updated timer options with formatted durations
  final List<Map<String, dynamic>> timerOptions = const [
    {'seconds': 5, 'display': '5s'},
    {'seconds': 10, 'display': '10s'},
    {'seconds': 15, 'display': '15s'},
    {'seconds': 20, 'display': '20s'},
    {'seconds': 30, 'display': '30s'},
    {'seconds': 45, 'display': '45s'},
    {'seconds': 60, 'display': '1m'},
    {'seconds': 90, 'display': '1.5m'},
    {'seconds': 120, 'display': '2m'},
  ];

  String _formatTimerDuration(BuildContext context, int seconds) {
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
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ZnoonaColors.bluePinkDark(context).withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ZnoonaColors.bluePinkDark(context).withAlpha(100),
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
              maxHeight: 220.h,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 8.h,
                childAspectRatio: 1.5,
              ),
              itemCount: timerOptions.length,
              itemBuilder: (context, index) {
                final option = timerOptions[index];
                final duration = option['seconds'] as int;
                final display = option['display'] as String;

                return TimerOption(
                  duration: duration,
                  formattedDuration: display,
                  isSelected: selectedTimerDuration == duration,
                  onSelected: onSelected,
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          // Selected Timer Display
          SelectedTimerDisplay(
            selectedTimerDuration: selectedTimerDuration,
            formattedDuration: _formatTimerDuration(
              context,
              selectedTimerDuration,
            ),
          ),
        ],
      ),
    );
  }
}
