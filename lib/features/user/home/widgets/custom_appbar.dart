
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(profile.avatarUrl!),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextApp(
              text: ZnoonaTexts.tr(context, LangKeys.hello),
              textStyle: GoogleFonts.beiruti(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: ZnoonaColors.text(context).withAlpha(100),
              ),
              textAlign: TextAlign.center,
            ),
            TextApp(
              text: profile.fullName,
              textStyle: GoogleFonts.beiruti(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: ZnoonaColors.text(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const Spacer(),
        Icon(
          Icons.control_point_sharp,
        ),
      ],
    );
  }
}
