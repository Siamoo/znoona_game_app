
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ZnoonaColors.text(context),
              size: 24.sp,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextApp(
            text: ZnoonaTexts.tr(
              context,
              title,
            ),
            textStyle: GoogleFonts.beiruti(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: ZnoonaColors.text(context),
            ),
          ),
        ],
      ),
    );
  }
}
