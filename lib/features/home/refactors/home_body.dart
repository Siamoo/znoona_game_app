import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/home/widgets/custom_game_button.dart';
import 'package:znoona_game_app/features/home/widgets/custom_home_appbar.dart';
import 'package:znoona_game_app/features/home/widgets/custom_section_title.dart';
import 'package:znoona_game_app/features/home/widgets/discover_button.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/screens/categories_screen.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/screen/results_screen.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHomeAppBar(profile: profile),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      const CustomSectionTitle(
                        langkey: LangKeys.letsPlay,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GameButton(
                            image: AppImages.quizGame,
                            langkey: LangKeys.quizGame,
                            onPressed: () => ZnoonaNavigate.pushTo(
                              context,
                              const CategoriesScreen(),
                            ),
                          ),
                          GameButton(
                            image: AppImages.puzzle,
                            langkey: LangKeys.appName,
                            onPressed: () => ZnoonaNavigate.pushTo(
                              context,
                              const ResultsScreen(
                                totalQuestions: 15,
                                correctAnswers: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      const CustomSectionTitle(
                        langkey: LangKeys.letsDiscover,
                      ),
                      SizedBox(height: 10.h),
                      const DiscoverButton(),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    await ZnoonaNavigate.pushReplacementTo(
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
