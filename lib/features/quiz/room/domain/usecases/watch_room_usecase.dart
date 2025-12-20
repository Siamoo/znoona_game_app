import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';


class WatchRoomUseCase {
  WatchRoomUseCase(this.repository);
  final RoomRepository repository;

  Stream<Either<String, Room?>> call(String roomId) {
    return repository.watchRoom(roomId);
  }
}
