import 'package:flutter/material.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/refactors/result_body.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    super.key,
  });
  final int totalQuestions;
  final int correctAnswers;
  @override
  Widget build(BuildContext context) {
    return ResultBody(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
    );
  }
}
