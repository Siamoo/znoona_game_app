import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';

class LeaveRoomUseCase {
  LeaveRoomUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, void>> call() {
    print('🟥🟥 leaveRoom user removed from USECASE');
    return repository.leaveFromAllRooms();
  }
}
