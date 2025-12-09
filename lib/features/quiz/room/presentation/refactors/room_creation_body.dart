import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_lobby_screen.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/creation/build_timer_selection_section.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/creation/create_room_button.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/widgets/creation/room_about.dart';

class RoomCreationBody extends StatefulWidget {
  const RoomCreationBody({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl,
    super.key,
  });

  final String categoryId;
  final String categoryName;
  final String imageUrl;

  @override
  State<RoomCreationBody> createState() => _RoomCreationBodyState();
}

class _RoomCreationBodyState extends State<RoomCreationBody> {
  int _selectedTimerDuration = 13;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) async {
          await state.whenOrNull(
            roomLoaded: (room) async {
              await ZnoonaNavigate.pushReplacementTo(
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
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomAppBar(
                      title: ZnoonaTexts.tr(context, LangKeys.createRoom),
                    ),
                    SizedBox(height: 20.h),
                    // Category Info
                    CustomFadeInDown(
                      duration: 850,
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          AppImages.science,
                        ),
                        height: 150.h,
                        width: 150.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    CustomFadeInDown(
                      duration: 700,
                      child: RoomAbout(widget: widget),
                    ),

                    SizedBox(height: 40.h),
                    // Timer Selection Section
                    CustomFadeInDown(
                      duration: 600,
                      child: BuildTimerSelectionSection(
                        selectedTimerDuration: _selectedTimerDuration,
                        onSelected: (selectedDuration) {
                          setState(() {
                            _selectedTimerDuration = selectedDuration;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 40.h),
                    // Create Room Button
                    CustomFadeInDown(
                      duration: 400,
                      child: CreateRoomButton(
                        selectedTimerDuration: _selectedTimerDuration,
                        state: state,
                        categoryId: widget.categoryId,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
