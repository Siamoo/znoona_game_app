
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

class JoinRoomButton extends StatelessWidget {
  const JoinRoomButton({
    required this.isLoading,
    required this.formKey,
    required this.codeController,
    super.key,
  });

  final bool isLoading;
  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return CustomLinearButton(
      height: 50.h,
      onPressed: isLoading
          ? null
          : () async {
              if (formKey.currentState!.validate()) {
                await context.read<RoomCubit>().joinRoom(
                  code: codeController.text.trim(),
                );
              }
            },

      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  Colors.white,
                ),
              ),
            )
          : Text(
              ZnoonaTexts.tr(
                context,
                LangKeys.joinRoom,
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }
}
