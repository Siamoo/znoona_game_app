import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    required this.text,
    required this.onPressed,
    super.key,
  });
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomFadeInDown(
      duration: 400,
      child: TextButton(
        onPressed: onPressed,
        child: TextApp(
          text: text,
          textStyle: GoogleFonts.beiruti(
            fontSize: 20.h,
            color: ZnoonaColors.bluePinkLight(context),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
