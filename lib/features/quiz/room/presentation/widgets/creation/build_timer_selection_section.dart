
import 'package:flutter/widgets.dart';
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
              fontSize: 14.sp,
              color: ZnoonaColors.text(context).withAlpha(150),
            ),
          ),
          SizedBox(height: 16.h),
          // Timer Options
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200.h, // Adjust this value as needed
            ),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children:
                    [
                      5,
                      6,
                      7,
                      8,
                      9,
                      10,
                      11,
                      12,
                      13,
                      14,
                      15,
                      16,
                      17,
                      18,
                      19,
                      20,
                    ].map((duration) {
                      return TimerOption(
                        duration: duration,
                        isSelected: selectedTimerDuration == duration,
                        onSelected: onSelected,
                      );
                    }).toList(),
              ),
            ),
          ),

          SizedBox(height: 16.h),
          // Selected Timer Display
          SelectedTimerDisplay(selectedTimerDuration: selectedTimerDuration),
        ],
      ),
    );
  }
}
