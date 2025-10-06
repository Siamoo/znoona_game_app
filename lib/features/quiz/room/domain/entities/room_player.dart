import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_player.freezed.dart';
part 'room_player.g.dart';

@freezed
class RoomPlayer with _$RoomPlayer {
  const factory RoomPlayer({
    required String id,
    required String roomId,
    required String userId,
    required String username,
    required bool isHost,
    required bool isConnected,
    required int score,
    DateTime? joinedAt,
  }) = _RoomPlayer;

  factory RoomPlayer.fromJson(Map<String, dynamic> json) =>
      _$RoomPlayerFromJson(json);
}
