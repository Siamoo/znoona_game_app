import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/entities/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.category,
    required this.onPressed,
    super.key,
  });

  final Category category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isLesson = category.type == 'lesson';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side - Text content
            Expanded(
              flex: 3,
              child: CustomFadeInRight(
                duration: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and badge row
                    TextApp(
                      text: category.arabicName,
                      textStyle: TextStyle(
                        fontSize: 26.h,
                        fontWeight: FontWeight.w800,
                        color: ZnoonaColors.text(context),
                      ),
                      maxLines: 2,
                      // Overflow is now handled by TextApp default
                    ),
                    SizedBox(height: 4.h),
                    // Description
                    Row(
                      children: [
                        Expanded(
                          child: TextApp(
                            text: '${category.discription}',
                            textStyle: TextStyle(
                              fontSize: 17.h,
                              fontWeight: FontWeight.w500,
                              color: ZnoonaColors.text(context).withAlpha(200),
                            ),
                            maxLines: 2,
                          ),
                        ),

                        if (category.totalQuestionsCount > 0) ...[
                          TextApp(
                            text: '|',
                            textStyle: TextStyle(
                              fontSize: 18.h,
                              fontWeight: FontWeight.w500,
                              color: ZnoonaColors.text(context).withAlpha(200),
                            ),
                            maxLines: 2,
                          ),
                          TextApp(
                            text: isLesson
                                ? '${category.totalQuestionsCount} س'
                                : '${category.totalQuestionsCount} س',
                            textStyle: TextStyle(
                              fontSize: 14.h,
                              fontWeight: FontWeight.w500,
                              color: ZnoonaColors.text(context).withAlpha(200),
                            ),
                            maxLines: 1, // Ensure badge text stays in one line
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 10.w),

            // Right side - Image
            CustomFadeInLeft(
              duration: 700,
              child: Container(
                width: 90.w,
                height: 90.h,
                child: CachedNetworkImage(
                  imageUrl: category.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, size: 90.w),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
