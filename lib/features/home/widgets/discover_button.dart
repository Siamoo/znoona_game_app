import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';

class DiscoverButton extends StatelessWidget {
  const DiscoverButton({
    required this.langKeys,
    required this.appImages,
    super.key, this.onPressed,
  });
  final String appImages;
  final String langKeys;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      borderRadiusNum: 20,
      colors: [
        ZnoonaColors.main(context),

        ZnoonaColors.containerLinear2(context),
      ],
      height: 90.h,
      width: double.infinity,
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180.w,
              child: TextApp(
                text: ZnoonaTexts.tr(context, langKeys),
                textStyle: GoogleFonts.beiruti(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                  color: ZnoonaColors.text(context),
                ),
              ),
            ),
            Image.asset(
              appImages,
              height: 80.h,
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }
}
