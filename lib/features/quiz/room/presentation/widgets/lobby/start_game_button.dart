import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/common/widgets/custom_linear_button.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/core/helpers/znoona_texts.dart';
import 'package:medaan_almaarifa/core/language/lang_keys.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({required this.room, super.key});
  final Room room;

  @override
  Widget build(BuildContext context) {
    final currentUserId = _getCurrentUserId();
    final isHost = room.hostId == currentUserId;

    if (!isHost) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            const Icon(Icons.hourglass_empty, size: 40, color: Colors.grey),
            SizedBox(height: 8.h),
            Text(
              ZnoonaTexts.tr(context, LangKeys.waitingForHost),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.h, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        final players = state.maybeWhen(
          playersUpdated: (players) => players,
          orElse: () => <RoomPlayer>[],
        );
        final isLoading = state.maybeMap(
          loading: (_) => true,
          orElse: () => false,
        );

        final canStart = players.length >= 2;

        return Column(
          children: [
            CustomLinearButton(
              width: double.infinity,
              height: 50.h,
              onPressed: canStart
                  ? () async {
                      await context.read<RoomCubit>().startGame(room.id);
                    }
                  : () async {
                      await showCanNotStartGameDialog(context, players.length);
                    },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      ZnoonaTexts.tr(
                        context,
                        LangKeys.startGame,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  String _getCurrentUserId() {
    final user = Supabase.instance.client.auth.currentUser;
    return user?.id ?? '';
  }
}

Future<void> showCanNotStartGameDialog(
  BuildContext context,
  int playerCount,
) async {
  await showDialog<dynamic>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ZnoonaColors.bluePinkDark(context),

      content: Text(
        ZnoonaTexts.tr(
          context,
          LangKeys.mustHaveTwoPlayers,
        ),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: CustomLinearButton(
            onPressed: () {
              Navigator.pop(context);
            },

            child: Text(
              ZnoonaTexts.tr(
                context,
                LangKeys.ok,
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
