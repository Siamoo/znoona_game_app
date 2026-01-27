import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_game_button.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_section_title.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/refactors/category_hierarchy_body.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/screen/room_screen.dart';

class QuizHomeBody extends StatelessWidget {
  const QuizHomeBody({super.key});

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
                          langkey: LangKeys.chooseMode,
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
                                const CategoryHierarchyBody(
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
                                  const RoomScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SizedBox(
              height: 300.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: Image.asset(
                      AppImages.yelloWHand,
                      height: 100.h,
                    ),
                  ),

                  // Wake in center
                  Positioned(
                    left: 45.w,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Image.asset(
                        AppImages.yelloWThink,
                        height: 300.h,
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
