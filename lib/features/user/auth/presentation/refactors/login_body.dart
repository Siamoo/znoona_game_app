import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/home/screens/home_screen.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/screens/sign_up_screen.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/auth_title_info.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/dark_and_lang_buttons.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/have_account_or_not.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/login/login_button.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/login/login_text_form.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/login_or_sign_up_with_google.dart';

class LoginBody extends StatelessWidget {
  LoginBody({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        state.whenOrNull(
          // FIXED: Now only one authenticated state with authMethod
          authenticated: (profile, authMethod) async {
            await ZnoonaNavigate.pushReplacementTo(context, const HomeScreen());
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      builder: (context, state) {
        // FIXED: No more googleLoading state - just loading
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        
        // REMOVED: isGoogleLoading since we don't have that state anymore
        
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
                // FIXED: No separate Google loading indicator
                LoginOrSignUpWithGoogle(
                  text: ZnoonaTexts.tr(context, LangKeys.login),
                  isLoading: isLoading, // Pass the same loading state
                ),
                SizedBox(height: 30.h),
                HaveAccountOrNot(
                  text: ZnoonaTexts.tr(context, LangKeys.createAccount),
                  onPressed: () async {
                    await ZnoonaNavigate.pushReplacementTo(
                      context,
                      const SignUpScreen(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}