import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/home/widgets/custom_game_button.dart';
import 'package:znoona_game_app/features/home/widgets/custom_section_title.dart';
import 'package:znoona_game_app/features/home/widgets/discover_button.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/screens/categories_screen.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_creation_screen.dart';

class QuizHomeBody extends StatelessWidget {
  const QuizHomeBody({super.key});

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
                const CustomAppBar(title: LangKeys.quizGame),
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
                            image: AppImages.solo,
                            langkey: LangKeys.solo,
                            onPressed: () => ZnoonaNavigate.pushTo(
                              context,
                              const CategoriesScreen(
                                isRoom: false,
                              ),
                            ),
                          ),
                          GameButton(
                            image: AppImages.multi,
                            langkey: LangKeys.room,
                            onPressed: () {
                              ZnoonaNavigate.pushTo(
                                context,
                                const RoomCreationScreen(),
                              );
                            },
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
