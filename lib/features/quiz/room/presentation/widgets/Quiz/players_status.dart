import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

class PlayersStatus extends StatelessWidget {
  const PlayersStatus({
    required this.context,
    required this.playerAnswers,
    required this.players,
    required this.progress,
    required this.answeredPlayers,
    required this.totalConnected,
    super.key,
  });

  final BuildContext context;
  final Map<String, String?> playerAnswers;
  final List<RoomPlayer> players;
  final double progress;
  final int answeredPlayers;
  final int totalConnected;

  @override
  Widget build(BuildContext context) {
    if (players.isEmpty) return const SizedBox();

    return Column(
      children: [
        // Progress bar
        Container(
          width: double.infinity,
          height: 8.sp,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4.sp),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 8.sp,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4.sp),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: MediaQuery.of(context).size.width * progress,
                height: 8.sp,
                decoration: BoxDecoration(
                  color: _getProgressColor(progress),
                  borderRadius: BorderRadius.circular(4.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.sp),

        Wrap(
          spacing: 8.sp,
          children: players.where((p) => p.isConnected).map((player) {
            final hasAnswered = player.selectedAnswer != null;
            final isCorrect = player.isCorrect ?? false;

            Color backgroundColor;
            IconData icon;
            var tooltipText = '';

            if (!hasAnswered) {
              backgroundColor = ZnoonaColors.containerShadow2(context);
              icon = Icons.person;
              tooltipText = '${player.username} - Not answered';
            } else if (isCorrect) {
              backgroundColor = Colors.green;
              icon = Icons.check;
              tooltipText = '${player.username} - Correct!';
            } else {
              backgroundColor = Colors.red;
              icon = Icons.close;
              tooltipText = '${player.username} - Wrong answer';
            }
            return Tooltip(
              message: tooltipText,
              child: Chip(
                label: Text(
                  player.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: backgroundColor,
                avatar: Icon(
                  icon,
                  size: 16.sp,
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),

        // Progress text
        Text(
          '$answeredPlayers/$totalConnected players answered',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.5) {
      return ZnoonaColors.bluePinkLight(context).withAlpha(150);
    }
    if (progress < 1.0) {
      return ZnoonaColors.bluePinkLight(context).withAlpha(190);
    }
    return ZnoonaColors.bluePinkLight(context);
  }
}
