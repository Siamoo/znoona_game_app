import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_text_filed.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/utils/app_regex.dart';

class LoginTextForm extends StatefulWidget {
  const LoginTextForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginTextForm> createState() => _LoginTextFormState();
}

class _LoginTextFormState extends State<LoginTextForm> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomFadeInRight(
            duration: 200,
            child: CustomTextField(
              controller: widget.emailController,
              hintText: ZnoonaTexts.tr(context, LangKeys.email),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty || !AppRegex.isEmailValid(value)) {
                  return ZnoonaTexts.tr(context, LangKeys.validEmail);
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20.h),
          CustomFadeInRight(
            duration: 200,
            child: CustomTextField(
              controller: widget.passwordController,
              hintText: ZnoonaTexts.tr(context, LangKeys.password),
              keyboardType: TextInputType.visiblePassword,
              obscureText: !isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 6) {
                  return ZnoonaTexts.tr(context, LangKeys.validPasswrod);
                }
                return null;
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: isPasswordVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
                color: ZnoonaColors.text(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
