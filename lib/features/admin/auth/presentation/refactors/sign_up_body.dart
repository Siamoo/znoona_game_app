import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/routes/app_routes.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/dark_and_lang_buttons.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/sign_up/auth_title_info.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/sign_up/sign_up_button.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/sign_up/sign_up_text_form.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/widgets/sign_up/user_avatar_image.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DarkAndLangButtons(),
            SizedBox(
              height: 30.h,
            ),
            AuthTitleInfo(
              title: ZnoonaTexts.tr(context, LangKeys.signUp),
              description: ZnoonaTexts.tr(context, LangKeys.signUpWelcome),
            ),
            SizedBox(
              height: 10.h,
            ),
            const UserAvatarImage(),
            SizedBox(
              height: 20.h,
            ),
            const SignUpTextForm(),
            SizedBox(
              height: 20.h,
            ),
            const SignUpButton(),
            SizedBox(
              height: 20.h,
            ),
            CustomFadeInDown(
              duration: 400,
              child: TextButton(
                onPressed: () async {
                  await ZnoonaNavigate.pushReplacementNamed(
                    context,
                    AppRoutes.login,
                  );
                },
                child: TextApp(
                  text: ZnoonaTexts.tr(context, LangKeys.youHaveAccount),
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 20.sp,
                    color: ZnoonaColors.bluePinkLight(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
