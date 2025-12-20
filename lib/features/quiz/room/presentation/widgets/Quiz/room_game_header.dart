
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/Quiz/players_status.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/widgets/Quiz/top_player_section.dart';

class RoomGameHeader extends StatelessWidget {
  const RoomGameHeader({
    required this.context,
    required this.remainingTime,
    required this.playerAnswers,
    required this.players,
    required this.correctCount,
    required this.totalQuestions,
    required this.currentUserId,
    super.key,
  });

  final BuildContext context;
  final int remainingTime;
  final Map<String, String?> playerAnswers;
  final List<RoomPlayer> players;
  final int correctCount;
  final int totalQuestions;
  final String currentUserId;

  RoomPlayer? _getTopPlayer(List<RoomPlayer> players) {
    if (players.isEmpty) return null;

    final sortedPlayers = List<RoomPlayer>.from(players)
      ..sort((a, b) {
        if (b.score != a.score) {
          return b.score.compareTo(a.score); // Higher score first
        }
        // If scores are equal, use join time (earlier join wins)
        return (a.joinedAt ?? DateTime.now()).compareTo(
          b.joinedAt ?? DateTime.now(),
        );
      });

    return sortedPlayers.first;
  }

  @override
  Widget build(BuildContext context) {
    final connectedPlayers = players.where((p) => p.isConnected).toList();
    final answeredPlayers = connectedPlayers
        .where(
          (p) =>
              playerAnswers.containsKey(p.userId) &&
              playerAnswers[p.userId] != null,
        )
        .length;
    final totalConnected = connectedPlayers.length;
    final progress = totalConnected > 0
        ? answeredPlayers / totalConnected
        : 0.0;

    final topPlayer = _getTopPlayer(connectedPlayers);

    return Column(
      children: [
        if (topPlayer != null)
          TopPlayerSection(
            context: context,
            topPlayer: topPlayer,
            isCurrentUser: topPlayer.userId == currentUserId,
          ),
        SizedBox(height: 16.sp),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '$remainingTime',
                  style: GoogleFonts.beiruti(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ZnoonaColors.text(context),
                  ),
                ),
              ],
            ),
            Text(
              'Score: $correctCount/$totalQuestions',
              style: GoogleFonts.beiruti(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ZnoonaColors.text(context),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.sp),

        PlayersStatus(
          context: context,
          playerAnswers: playerAnswers,
          players: players,
          progress: progress,
          answeredPlayers: answeredPlayers,
          totalConnected: totalConnected,
        ),
      ],
    );
  }
}
