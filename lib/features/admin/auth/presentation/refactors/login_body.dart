import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/dark_and_lang_buttons.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/login/login_button.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/login/login_text_form.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/sign_up/auth_title_info.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DarkAndLangButtons(),
            SizedBox(
              height: 50.h,
            ),
            AuthTitleInfo(
              title: ZnoonaTexts.tr(context, LangKeys.login),
              description: ZnoonaTexts.tr(context, LangKeys.welcome),
            ),
            SizedBox(
              height: 30.h,
            ),
            const LoginTextForm(),
            SizedBox(
              height: 30.h,
            ),
            const LoginButton(),
            SizedBox(
              height: 30.h,
            ),
            CustomFadeInDown(
              duration: 400,
              child: TextApp(
                text: ZnoonaTexts.tr(context, LangKeys.createAccount),
                textStyle: GoogleFonts.beiruti(
                  fontSize: 20.sp,
                  color: ZnoonaColors.bluePinkLight(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
