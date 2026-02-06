import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/entities/category.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/widgets/category_item.dart';

class CategoryLevelBody extends StatelessWidget {
  const CategoryLevelBody({
    required this.state,
    required this.onCategorySelected,
    super.key,
  });

  final CategoriesState state;
  final dynamic Function(Category) onCategorySelected;

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
              fontSize: 16.h,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 80.w,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            TextApp(
              text: 'No categories available',
              textStyle: TextStyle(
                fontSize: 18.h,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
              onPressed: () => onCategorySelected(category),
            ),
          );
        },
      ),
    );
  }
}
