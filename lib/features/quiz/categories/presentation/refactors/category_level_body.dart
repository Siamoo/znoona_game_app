import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/widgets/category_item.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/widgets/category_level&level_type.dart';

class CategoryLevelBody extends StatelessWidget {
  const CategoryLevelBody({
    required this.state,
    required this.onCategorySelected,
    required this.levelType,
    super.key,
  });

  final CategoriesState state;
  final dynamic Function(Category) onCategorySelected;
  final LevelType levelType;

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: _buildLoading,
      loading: _buildLoading,
      loaded: _buildCategoriesList,
      error: (message) => _buildError(message, context),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextApp(
            text: 'Error: $message',
            textStyle: TextStyle(
              fontSize: 16.sp,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () async {
              await context.read<CategoriesCubit>().loadMainCategories();
            },
            child: const TextApp(text: 'Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesList(List<Category> categories) {
    if (categories.isEmpty) {
      return Center(
        child: TextApp(
          text: 'No categories found',
          textStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView.separated(
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CustomFadeInDown(
            duration: 600 + (index * 10),
            child: CategoryItem(
              category: category,
              levelType: levelType,
              onPressed: () => onCategorySelected(category),
            ),
          );
        },
      ),
    );
  }
}
