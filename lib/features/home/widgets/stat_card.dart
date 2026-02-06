// stat_card.dart (alternative with row layout)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class StatCard extends StatelessWidget {
  const StatCard({
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
      height: 110.h,
      width: double.infinity,
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon and Value in Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 18.h,
                ),
                SizedBox(width: 4.w),
                Text(
                  value,
                  style: GoogleFonts.beiruti(
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 6.h),
            // Title
            Text(
              title,
              style: GoogleFonts.beiruti(
                fontSize: 10.h,
                fontWeight: FontWeight.w600,
                color: ZnoonaColors.text(context).withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
