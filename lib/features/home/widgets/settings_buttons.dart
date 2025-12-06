import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/home/widgets/custom_setting_button.dart';
import 'package:znoona_game_app/features/user/auth/presentation/refactors/profile_edit_body.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Column(
      children: [
        CustomSettingButton(
          title: LangKeys.changeLanguage,
          onTap: () {
            if (cubit.currentLangcode == 'en') {
              cubit.toArabic();
            } else {
              cubit.toEnglish();
            }
          },
          imageUrl: AppImages.language,
        ),
        SizedBox(height: 20.h),
        CustomSettingButton(
          title: LangKeys.changeTheme,
          onTap: cubit.changeAppThemeMode,
          imageUrl: AppImages.mode,
        ),
        SizedBox(height: 20.h),
        CustomSettingButton(
          title: LangKeys.editProfile,
          onTap: () {
            ZnoonaNavigate.pushReplacementTo(
              context,
              const ProfileEditBody(),
            );
          },
          imageUrl: AppImages.editProfile,
        ),
        SizedBox(height: 20.h),
        CustomSettingButton(
          title: LangKeys.logOut,
          onTap: () async {
            await Supabase.instance.client.auth.signOut();
            await ZnoonaNavigate.pushReplacementTo(
              context,
              const LoginScreen(),
            );
          },
          imageUrl: AppImages.logout,
        ),
      ],
    );
  }
}
