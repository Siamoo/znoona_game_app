
import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

class HostOrPlayerName extends StatelessWidget {
  const HostOrPlayerName({
    required this.player, super.key,
  });

  final RoomPlayer player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          player.username,
          style: TextStyle(
            fontSize: 20,
            fontWeight: player.isHost ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        if (player.isHost) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: ZnoonaColors.main(context).withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              ZnoonaTexts.tr(
                context,
                LangKeys.host,
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
