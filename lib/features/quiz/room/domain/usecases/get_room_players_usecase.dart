import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';

class GetRoomPlayersUseCase {
  GetRoomPlayersUseCase(this.repository);
  final RoomRepository repository;

  Future<Either<String, List<RoomPlayer>>> call(String roomId) {
    return repository.getRoomPlayers(roomId);
  }
}