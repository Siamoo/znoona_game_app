import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 12,
      colors: [
        color.withOpacity(0.1),
        color.withOpacity(0.2),
        color.withOpacity(0.05),
        color.withOpacity(0.1),
      ],
      height: 10.h,
      width: 10.w,
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
            SizedBox(height: 6.h),
            // Value
            Text(
              value,
              style: GoogleFonts.beiruti(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: ZnoonaColors.text(context),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Title
            Text(
              title,
              style: GoogleFonts.beiruti(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: ZnoonaColors.text(context)?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
