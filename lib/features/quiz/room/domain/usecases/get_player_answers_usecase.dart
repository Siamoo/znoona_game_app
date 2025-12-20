import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';

class GetPlayerAnswersUseCase {
  GetPlayerAnswersUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, Map<String, String>>> call(String roomId) {
    return repository.getPlayerAnswers(roomId);
  }
}