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
            CustomFadeInRight(
              duration: 700,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextApp(
                    text: category.arabicName,
                    textStyle: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      color: ZnoonaColors.text(context),
                    ),
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: 220.w,
                    child: TextApp(
                      text: category.discription,
                      textStyle: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: ZnoonaColors.text(context).withAlpha(200),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomFadeInLeft(
              duration: 700,
              child: CachedNetworkImage(
                imageUrl: category.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 90.w,
                height: 90.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
