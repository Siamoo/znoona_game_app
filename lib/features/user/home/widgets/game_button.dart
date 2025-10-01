import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    required this.title,
    required this.image,
    super.key,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.main(context),
        ZnoonaColors.main(context),
        ZnoonaColors.containerLinear1(context),
        ZnoonaColors.containerLinear2(context),
      ],
      height: 200.h,
      width: 150.w,
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            image,
            height: 120.h,
            width: 120.w,
          ),
          TextApp(
            text: title,
            textStyle: GoogleFonts.beiruti(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
