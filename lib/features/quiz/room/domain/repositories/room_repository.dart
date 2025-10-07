import 'package:dartz/dartz.dart';
import '../entities/room.dart';
import '../entities/room_player.dart';
import '../entities/room_question.dart';

abstract class RoomRepository {
  Future<Either<String, Room>> createRoom({
    required String categoryId,
  });

  Future<Either<String, RoomPlayer>> joinRoom({
    required String code,

  });

  Future<Either<String, void>> leaveRoom({
    required String roomId,
  });

  Stream<Either<String, List<Room>>> getRoomsStream();

  Stream<Either<String, List<RoomPlayer>>> getRoomPlayersStream(String roomId);

  Future<Either<String, List<RoomQuestion>>> getRoomQuestions(String roomId);

  Future<Either<String, void>> startGame(String roomId);

  Stream<Either<String, Room?>> watchRoom(String roomId);
}
