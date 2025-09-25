import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 500,
      child: CustomLinearButton(
        height: 50.h,
        width: double.infinity,
        onPressed: () {},
        child: TextApp(
          text: ZnoonaTexts.tr(context, LangKeys.login),
          textStyle: GoogleFonts.beiruti(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
