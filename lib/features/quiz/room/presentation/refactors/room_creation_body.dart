import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
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
      body: BlocConsumer<RoomCubit, RoomState>(
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
        builder: (BuildContext context, RoomState state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomAppBar(
                    title: ZnoonaTexts.tr(context, LangKeys.createRoom),
                  ),
                  SizedBox(height: 50.h),
                  TextApp(
                    text:
                        '${ZnoonaTexts.tr(context, LangKeys.roomAbout)} ${ZnoonaTexts.tr(context, categoryName)}',
                    textStyle: GoogleFonts.beiruti(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: ZnoonaColors.text(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  SizedBox(height: 50.h),
                  CustomLinearButton(
                    onPressed: () {
                      context.read<RoomCubit>().createRoom(
                        categoryId: categoryId,
                      );
                    },

                    child: Text(
                      ZnoonaTexts.tr(context, LangKeys.createRoom),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
