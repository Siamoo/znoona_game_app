import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    required this.langkey,
    required this.image,
    super.key,
  });

  final String langkey;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.containerLinear5(context),
        ZnoonaColors.containerLinear5(context),
        ZnoonaColors.containerLinear2(context),
        ZnoonaColors.containerLinear2(context),
      ],
      height: 230.h,
      width: 160.w,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 150.h,
              width: 150.w,
            ),
            TextApp(
              text: ZnoonaTexts.tr(context, langkey),
              textStyle: GoogleFonts.beiruti(
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
