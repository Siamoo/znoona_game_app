
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

part 'room.freezed.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String code, 
    required String hostId, 
    required List<RoomPlayer> players,
    required RoomStatus status,
    required DateTime createdAt,
  }) = _Room;
}

enum RoomStatus {
  waiting,   
  playing,   
  finished,  
}
