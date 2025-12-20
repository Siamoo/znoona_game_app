import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_player.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';


class JoinRoomUseCase {
  JoinRoomUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, RoomPlayer>> call({
    required String code,

  }) {
    return repository.joinRoom(
      code: code,

    );
  }
}
