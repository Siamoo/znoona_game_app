import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

class PlayerCircleImage extends StatelessWidget {
  const PlayerCircleImage({
    required this.player, super.key,
  });

  final RoomPlayer player;

  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: player.isHost
              ? ZnoonaColors.main(context)
              : Colors.grey.shade300,
          child: Icon(
            player.isHost ? Icons.star : Icons.person,
            color: player.isHost ? Colors.white : Colors.grey.shade600,
          ),
        ),
        if (player.isHost)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
      ],
    );
  }
}
