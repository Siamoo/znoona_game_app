import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/common/widgets/text_app.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';

class CustomSectionTitle extends StatelessWidget {
  const CustomSectionTitle({
    required this.langkey,
    super.key,
  });

  final String langkey;

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text: ZnoonaTexts.tr(context, langkey),
      textStyle: GoogleFonts.beiruti(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: ZnoonaColors.text(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}
