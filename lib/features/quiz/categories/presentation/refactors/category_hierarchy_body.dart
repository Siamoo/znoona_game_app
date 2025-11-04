import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/refactors/category_level_body.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/widgets/category_level_class.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_creation_screen.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/screen/quiz_screen.dart';

class CategoryHierarchyBody extends StatefulWidget {
  const CategoryHierarchyBody({required this.isRoom, super.key});
  final bool isRoom;

  @override
  State<CategoryHierarchyBody> createState() => _CategoryHierarchyBodyState();
}

class _CategoryHierarchyBodyState extends State<CategoryHierarchyBody> {
  final List<CategoryLevel> _navigationStack = [];

  @override
  void initState() {
    super.initState();
    // Start with main categories
    _loadMainCategories();
  }

  void _loadMainCategories() {
    context.read<CategoriesCubit>().loadMainCategories();
    _navigationStack
      ..clear()
      ..add(
        CategoryLevel(title: LangKeys.categories),
      );
  }

  Future<void> _onCategorySelected(Category category) async {
    if (_isLeafLevel(category)) {
      // Last level - start quiz
      _startQuiz(category);
    } else {
      // Navigate to next level
      await context.read<CategoriesCubit>().loadSubCategories(category.id);
      _navigationStack.add(
        CategoryLevel(
          title: category.name,
          parentId: category.id,
        ),
      );
    }
  }

  void _onBackPressed() {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        final previousLevel = _navigationStack.last;

        if (previousLevel.parentId != null) {
          context.read<CategoriesCubit>().loadSubCategories(
            previousLevel.parentId!,
          );
        } else {
          context.read<CategoriesCubit>().loadMainCategories();
        }
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  bool _isLeafLevel(Category category) {
    // Define which levels are leaf nodes (have lessons/quizzes)
    return category.type == 'lesson' ||
        category.type == 'unit' ||
        category.type == 'subject';
  }

  void _startQuiz(Category category) {
    ZnoonaNavigate.pushTo(
      context,
      widget.isRoom
          ? RoomCreationScreen(
              categoryId: category.id,
              categoryName: category.name,
              imageUrl: AppImages.football,
            )
          : QuizScreen(
              categoryId: category.id,
              categoryName: category.name,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: _navigationStack.last.title,
              onTap: _onBackPressed,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return CategoryLevelBody(
                    state: state,
                    onCategorySelected: (category) {
                      _onCategorySelected(
                        category,
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
  }
}
