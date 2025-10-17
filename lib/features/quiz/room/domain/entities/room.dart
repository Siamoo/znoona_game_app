import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String code,
    required String hostId,
    required String status,     // waiting | playing | finished
    String? categoryId,
    Map<String, dynamic>? state,
    String? title,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
    required int timerDuration,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
