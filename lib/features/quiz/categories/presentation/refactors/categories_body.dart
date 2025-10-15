import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/categores_helper.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/widgets/custom_categories_button.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_creation_screen.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/screen/quiz_screen.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({required this.isRoom, super.key});

  final bool isRoom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return Scaffold(
          body: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (categories) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      const CustomAppBar(
                        title: LangKeys.categories,
                      ),
                      SizedBox(height: 12.h),
                      Expanded(
                        child: ListView.separated(
                          itemCount: categories.length,
                          separatorBuilder: (_, _) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CustomCategoriesButton(
                              title: getCategoryLangKeys(category.name),
                              imageUrl: getCategoryImages(category.name),
                              discription: getCategoryDiscription(
                                category.name,
                              ),
                              onPressed: () {
                                ZnoonaNavigate.pushTo(
                                  context,
                                  isRoom
                                      ? RoomCreationScreen(
                                          categoryId: category.id,
                                          categoryName: getCategoryLangKeys(
                                            category.name,
                                          ),
                                        )
                                      : QuizScreen(
                                          categoryId: category.id,
                                          categoryName: getCategoryLangKeys(
                                            category.name,
                                          ),
                                        ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (msg) => Center(child: Text(msg)),
          ),
        );
      },
    );
  }
}
