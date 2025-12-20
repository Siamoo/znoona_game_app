import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInRight(
      duration: 500,
      child: CustomLinearButton(
        height: 50.h,
        width: double.infinity,
        onPressed: () async {
          if (formKey.currentState?.validate() ?? false) {
            await context.read<AuthCubit>().login(
              emailController.text.trim(),
              passwordController.text.trim(),
            );
          }
        },
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
