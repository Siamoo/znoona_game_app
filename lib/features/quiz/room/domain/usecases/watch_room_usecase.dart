import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';


class WatchRoomUseCase {
  WatchRoomUseCase(this.repository);
  final RoomRepository repository;

  Stream<Either<String, Room?>> call(String roomId) {
    return repository.watchRoom(roomId);
  }
}
