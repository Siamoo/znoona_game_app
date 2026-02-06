import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';

class QuestionTimerTitle extends StatelessWidget {
  const QuestionTimerTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: ZnoonaColors.bluePinkDark(context),
          size: 24.h,
        ),
        SizedBox(width: 8.w),
        Text(
          ZnoonaTexts.tr(context, LangKeys.questionTimer),
          style: GoogleFonts.beiruti(
            fontSize: 18.h,
            fontWeight: FontWeight.bold,
            color: ZnoonaColors.text(context),
          ),
        ),
      ],
    );
  }
}
