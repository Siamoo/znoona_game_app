import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/room.dart';
import '../../domain/entities/room_player.dart';
import '../../domain/entities/room_question.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String id,
    required String code,
    required String hostId,
    required String status,
    String? categoryId,
    String? title,
    Map<String, dynamic>? state,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id']?.toString() ?? '', // 🔒 حماية من null
      code: json['code']?.toString() ?? '',
      hostId: json['host_id']?.toString() ?? '',
      categoryId: json['category_id']?.toString(),
      status: json['status']?.toString() ?? 'waiting',
      title: json['title']?.toString() ?? '',
      state: json['state'] as Map<String, dynamic>? ?? {},
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => RoomPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => RoomQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory RoomModel.fromEntity(Room room) => RoomModel(
        id: room.id,
        code: room.code,
        hostId: room.hostId,
        categoryId: room.categoryId,
        status: room.status,
        state: room.state,
        title: room.title,
        createdAt: room.createdAt,
        players: room.players,
        questions: room.questions,
      );
}

extension RoomModelX on RoomModel {
  Room toEntity() => Room(
        id: id,
        code: code,
        hostId: hostId,
        categoryId: categoryId,
        status: status,
        state: state,
        title: title,
        createdAt: createdAt,
        players: players,
        questions: questions,
      );
}
