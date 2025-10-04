import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/di/injcetion_container.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/cubit/questions_cubit.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/refactors/quiz_body.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({required this.categoryId, required this.categoryName, super.key});
  final String categoryId;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuestionsCubit>()..loadQuestions(categoryId),
      child: QuizBody(
        categoryId: categoryId, categoryName: categoryName,
      ),
    );
  }
}
