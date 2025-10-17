import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/home/widgets/custom_game_button.dart';
import 'package:znoona_game_app/features/home/widgets/custom_section_title.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/screens/categories_screen.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_joining_screen.dart';

class RoomBody extends StatelessWidget {
  const RoomBody({super.key});

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
                        langkey: LangKeys.multiplayer,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GameButton(
                            image: AppImages.create,
                            langkey: LangKeys.createRoom,
                            onPressed: () => ZnoonaNavigate.pushTo(
                              context,
                              const CategoriesScreen(isRoom: true),
                            ),
                          ),
                          GameButton(
                            image: AppImages.join,
                            langkey: LangKeys.joinRoom,
                            onPressed: () async {
                              await ZnoonaNavigate.pushTo(
                                context,
                                const RoomJoiningScreen(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
