import 'package:freezed_annotation/freezed_annotation.dart';
import 'room_player.dart';
import 'room_question.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String code,
    required String hostId,
    String? categoryId,
    required String status, // waiting | playing | finished
    Map<String, dynamic>? state,
    String? title,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
