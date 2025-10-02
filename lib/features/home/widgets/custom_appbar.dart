import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.profile,
    super.key,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      colors: [
        ZnoonaColors.containerLinear2(context),
        ZnoonaColors.containerLinear1(context),
        ZnoonaColors.containerLinear2(context),
      ],
      borderRadiusNum: 20,
      height: 80.h,
      width: double.infinity,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(profile.avatarUrl!),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextApp(
                  text: ZnoonaTexts.tr(context, LangKeys.hello),
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context).withAlpha(100),
                  ),
                  textAlign: TextAlign.center,
                ),
                TextApp(
                  text: profile.fullName,
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const Spacer(),
            CustomLinearButton(
              borderRadiusNum: 40,
              colors: [
                ZnoonaColors.containerShadow1(context),

                ZnoonaColors.containerShadow1(context),
              ],
              height: 33.h,
              width: 75.w,
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextApp(
                    text: '1',
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w800,
                      color: ZnoonaColors.main(context),
                    ),
                  ),
                  Image.asset(
                    AppImages.level,
                    height: 25.h,
                    width: 25.w,
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
