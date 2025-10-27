import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/player_result.dart';

class UserRankCard extends StatelessWidget {
  const UserRankCard({
    required this.userResult,
    required this.results,
    super.key,
  });
  final PlayerResult userResult;
  final List<PlayerResult> results;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ZnoonaColors.containerLinear2(context),
              ZnoonaColors.containerLinear1(context),
              ZnoonaColors.containerLinear2(context),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: Image.network(userResult.avatarUrl!).image,
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userResult.username,
                    style: GoogleFonts.beiruti(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${ZnoonaTexts.tr(context, LangKeys.yourRank)} : ${userResult.rank}',
                    style: GoogleFonts.beiruti(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context).withAlpha(170),
                    ),
                  ),
                  Text(
                    '${ZnoonaTexts.tr(context, LangKeys.youScore)} ${userResult.correctAnswers}  ${ZnoonaTexts.tr(context, LangKeys.from)}  ${userResult.totalQuestions}  ${ZnoonaTexts.tr(context, LangKeys.question)}',
                    style: GoogleFonts.beiruti(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context).withAlpha(170),
                    ),
                  ),
                  if (_hasTies(userResult.rank, results)) ...[
                    const SizedBox(height: 4),
                    Text(
                      ZnoonaTexts.tr(context, LangKeys.tiedPlayers),
                      style: GoogleFonts.beiruti(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ZnoonaColors.text(context).withAlpha(170),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              _getTrophyIcon(userResult.rank),
              color: Colors.white,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }

  bool _hasTies(int rank, List<PlayerResult> results) {
    return results.where((r) => r.rank == rank).length > 1;
  }

  IconData _getTrophyIcon(int rank) {
    if (rank == 1) return Icons.emoji_events;
    if (rank == 2) return Icons.workspace_premium;
    if (rank == 3) return Icons.military_tech;
    return Icons.star;
  }
}
