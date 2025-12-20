import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/repositories/room_repository.dart';


class GetRoomsStreamUseCase {
  GetRoomsStreamUseCase(this.repository);
  final RoomRepository repository;


  Stream<Either<String, List<Room>>> call() {
    return repository.getRoomsStream();
  }
}
