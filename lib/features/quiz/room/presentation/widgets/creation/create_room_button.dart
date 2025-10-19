import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

class CreateRoomButton extends StatelessWidget {
  const CreateRoomButton({
    required this.selectedTimerDuration,
    required this.state,
    required this.categoryId,
    super.key,
  });
  final String categoryId;
  final int selectedTimerDuration;
  final RoomState state;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      height: 50.h,
      onPressed: () async {
        await context.read<RoomCubit>().createRoom(
          categoryId: categoryId,
          timerDuration: selectedTimerDuration,
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
    );
  }
}
