import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class GetQuestionUseCase {
  GetQuestionUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, Question>> call(String questionId) {
    return repository.getQuestion(questionId);
  }
}