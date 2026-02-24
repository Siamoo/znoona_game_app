import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class SelectedTimerDisplay extends StatelessWidget {
  const SelectedTimerDisplay({
    required this.selectedTimerDuration,
    required this.formattedDuration,
    super.key,
  });

  final int selectedTimerDuration;
  final String formattedDuration;

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
            size: 18.h,
          ),
          SizedBox(width: 8.w),
          Text(
            formattedDuration,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}