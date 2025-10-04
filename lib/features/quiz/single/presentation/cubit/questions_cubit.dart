import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';
import 'package:znoona_game_app/features/quiz/single/domain/usecases/get_questions_by_category_usecase.dart';

part 'questions_state.dart';
part 'questions_cubit.freezed.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit(this.getQuestionsByCategory)
    : super(const QuestionsState.initial());
  final GetQuestionsByCategoryUseCase getQuestionsByCategory;

  Future<void> loadQuestions(String categoryId) async {
    emit(const QuestionsState.loading());
    final result = await getQuestionsByCategory(
      GetQuestionsByCategoryParams(categoryId: categoryId),
    );

    result.fold(
      (failure) {
        print(failure);
        emit(QuestionsState.error(failure));
      },
      (questions) => emit(QuestionsState.loaded(questions)),
    );
  }
}
