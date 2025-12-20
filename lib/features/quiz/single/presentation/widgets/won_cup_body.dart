
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
class WonCupBody extends StatelessWidget {
  const WonCupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextApp(
          text: ZnoonaTexts.tr(context, LangKeys.congratulations),
          textStyle: GoogleFonts.beiruti(
            fontSize: 38.sp,
            fontWeight: FontWeight.bold,
            color: ZnoonaColors.text(context),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h),
        Image.asset(
          AppImages.wonCup,
          height: 300.h,
          width: 300.w,
        ),
        SizedBox(
          height: 30.h,
        ),
        TextApp(
          text: ZnoonaTexts.tr(context, LangKeys.won),
          textStyle: GoogleFonts.beiruti(
            fontSize: 38.sp,
            fontWeight: FontWeight.bold,
            color: ZnoonaColors.text(context),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
