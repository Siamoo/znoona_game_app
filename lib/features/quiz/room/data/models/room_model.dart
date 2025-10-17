import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_player.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room_question.dart';


part 'room_model.freezed.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String id,
    required String code,
    required String hostId,
    required String status,
    required int timerDuration,
    String? categoryId,
    String? title,
    Map<String, dynamic>? state,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
    
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id']?.toString() ?? '',
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
          timerDuration: (json['timer_duration'] is int) 
          ? json['timer_duration'] as int
          : int.tryParse(json['timer_duration']?.toString() ?? '15') ?? 15,
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
        questions: room.questions, timerDuration: room.timerDuration,
      );
}

extension RoomModelX on RoomModel {
  Room toEntity() => Room(
        id: id,
        code: code,
        hostId: hostId,
        status: status,
        categoryId: categoryId, 
        state: state,
        title: title,
        createdAt: createdAt,
        players: players,
        questions: questions, timerDuration: timerDuration,
      );
}
