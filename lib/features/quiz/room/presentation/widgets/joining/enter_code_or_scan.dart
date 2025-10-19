
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';

class EnterCodeOrScan extends StatelessWidget {
  const EnterCodeOrScan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text: ZnoonaTexts.tr(
        context,
        LangKeys.enterCodeOrScan,
      ),
      textStyle: GoogleFonts.beiruti(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ZnoonaColors.text(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}
