import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';

class GetQuestionsUseCase {
  GetQuestionsUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, List<Question>>> call(List<String> questionIds) {
    return repository.getQuestions(questionIds);
  }
}