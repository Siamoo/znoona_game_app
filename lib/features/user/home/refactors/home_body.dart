import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';
import 'package:znoona_game_app/features/user/home/widgets/custom_appbar.dart';
import 'package:znoona_game_app/features/user/home/widgets/game_button.dart';
import 'package:znoona_game_app/features/user/home/widgets/lets_play_text.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    required this.profile,
    super.key,
  });
  final Profile profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(profile: profile),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      const LetsPlayText(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GameButton(
                            title: ZnoonaTexts.tr(
                              context,
                              LangKeys.quizGame,
                            ),
                            image: AppImages.quizGame,
                          ),
                          GameButton(
                            title: ZnoonaTexts.tr(
                              context,
                              LangKeys.appName,
                            ),
                            image: AppImages.puzzle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                ElevatedButton(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    ZnoonaNavigate.pushReplacementTo(
                      context,
                      const LoginScreen(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
