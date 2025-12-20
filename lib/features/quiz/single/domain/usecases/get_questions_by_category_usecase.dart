import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/repositories/questions_repository.dart';

part 'get_questions_by_category_usecase.freezed.dart';

class GetQuestionsByCategoryUseCase {
  GetQuestionsByCategoryUseCase(this.repository);
  final QuestionsRepository repository;

  Future<Either<String, List<Question>>> call(
    GetQuestionsByCategoryParams params,
  ) {
    return repository.getQuestionsByCategory(params.categoryId);
  }
}

@freezed
class GetQuestionsByCategoryParams with _$GetQuestionsByCategoryParams {
  const factory GetQuestionsByCategoryParams({
    required String categoryId,
  }) = _GetQuestionsByCategoryParams;
}
