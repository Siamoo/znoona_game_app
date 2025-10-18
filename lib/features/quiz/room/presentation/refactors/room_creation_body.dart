import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_navigate.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/screen/room_lobby_screen.dart';

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
  int _selectedTimerDuration = 15; // Default 15 seconds

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
                      child: Image.asset(
                        widget.imageUrl,
                        height: 150.h,
                        width: 150.w,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    CustomFadeInDown(
                      duration: 700,
                      child: TextApp(
                        text:
                            '${ZnoonaTexts.tr(context, LangKeys.roomAbout)} ${ZnoonaTexts.tr(context, widget.categoryName)}',
                        textStyle: GoogleFonts.beiruti(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ZnoonaColors.text(context),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Timer Selection Section
                    CustomFadeInDown(
                      duration: 600,
                      child: _buildTimerSelectionSection(context),
                    ),

                    SizedBox(height: 40.h),

                    // Create Room Button
                    CustomFadeInDown(
                      duration: 400,
                      child: CustomLinearButton(
                        onPressed: () {
                          context.read<RoomCubit>().createRoom(
                            categoryId: widget.categoryId,
                            timerDuration: _selectedTimerDuration,
                          );
                        },
                        child: state.maybeMap(
                          loading: (_) => const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          ),
                          orElse: () => Text(
                            ZnoonaTexts.tr(context, LangKeys.createRoom),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
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

  Widget _buildTimerSelectionSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ZnoonaColors.bluePinkDark(context).withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ZnoonaColors.bluePinkDark(context).withAlpha(100),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer,
                color: ZnoonaColors.bluePinkDark(context),
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                ZnoonaTexts.tr(context, LangKeys.questionTimer),
                style: GoogleFonts.beiruti(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.text(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Text(
            ZnoonaTexts.tr(context, LangKeys.selectTimerDuration),
            style: TextStyle(
              fontSize: 14.sp,
              color: ZnoonaColors.text(context).withAlpha(150),
            ),
          ),
          SizedBox(height: 16.h),

          // Timer Options
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 200.h, // Adjust this value as needed
            ),
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children:
                    [
                      5,
                      6,
                      7,
                      8,
                      9,
                      10,
                      11,
                      12,
                      13,
                      14,
                      15,
                      16,
                      17,
                      18,
                      19,
                      20,
                    ].map((duration) {
                      return _TimerOption(
                        duration: duration,
                        isSelected: _selectedTimerDuration == duration,
                        onSelected: (selectedDuration) {
                          setState(() {
                            _selectedTimerDuration = selectedDuration;
                          });
                        },
                      );
                    }).toList(),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Selected Timer Display
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ZnoonaColors.bluePinkDark(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  '$_selectedTimerDuration ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerOption extends StatelessWidget {
  const _TimerOption({
    required this.duration,
    required this.isSelected,
    required this.onSelected,
  });
  final int duration;
  final bool isSelected;
  final dynamic Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(duration),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ZnoonaColors.bluePinkDark(context)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ZnoonaColors.bluePinkDark(context),
            width: isSelected ? 0 : 1,
          ),
        ),
        child: Text(
          '$duration ',
          style: TextStyle(
            color: isSelected ? Colors.white : ZnoonaColors.text(context),
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
