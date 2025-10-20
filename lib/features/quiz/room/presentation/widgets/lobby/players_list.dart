import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/player_list_item.dart';

class PlayersList extends StatelessWidget {
  const PlayersList({required this.roomId, super.key});
  final String roomId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ZnoonaTexts.tr(context, LangKeys.players),
            style: GoogleFonts.beiruti(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ZnoonaColors.text(context),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: BlocBuilder<RoomCubit, RoomState>(
              builder: (context, state) {
                final players = state.maybeWhen(
                  playersUpdated: (players) => players,
                  orElse: () => <RoomPlayer>[],
                );

                if (players.isEmpty) {
                  return Center(
                    child: Text(
                      ZnoonaTexts.tr(context, LangKeys.waitingPlayers),
                      style: GoogleFonts.beiruti(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ZnoonaColors.text(context),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: players.length,
                  itemBuilder: (context, index) {
                    final player = players[index];
                    return PlayerListItem(player: player);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
