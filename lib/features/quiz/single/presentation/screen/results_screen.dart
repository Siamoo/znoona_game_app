import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/refactors/result_body.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage, super.key,
  });
  final int totalQuestions;
  final int correctAnswers;
  final int scorePercentage;
  @override
  Widget build(BuildContext context) {
    return ResultBody(
      totalQuestions: totalQuestions,
      correctAnswers: correctAnswers,
      scorePercentage: scorePercentage,
    );
  }
}
