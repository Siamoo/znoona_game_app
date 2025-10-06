import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/room_player.dart';

part 'room_player_model.freezed.dart';
part 'room_player_model.g.dart';

@freezed
class RoomPlayerModel with _$RoomPlayerModel {
  const factory RoomPlayerModel({
    required String id,
    required String roomId,
    required String userId,
    required String username, // 🔹 تمت إضافتها
    required bool isHost,
    required bool isConnected, // 🔹 تمت إضافتها
    required int score,
    DateTime? joinedAt,
  }) = _RoomPlayerModel;

  factory RoomPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$RoomPlayerModelFromJson(json);
}

// ✅ التحويلات بين Model و Entity
extension RoomPlayerModelX on RoomPlayerModel {
  RoomPlayer toEntity() => RoomPlayer(
        id: id,
        roomId: roomId,
        userId: userId,
        username: username, // ✅ تمت إضافتها
        isHost: isHost,
        isConnected: isConnected, // ✅ تمت إضافتها
        score: score,
        joinedAt: joinedAt,
      );

  static RoomPlayerModel fromEntity(RoomPlayer player) => RoomPlayerModel(
        id: player.id,
        roomId: player.roomId,
        userId: player.userId,
        username: player.username, // ✅ تمت إضافتها
        isHost: player.isHost,
        isConnected: player.isConnected, // ✅ تمت إضافتها
        score: player.score,
        joinedAt: player.joinedAt,
      );
}
