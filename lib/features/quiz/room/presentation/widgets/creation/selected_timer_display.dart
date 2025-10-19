import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';

class SelectedTimerDisplay extends StatelessWidget {
  const SelectedTimerDisplay({
    required this.selectedTimerDuration, super.key,
  });

  final int selectedTimerDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ZnoonaColors.bluePinkDark(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            '$selectedTimerDuration ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
