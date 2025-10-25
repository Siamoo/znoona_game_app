import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_load_questions_body.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/players_list.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/room_info_card.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/lobby/start_game_button.dart';

class RoomLobbyBody extends StatefulWidget {
  const RoomLobbyBody({required this.room, super.key});
  final Room room;

  @override
  State<RoomLobbyBody> createState() => _RoomLobbyBodyState();
}

class _RoomLobbyBodyState extends State<RoomLobbyBody> {
  @override
  void initState() {
    super.initState();
    _startWatching();
  }

  void _startWatching() {
    context.read<RoomCubit>().watchRoom(widget.room.id);
    context.read<RoomCubit>().watchRoomPlayers(widget.room.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            gameStarted: () {
              _navigateToGameScreen();
            },
            roomUpdated: (room) {
              if (room != null && room.status == 'playing') {
                _navigateToGameScreen();
              }
            },
            left: () {
              Navigator.pop(context);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(
                    title: LangKeys.room,
                    icon: Icons.close,
                    onTap: () {
                      context.read<RoomCubit>().leaveRoom();
                    },
                  ),
                  RoomInfoCard(room: _getCurrentRoom(state) ?? widget.room),
                  SizedBox(height: 24.h),
                  PlayersList(roomId: widget.room.id),
                  SizedBox(height: 24.h),
                  StartGameButton(room: _getCurrentRoom(state) ?? widget.room),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Room? _getCurrentRoom(RoomState state) {
    return state.maybeWhen(
      roomUpdated: (room) => room,
      roomLoaded: (room) => room,
      joined: (room) => room,
      orElse: () => null,
    );
  }

  void _navigateToGameScreen() {
    // Use a small delay to ensure the state is properly updated
    Future.delayed(const Duration(milliseconds: 100), () async {
      if (mounted) {
        await ZnoonaNavigate.pushReplacementTo(
          context,
          RoomLoadQuestionsBody(room: widget.room),
        );
      }
    });
  }
}
