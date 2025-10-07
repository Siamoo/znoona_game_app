import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

part 'room_player_model.freezed.dart';

@freezed
class RoomPlayerModel with _$RoomPlayerModel {
  const factory RoomPlayerModel({
    required String id,
    required String roomId,
    required String userId,
    required String username,
    required bool isHost,
    required bool isConnected,
    required int score,
    DateTime? joinedAt,
  }) = _RoomPlayerModel;

  factory RoomPlayerModel.fromJson(Map<String, dynamic> json) {
    return RoomPlayerModel(
      id: json['id']?.toString() ?? '',
      roomId: json['room_id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      username: json['username']?.toString() ?? 'Unknown',
      isHost: json['is_host'] == true,
      isConnected: json['is_connected'] == true,
      score: (json['score'] is int)
          ? json['score'] as int
          : int.tryParse(json['score']?.toString() ?? '0') ?? 0,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'].toString())
          : null,
    );
  }

  factory RoomPlayerModel.fromEntity(RoomPlayer player) => RoomPlayerModel(
        id: player.id,
        roomId: player.roomId,
        userId: player.userId,
        username: player.username,
        isHost: player.isHost,
        isConnected: player.isConnected,
        score: player.score,
        joinedAt: player.joinedAt,
      );
}

extension RoomPlayerModelX on RoomPlayerModel {
  RoomPlayer toEntity() => RoomPlayer(
        id: id,
        roomId: roomId,
        userId: userId,
        username: username,
        isHost: isHost,
        isConnected: isConnected,
        score: score,
        joinedAt: joinedAt,
      );
}
