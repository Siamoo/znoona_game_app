import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';

abstract class QuestionsRepository {
  Future<Either<String, List<Question>>> getQuestionsByCategory(
    String categoryId,
  );
}
