import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/home/screens/quiz_home_screen.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_game_button.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_home_appbar.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_section_title.dart';
import 'package:medaan_almaarifa/features/home/widgets/discover_button.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';

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
                              const QuizHomeScreen(),
                            ),
                          ),
                          GameButton(
                            image: AppImages.puzzle,
                            langkey: LangKeys.appName,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 30.h),
                      const CustomSectionTitle(
                        langkey: LangKeys.letsDiscover,
                      ),
                      SizedBox(height: 10.h),
                      const DiscoverButton(),
                      SizedBox(height: 30.h),
                      const CustomSectionTitle(
                        langkey: LangKeys.universityStudents,
                      ),
                      SizedBox(height: 10.h),
                      const DiscoverButton(),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
