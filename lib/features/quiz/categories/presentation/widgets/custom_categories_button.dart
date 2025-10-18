import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';

class CustomCategoriesButton extends StatelessWidget {
  const CustomCategoriesButton({
    required this.title,
    required this.imageUrl,
    required this.discription,
    required this.onPressed,
    super.key,
  });
  final String title;
  final String imageUrl;
  final String discription;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.main(context),

        ZnoonaColors.containerLinear2(context),
      ],
      height: 120.h,
      width: double.infinity,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFadeInRight(
              duration: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    // width: 100.w,
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, title),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w800,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 220.w,
                    child: TextApp(
                      text: ZnoonaTexts.tr(context, discription),
                      textStyle: GoogleFonts.beiruti(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomFadeInLeft(
              duration: 700,
              child: Image.asset(
                imageUrl,
                height: 90.h,
                width: 90.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
