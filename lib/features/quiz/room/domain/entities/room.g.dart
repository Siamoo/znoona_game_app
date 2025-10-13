// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: json['id'] as String,
  code: json['code'] as String,
  hostId: json['hostId'] as String,
  status: json['status'] as String,
  categoryId: json['categoryId'] as String?,
  state: json['state'] as Map<String, dynamic>?,
  title: json['title'] as String?,
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

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hostId': instance.hostId,
      'status': instance.status,
      'categoryId': instance.categoryId,
      'state': instance.state,
      'title': instance.title,
      'createdAt': instance.createdAt?.toIso8601String(),
      'players': instance.players,
      'questions': instance.questions,
    };
