import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';

class GoodResultBody extends StatelessWidget {
  const GoodResultBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextApp(
          text: ZnoonaTexts.tr(context, LangKeys.good),
          textStyle: GoogleFonts.beiruti(
            fontSize: 38.sp,
            fontWeight: FontWeight.bold,
            color: ZnoonaColors.text(context),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40.h),
        Image.asset(
          AppImages.goodResult,
          height: 300.h,
          width: 300.w,
        ),
        SizedBox(
          height: 30.h,
        ),
        TextApp(
          text: ZnoonaTexts.tr(context, LangKeys.train),
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
