import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/cubit/questions_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/single/presentation/refactors/quiz_body.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({
    required this.categoryId,
    required this.categoryName,
    required this.timerDuration,
    super.key,
  });
  final String categoryId;
  final String categoryName;
  final int timerDuration;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuestionsCubit>()..loadQuestions(categoryId),
      child: QuizBody(
        categoryId: categoryId,
        categoryName: categoryName,
        timerDuration: timerDuration,
      ),
    );
  }
}
