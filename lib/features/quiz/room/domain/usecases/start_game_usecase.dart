import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';

class StartGameUseCase {
  StartGameUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, void>> call(String roomId) {
    return repository.startGame(roomId);
  }
}
