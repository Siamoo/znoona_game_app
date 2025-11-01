import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/categores_helper.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/refactors/category_hierarchy_body.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.category,
    required this.levelType,
    required this.onPressed,
    super.key,
  });

  final Category category;
  final LevelType levelType;
  final VoidCallback onPressed;

  String _getImageForLevel(LevelType type, String categoryName) {
    // Use getCategoryImageForType instead of getCategoryImages
    return getCategoryImageForType(_levelTypeToString(type), categoryName);
  }

  // Helper method to convert LevelType to string for the helper function
  String _levelTypeToString(LevelType type) {
    switch (type) {
      case LevelType.main:
        return 'main_type';
      case LevelType.faculty:
        return 'faculty';
      case LevelType.year:
        return 'year';
      case LevelType.subject:
        return 'subject';
      case LevelType.unit:
        return 'unit';
      case LevelType.lesson:
        return 'lesson';
    }
  }

  String _getDescription(LevelType type) {
    switch (type) {
      case LevelType.main:
        return 'اختر نوع التعليم';
      case LevelType.faculty:
        return 'اختر الكلية';
      case LevelType.year:
        return 'اختر السنة الدراسية';
      case LevelType.subject:
        return 'اختر المادة';
      case LevelType.unit:
        return 'اختر الوحدة';
      case LevelType.lesson:
        return 'ابدأ الاختبار';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLeaf = levelType == LevelType.lesson;

    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.main(context),
        ZnoonaColors.containerLinear2(context),
      ],
      height: 120.h,
      width: double.infinity,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    text: category.name,
                    textStyle: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: ZnoonaColors.text(context),
                    ),
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  TextApp(
                    text: _getDescription(levelType),
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ZnoonaColors.text(context).withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),
            CustomFadeInLeft(
              duration: 700,
              child: Stack(
                children: [
                  Image.asset(
                    _getImageForLevel(levelType, category.name),
                    height: 70.h,
                    width: 70.w,
                    fit: BoxFit.contain,
                  ),
                  if (isLeaf)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 16.w,
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
