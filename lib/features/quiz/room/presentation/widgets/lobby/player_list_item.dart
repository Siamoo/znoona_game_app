import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/host_or_player_name.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/player_circle_image.dart';

class PlayerListItem extends StatelessWidget {
  const PlayerListItem({required this.player, super.key});
  final RoomPlayer player;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: PlayerCircleImage(player: player),
        title: HostOrPlayerName(player: player),
        subtitle: Text(
          player.isHost
              ? ZnoonaTexts.tr(context, LangKeys.roomHost)
              : ZnoonaTexts.tr(context, LangKeys.player),
          style: TextStyle(
            color: player.isHost
                ? Colors.black.withAlpha(200)
                : Colors.black.withAlpha(150),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: player.isConnected
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                player.isConnected ? Icons.wifi : Icons.wifi_off,
                color: player.isConnected ? Colors.green : Colors.red,
                size: 16,
              ),
            ),
            // const SizedBox(width: 8),
            // Text(
            //   '${player.score} pts',
            //   style: const TextStyle(fontWeight: FontWeight.w600),
            // ),
          ],
        ),
      ),
    );
  }
}
