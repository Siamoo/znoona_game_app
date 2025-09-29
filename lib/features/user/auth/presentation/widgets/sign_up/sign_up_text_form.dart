import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_text_filed.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/utils/app_regex.dart';

class SignUpTextForm extends StatefulWidget {
  const SignUpTextForm({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignUpTextForm> createState() => _SignUpTextFormState();
}

class _SignUpTextFormState extends State<SignUpTextForm> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Full Name
          CustomFadeInRight(
            duration: 200,
            child: CustomTextField(
              controller: widget.nameController,
              hintText: ZnoonaTexts.tr(context, LangKeys.fullName),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return ZnoonaTexts.tr(context, LangKeys.validName);
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20.h),

          // Email
          CustomFadeInRight(
            duration: 200,
            child: CustomTextField(
              controller: widget.emailController,
              hintText: ZnoonaTexts.tr(context, LangKeys.email),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || !AppRegex.isEmailValid(value)) {
                  return ZnoonaTexts.tr(context, LangKeys.validEmail);
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20.h),

          // Password
          CustomFadeInRight(
            duration: 200,
            child: CustomTextField(
              controller: widget.passwordController,
              hintText: ZnoonaTexts.tr(context, LangKeys.password),
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
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                color: ZnoonaColors.text(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
