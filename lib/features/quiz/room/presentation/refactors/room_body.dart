import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_app_bar.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_navigate.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_game_button.dart';
import 'package:medaan_almaarifa/features/home/widgets/custom_section_title.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/refactors/category_hierarchy_body.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/screen/room_joining_screen.dart';

class RoomBody extends StatelessWidget {
  const RoomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 10.h,
              ),
              child: Column(
                children: [
                  const CustomAppBar(title: LangKeys.quizGame),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        FadeInLeft(
                          child: const CustomSectionTitle(
                            langkey: LangKeys.multiplayer,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        FadeInDown(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FadeInLeft(
                                child: GameButton(
                                  image: AppImages.create,
                                  langkey: LangKeys.createRoom,
                                  onPressed: () {
                                    ZnoonaNavigate.pushTo(
                                      context,
                                      const CategoryHierarchyBody(isRoom: true),
                                    );
                                  },
                                ),
                              ),
                              FadeInRight(
                                child: GameButton(
                                  image: AppImages.join,
                                  langkey: LangKeys.joinRoom,
                                  onPressed: () async {
                                    context
                                        .read<RoomCubit>()
                                        .leaveFromAllRooms();
                                    await ZnoonaNavigate.pushTo(
                                      context,
                                      const RoomJoiningScreen(),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400.h,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 40.w,
                    bottom: 200.h,
                    child: FadeInLeft(
                      duration: const Duration(milliseconds: 4000),
                      child: Image.asset(
                        AppImages.airplane,
                        height: 70.h,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    right: 80.w,
                    bottom: 0,
                    child: FadeInLeft(
                      duration: const Duration(milliseconds: 1400),
                      child: Image.asset(
                        AppImages.blackMNo,
                        height: 130.h,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 200.w,
                    right: 0,
                    bottom: 0,
                    child: FadeInRight(
                      duration: const Duration(milliseconds: 1400),
                      child: Center(
                        child: Image.asset(
                          AppImages.redWTraveler,
                          height: 110.h,
                        ),
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
