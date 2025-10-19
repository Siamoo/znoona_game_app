import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_creation_body.dart';

class RoomAbout extends StatelessWidget {
  const RoomAbout({
    required this.widget,
    super.key,
  });

  final RoomCreationBody widget;

  @override
  Widget build(BuildContext context) {
    return TextApp(
      text:
          '${ZnoonaTexts.tr(context, LangKeys.roomAbout)} ${ZnoonaTexts.tr(context, widget.categoryName)}',
      textStyle: GoogleFonts.beiruti(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ZnoonaColors.text(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}
