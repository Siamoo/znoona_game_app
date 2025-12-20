import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/single/data/datasources/questions_remote_data_source.dart';
import 'package:medaan_almaarifa/features/quiz/single/data/models/question_model.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/repositories/questions_repository.dart';

class QuestionsRepositoryImpl implements QuestionsRepository {
  QuestionsRepositoryImpl(this.remoteDataSource);
  final QuestionsRemoteDataSource remoteDataSource;

  @override
  Future<Either<String, List<Question>>> getQuestionsByCategory(
    String categoryId,
  ) async {
    try {
      final models = await remoteDataSource
          .getQuestionsByCategory(categoryId);

      final questions = models
          .map((model) => model.toEntity())
          .toList();

      return Right(questions);
    }on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
