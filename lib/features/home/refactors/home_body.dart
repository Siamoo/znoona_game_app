import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/screens/contact_us_screen.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(child: CustomHomeAppBar(profile: profile)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 900),
                          child: const CustomSectionTitle(
                            langkey: LangKeys.letsPlay,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        FadeInDown(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FadeInLeft(
                                duration: const Duration(milliseconds: 1000),
                                child: GameButton(
                                  image: AppImages.quizGame,
                                  langkey: LangKeys.quizGame,
                                  onPressed: () => ZnoonaNavigate.pushTo(
                                    context,
                                    const QuizHomeScreen(),
                                  ),
                                ),
                              ),
                              FadeInRight(
                                duration: const Duration(milliseconds: 1000),
                                child: GameButton(
                                  image: AppImages.puzzle,
                                  langkey: LangKeys.appName,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 900),
                          child: const CustomSectionTitle(
                            langkey: LangKeys.contactSupport,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 900),
                          child: DiscoverButton(
                            langKeys: LangKeys.contactSupport,
                            appImages: AppImages.callUs,
                            onPressed: () => ZnoonaNavigate.pushTo(
                              context,
                              const ContactUsScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 150.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    bottom: 80.h,
                    child: FadeInUp(
                      child: Image.asset(
                        AppImages.redWRightSide,
                        height: 70.h,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: FadeInLeft(
                      child: Image.asset(
                        AppImages.yelloWHand,
                        height: 100.h,
                      ),
                    ),
                  ),

                  // Wake in center
                  Positioned(
                    left: 45.w,
                    right: 0,
                    bottom: 0,
                    child: FadeInUp(
                      child: Image.asset(
                        AppImages.greenMWake,
                        height: 100.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
