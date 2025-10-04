import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/common/widgets/custom_app_bar.dart';
import 'package:znoona_game_app/core/common/widgets/custom_linear_button.dart';
import 'package:znoona_game_app/core/common/widgets/text_app.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';
import 'package:znoona_game_app/core/language/lang_keys.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/widgets/bad_result.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/widgets/good_result_body.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/widgets/won_cup_body.dart';

class ResultBody extends StatelessWidget {
  const ResultBody({
    required this.totalQuestions,
    required this.correctAnswers,
    super.key,
  });
  final int totalQuestions;
  final int correctAnswers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            children: [
              CustomAppBar(title: ZnoonaTexts.tr(context, LangKeys.result)),
              SizedBox(height: 20.h),
              if (correctAnswers >= 14)
                const WonCupBody()
              else if (correctAnswers >= 7 && correctAnswers < 14)
                const GoodResultBody()
              else
                const BadResultBody(),
              TextApp(
                text:
                    '${ZnoonaTexts.tr(context, LangKeys.youScore)} $correctAnswers  ${ZnoonaTexts.tr(context, LangKeys.from)}  $totalQuestions  ${ZnoonaTexts.tr(context, LangKeys.question)}',
                textStyle: GoogleFonts.beiruti(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: ZnoonaColors.text(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 90.h,
              ),
              CustomLinearButton(
                onPressed: () => Navigator.pop(context),
                width: double.infinity,
                height: 44.h,
                child: TextApp(
                  text: ZnoonaTexts.tr(context, LangKeys.back),
                  textStyle: GoogleFonts.beiruti(
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
