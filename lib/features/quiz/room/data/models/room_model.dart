// lib/features/quiz/room/data/models/room_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/data/models/room_player_model.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String id,
    required String code,
    required String hostId,
    required List<RoomPlayerModel> players,
    required RoomStatus status,
    required DateTime createdAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  factory RoomModel.fromEntity(Room entity) => RoomModel(
        id: entity.id,
        code: entity.code,
        hostId: entity.hostId,
        players: entity.players
            .map((player) => RoomPlayerModel.fromEntity(player))
            .toList(),
        status: entity.status,
        createdAt: entity.createdAt,
      );
}

extension RoomModelX on RoomModel {
  Room toEntity() => Room(
        id: id,
        code: code,
        hostId: hostId,
        players: players.map((p) => p.toEntity()).toList(),
        status: status,
        createdAt: createdAt,
      );
}
