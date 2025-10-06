// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomModelImpl _$$RoomModelImplFromJson(Map<String, dynamic> json) =>
    _$RoomModelImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      hostId: json['hostId'] as String,
      status: json['status'] as String,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String?,
      state: json['state'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      players: (json['players'] as List<dynamic>?)
          ?.map((e) => RoomPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => RoomQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomModelImplToJson(_$RoomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hostId': instance.hostId,
      'status': instance.status,
      'categoryId': instance.categoryId,
      'title': instance.title,
      'state': instance.state,
      'createdAt': instance.createdAt?.toIso8601String(),
      'players': instance.players,
      'questions': instance.questions,
    };
