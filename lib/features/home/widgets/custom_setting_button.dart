import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';

class CustomSettingButton extends StatelessWidget {
  const CustomSettingButton({
    required this.title,
    required this.imageUrl,
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  final String title;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextApp(
            text: ZnoonaTexts.tr(
              context,
              title,
            ),
            textStyle: GoogleFonts.beiruti(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.end,
          ),
          SvgPicture.asset(
            imageUrl,
            width: 20.w,
            height: 20.h,
            colorFilter: const  ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ), // optional to colorize
          ),
        ],
      ),
    );
  }
}
