import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/home/widgets/settings_buttons.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({required this.profile, super.key});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(
                    title: ZnoonaTexts.tr(context, LangKeys.profile),
                  ),
                  SizedBox(height: 60.h),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(profile.avatarUrl!),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(height: 20.h),
                  TextApp(
                    text: profile.fullName,
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  TextApp(
                    text: '--------------------------------------------------',
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  //todo add cups in supabase & add it here
                  TextApp(
                    text:
                        'all time : ${profile.level} cup 🏆 | this month : 1 cup 🏆 | rank : 12',
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextApp(
                    text: '--------------------------------------------------',
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),
                  const SettingsButtons(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
