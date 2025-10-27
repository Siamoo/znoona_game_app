import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/player_result.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/results/player_result_tile.dart';

class ResultsList extends StatelessWidget {
  const ResultsList({
    required this.rankedGroups,
    required this.results,
    required this.finishedPlayers,
    required this.totalPlayers,
    super.key,
  });
  final Map<int, List<PlayerResult>> rankedGroups;
  final List<PlayerResult> results;
  final int finishedPlayers;
  final int totalPlayers;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ZnoonaColors.main(context).withAlpha(150),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.leaderboard,
                  size: 20,
                  color: ZnoonaColors.text(context),
                ),
                const SizedBox(width: 8),
                Text(
                  ZnoonaTexts.tr(context, LangKeys.leaderBoard),
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context),
                  ),
                ),
                const Spacer(),
                Text(
                  '$finishedPlayers/$totalPlayers ${ZnoonaTexts.tr(context, LangKeys.finished)}',
                  style: GoogleFonts.beiruti(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context).withAlpha(170),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  ...rankedGroups.entries.map((entry) {
                    final rank = entry.key;
                    final players = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: _getRankColor(rank),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$rank',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _getRankText(rank, context, players.length),
                                style: GoogleFonts.beiruti(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ZnoonaColors.text(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...players.map(
                          (result) => PlayerResultTile(
                            result: result,
                            showRank: false,
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    );
                  }),
                  if (results.any((r) => r.rank == 0)) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        ZnoonaTexts.tr(context, LangKeys.unranked),
                        style: const  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    ...results
                        .where((r) => r.rank == 0)
                        .map(
                          (result) =>
                              PlayerResultTile(result: result, showRank: true),
                        ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return const Color(0xFFFFD700);
    if (rank == 2) return Colors.blueGrey;
    if (rank == 3) return const Color(0xFFC0C0C0);
    return const Color.fromARGB(255, 224, 29, 29);
  }

  String _getRankText(int rank, BuildContext context, int tiedCount) {
    if (rank == 1) {
      return '${ZnoonaTexts.tr(context, LangKeys.gold)} ${tiedCount > 1 ? ' (${ZnoonaTexts.tr(context, LangKeys.tied)})' : ''}';
    }
    if (rank == 2) {
      return '${ZnoonaTexts.tr(context, LangKeys.silver)} ${tiedCount > 1 ? ' (${ZnoonaTexts.tr(context, LangKeys.tied)})' : ''}';
    }
    if (rank == 3) {
      return '${ZnoonaTexts.tr(context, LangKeys.bronze)} ${tiedCount > 1 ? ' (${ZnoonaTexts.tr(context, LangKeys.tied)})' : ''}';
    }
    return ZnoonaTexts.tr(context, LangKeys.unranked);
  }
}
