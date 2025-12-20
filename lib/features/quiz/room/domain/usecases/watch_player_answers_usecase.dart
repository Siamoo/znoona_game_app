import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';

class WatchPlayerAnswersUseCase {
  WatchPlayerAnswersUseCase(this.repository);
  final RoomRepository repository;

  Stream<Either<String, Map<String, String>>> call(String roomId) {
    return repository.watchPlayerAnswers(roomId);
  }
}