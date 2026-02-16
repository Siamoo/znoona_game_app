import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';

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

  RoomPlayer? _getCurrentPlayer(List<RoomPlayer> players) {
    try {
      return players.firstWhere((player) => player.userId == currentUserId);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectedPlayers = players.where((p) => p.isConnected).toList();
    final topPlayer = _getTopPlayer(connectedPlayers);
    final currentPlayer = _getCurrentPlayer(connectedPlayers);

    final int myScore = currentPlayer?.score ?? correctCount;
    final int topPlayerScore = topPlayer?.score ?? 0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: ZnoonaColors.bluePinkLight(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
          color: ZnoonaColors.bluePinkLight(context).withOpacity(0.3),
          width: 1.sp,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // My Info (Left side)
          Row(
            children: [
              // My Avatar
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ZnoonaColors.main(context),
                    width: 2.sp,
                  ),
                ),
                child: ClipOval(
                  child:
                      currentPlayer?.avatarUrl != null &&
                          currentPlayer!.avatarUrl!.isNotEmpty
                      ? Image.network(
                          currentPlayer.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 20.sp,
                              color: ZnoonaColors.main(context),
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 20.sp,
                          color: ZnoonaColors.main(context),
                        ),
                ),
              ),
              SizedBox(width: 8.sp),

              // My Username and Label
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '👤 You',
                        style: GoogleFonts.beiruti(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.bluePinkLight(context),
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Text(
                        '$myScore',
                        style: GoogleFonts.beiruti(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    currentPlayer?.username ?? 'Player',
                    style: GoogleFonts.beiruti(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // VS Divider
          Container(
            height: 30.h,
            width: 1.w,
            color: ZnoonaColors.text(context).withOpacity(0.2),
          ),

          // Top Player Info (Right side)
          Row(
            children: [
              // Top Player Username and Label
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '$topPlayerScore',
                        style: GoogleFonts.beiruti(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                        ),
                      ),
                      SizedBox(width: 12.sp),
                      Text(
                        '🏆 Top Player',
                        style: GoogleFonts.beiruti(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.bluePinkLight(context),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    topPlayer?.username ?? 'No player',
                    style: GoogleFonts.beiruti(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8.sp),

              // Top Player Avatar
              Container(
                width: 40.sp,
                height: 40.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ZnoonaColors.bluePinkLight(context),
                    width: 2.sp,
                  ),
                ),
                child: ClipOval(
                  child:
                      topPlayer?.avatarUrl != null &&
                          topPlayer!.avatarUrl!.isNotEmpty
                      ? Image.network(
                          topPlayer.avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 20.sp,
                              color: ZnoonaColors.bluePinkLight(context),
                            );
                          },
                        )
                      : Icon(
                          Icons.person,
                          size: 20.sp,
                          color: ZnoonaColors.bluePinkLight(context),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
