import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    required this.langkey,
    required this.image,
    required this.onPressed,
    super.key,
  });

  final String langkey;
  final String image;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.main(context),
        ZnoonaColors.main(context),
        ZnoonaColors.containerLinear2(context),
        ZnoonaColors.containerLinear2(context),
      ],
      height: 230.h,
      width: 160.w,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            height: 140.h,
            width: 140.w,
          ),
          TextApp(
            text: ZnoonaTexts.tr(context, langkey),
            textStyle: GoogleFonts.beiruti(
              fontSize: 26.h,
              fontWeight: FontWeight.w800,
              color: ZnoonaColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}
