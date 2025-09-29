
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/routes/app_routes.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    required this.text, super.key,
  });
  final String text ;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInDown(
      duration: 400,
      child: TextButton(
        onPressed: () async {
          await ZnoonaNavigate.pushNamed(context, AppRoutes.signUp);
        },
        child: TextApp(
          text: text,
          textStyle: GoogleFonts.beiruti(
            fontSize: 20.sp,
            color: ZnoonaColors.bluePinkLight(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
