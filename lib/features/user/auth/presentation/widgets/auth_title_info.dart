import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class AuthTitleInfo extends StatelessWidget {
  const AuthTitleInfo({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInDown(
      duration: 400,
      child: Column(
        children: [
          TextApp(
            text: title,
            textStyle: GoogleFonts.beiruti(
              fontSize: 30.h,
              fontWeight: FontWeight.bold,
              color: ZnoonaColors.text(context),
            ),
          ),
          TextApp(
            text: description,
            textStyle: GoogleFonts.beiruti(
              fontSize: 20.h,
              fontWeight: FontWeight.w400,
              color: ZnoonaColors.text(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
