import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/refactors/sound_setting_body.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_setting_button.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/refactors/profile_edit_body.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/screens/login_screen.dart';

// NEW: Add Sound Settings Screen

class SettingsButtons extends StatelessWidget {
  const SettingsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSettingButton(
          title: LangKeys.changeLanguage,
          onTap: () {
            final cubit = context.read<AppCubit>();
            if (cubit.state.locale.languageCode == 'en') {
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
          onTap: () => context.read<AppCubit>().toggleTheme(),
          imageUrl: AppImages.mode,
        ),
        SizedBox(height: 20.h),
        // NEW: Sound Settings Button
        CustomSettingButton(
          title: LangKeys.soundSettings,
          onTap: () {
            ZnoonaNavigate.pushTo(
              context,
              const SoundSettingsScreen(),
            );
          },
          imageUrl: AppImages.volume, // You'll need to add this image
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