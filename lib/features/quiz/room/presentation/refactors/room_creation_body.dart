import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_lobby_screen.dart';

class RoomCreationBody extends StatelessWidget {
  const RoomCreationBody({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  final String categoryId;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RoomCubit, RoomState>(
        listener: (context, state) {
          state.whenOrNull(
            roomLoaded: (room) {
              ZnoonaNavigate.pushReplacementTo(
                context,
                RoomLobbyScreen(room: room),
              );
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAppBar(
                  title: categoryName,
                ),
                CustomLinearButton(
                  onPressed: () {
                    context.read<RoomCubit>().createRoom(
                      categoryId: categoryId,
                    );
                  },

                  child: const Text(
                    'Create Room',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
