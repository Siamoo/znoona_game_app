import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class TimerOption extends StatelessWidget {
  const TimerOption({
    required this.duration,
    required this.formattedDuration,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });
  
  final int duration;
  final String formattedDuration;
  final bool isSelected;
  final dynamic Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(duration),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ZnoonaColors.bluePinkDark(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ZnoonaColors.bluePinkDark(context),
            width: isSelected ? 0 : 1,
          ),
        ),
        child: Center(
          child: Text(
            formattedDuration,
            style: TextStyle(
              color: isSelected ? Colors.white : ZnoonaColors.text(context),
              fontSize: 12.h,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}