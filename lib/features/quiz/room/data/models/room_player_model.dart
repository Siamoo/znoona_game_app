// lib/features/quiz/room/data/models/room_player_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';

part 'room_player_model.freezed.dart';
part 'room_player_model.g.dart';

@freezed
class RoomPlayerModel with _$RoomPlayerModel {
  const factory RoomPlayerModel({
    required String id,
    required String name,
    required int score,
    required bool isHost,
  }) = _RoomPlayerModel;

  factory RoomPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$RoomPlayerModelFromJson(json);

  factory RoomPlayerModel.fromEntity(RoomPlayer entity) => RoomPlayerModel(
        id: entity.id,
        name: entity.name,
        score: entity.score,
        isHost: entity.isHost,
      );
}

extension RoomPlayerModelX on RoomPlayerModel {
  RoomPlayer toEntity() => RoomPlayer(
        id: id,
        name: name,
        score: score,
        isHost: isHost,
      );
}
