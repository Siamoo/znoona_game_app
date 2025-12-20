import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';

class SubmitAnswerUseCase {
  SubmitAnswerUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, void>> call({
    required String roomId,
    required String userId,
    required String selectedAnswer,
    required bool isCorrect,
  }) {
    return repository.submitAnswer(
      roomId: roomId,
      userId: userId,
      selectedAnswer: selectedAnswer,
      isCorrect: isCorrect,
    );
  }
}