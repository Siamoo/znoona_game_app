
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_player.freezed.dart';

@freezed
class RoomPlayer with _$RoomPlayer {
  const factory RoomPlayer({
    required String id,
    required String name,
    required int score,
    required bool isHost,
  }) = _RoomPlayer;
}
