import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';


class CreateRoomUseCase {
  CreateRoomUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, Room>> call({
    required String categoryId,
    required int timerDuration,

  }) {
    return repository.createRoom(
      categoryId: categoryId,
      timerDuration: timerDuration,

    );
  }
}
