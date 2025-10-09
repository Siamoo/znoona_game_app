import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';

class WatchPlayerAnswersUseCase {
  WatchPlayerAnswersUseCase(this.repository);
  final RoomRepository repository;

  Stream<Either<String, Map<String, String>>> call(String roomId) {
    return repository.watchPlayerAnswers(roomId);
  }
}