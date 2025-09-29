import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/routes/app_routes.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/auth_title_info.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/dark_and_lang_buttons.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/have_account_or_not.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/login/login_button.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/login/login_text_form.dart';
import 'package:znoona_game_app/features/user/auth/presentation/widgets/login_or_sign_up_with_google.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (profile) {
            ZnoonaNavigate.pushReplacementNamed(context, AppRoutes.noNetwork);
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        final isGoogleLoading = state.maybeWhen(
          googleloading: () => true,
          orElse: () => false,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DarkAndLangButtons(),
                SizedBox(height: 50.h),
                AuthTitleInfo(
                  title: ZnoonaTexts.tr(context, LangKeys.login),
                  description: ZnoonaTexts.tr(context, LangKeys.welcome),
                ),
                SizedBox(height: 30.h),
                LoginTextForm(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                SizedBox(height: 30.h),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  LoginButton(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                SizedBox(height: 10.h),
                if (isGoogleLoading)
                  const CircularProgressIndicator()
                else
                  LoginOrSignUpWithGoogle(
                    text: ZnoonaTexts.tr(context, LangKeys.login),
                  ),
                SizedBox(height: 30.h),
                HaveAccountOrNot(
                  text: ZnoonaTexts.tr(context, LangKeys.createAccount),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
