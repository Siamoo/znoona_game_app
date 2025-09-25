import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';

class DarkAndLangButtons extends StatelessWidget {
  const DarkAndLangButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFadeInRight(
              duration: 400,
              child: CustomLinearButton(
                onPressed: () async {
                  await cubit.changeAppThemeMode();
                },
                child: Icon(
                  cubit.isDarkMode
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            CustomFadeInLeft(
              duration: 400,
              child: CustomLinearButton(
                onPressed: () {},
                width: 100.w,
                height: 44.h,
                child: TextApp(
                  text: ZnoonaTexts.tr(context, LangKeys.language),
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
