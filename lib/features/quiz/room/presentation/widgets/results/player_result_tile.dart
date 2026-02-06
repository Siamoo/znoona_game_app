import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/data/models/player_result.dart';

class PlayerResultTile extends StatelessWidget {
  const PlayerResultTile({
    required this.result,
    required this.showRank,
    super.key,
  });
  final PlayerResult result;
  final bool showRank;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: result.isCurrentUser
            ? ZnoonaColors.main(context)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: result.isCurrentUser
            ? Border.all(color: Colors.blue.shade200)
            : null,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: Image.network(result.avatarUrl!).image,
          backgroundColor: Colors.transparent,
        ),
        title: Row(
          children: [
            Text(
              result.username,
              style: GoogleFonts.beiruti(
                fontSize: 16.h,
                fontWeight: FontWeight.bold,
                color: ZnoonaColors.text(context),
              ),
            ),
            if (result.isCurrentUser) ...[
              SizedBox(width: 8.w),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  ZnoonaTexts.tr(context, LangKeys.you),
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          ' ${result.correctAnswers}/${result.totalQuestions}     ${ZnoonaTexts.tr(context, LangKeys.score)} :  ${result.score} ',
          style: GoogleFonts.beiruti(
            fontSize: 12.h,
            fontWeight: FontWeight.bold,
            color: ZnoonaColors.text(context).withAlpha(170),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (result.finishedQuiz) ...[
              Icon(Icons.flag, color: Colors.green, size: 18.h),
              const SizedBox(width: 4),
              Text(
                ZnoonaTexts.tr(context, LangKeys.finished),
                style: GoogleFonts.beiruti(
                  fontSize: 12.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ] else ...[
              Icon(Icons.play_arrow, color: Colors.orange, size: 18.h),
              const SizedBox(width: 4),
              Text(
                ZnoonaTexts.tr(context, LangKeys.play),
                style: GoogleFonts.beiruti(
                  fontSize: 12.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
