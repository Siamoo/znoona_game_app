import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/home/screens/home_screen.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/screens/login_screen.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/auth_title_info.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/dark_and_lang_buttons.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/have_account_or_not.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/login_or_sign_up_with_google.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/sign_up/sign_up_button.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/sign_up/sign_up_text_form.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/widgets/sign_up/user_avatar_image.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({super.key});
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        state.whenOrNull(
          // FIXED: Now only one authenticated state with authMethod
          authenticated: (profile, authMethod) async {
            if (authMethod == AuthMethod.email) {
              // For email signup, go to login screen
              await ZnoonaNavigate.pushReplacementTo(
                context,
                const LoginScreen(),
              );
            } else {
              // For Google signup, go to home screen
              await ZnoonaNavigate.pushReplacementTo(
                context,
                const HomeScreen(),
              );
            }
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      builder: (context, state) {
        // FIXED: No more googleLoading state
        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DarkAndLangButtons(),
                SizedBox(height: 30.h),
                AuthTitleInfo(
                  title: ZnoonaTexts.tr(context, LangKeys.signUp),
                  description: ZnoonaTexts.tr(context, LangKeys.signUpWelcome),
                ),
                SizedBox(height: 10.h),
                const UserAvatarImage(),
                SizedBox(height: 20.h),
                SignUpTextForm(
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: fullNameController,
                ),
                SizedBox(height: 20.h),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  SignUpButton(
                    formKey: formKey,
                    nameController: fullNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                SizedBox(height: 10.h),
                // FIXED: No separate Google loading indicator
                LoginOrSignUpWithGoogle(
                  text: ZnoonaTexts.tr(context, LangKeys.signUp),
                  isLoading: isLoading,
                ),
                SizedBox(height: 20.h),
                HaveAccountOrNot(
                  text: ZnoonaTexts.tr(context, LangKeys.youHaveAccount),
                  onPressed: () async {
                    await ZnoonaNavigate.pushReplacementTo(
                      context,
                      const LoginScreen(),
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