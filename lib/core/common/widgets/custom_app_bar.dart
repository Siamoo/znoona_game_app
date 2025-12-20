import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    super.key,
    this.otherText,
    this.icon,
    this.onTap,
  });

  final String title;
  final String? otherText;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomFadeInRight(
          duration: 500,
          child: InkWell(
            onTap: onTap ?? () => Navigator.pop(context),
            child: Icon(
              icon ?? Icons.arrow_back_ios_new,
              color: ZnoonaColors.text(context),
              size: 24.sp,
            ),
          ),
        ),
        if (otherText == null)
          const SizedBox()
        else
          TextApp(
            text: ZnoonaTexts.tr(
              context,
              otherText!,
            ),
            textStyle: GoogleFonts.beiruti(
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              color: ZnoonaColors.text(context),
            ),
          ),
        CustomFadeInLeft(
          duration: 500,
          child: TextApp(
            text: ZnoonaTexts.tr(
              context,
              title,
            ),
            textStyle: GoogleFonts.beiruti(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: ZnoonaColors.text(context),
            ),
          ),
        ),
      ],
    );
  }
}
