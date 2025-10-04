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
      players: (json['players'] as List<dynamic>)
          .map((e) => RoomPlayerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$RoomStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$RoomModelImplToJson(_$RoomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'hostId': instance.hostId,
      'players': instance.players,
      'status': _$RoomStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$RoomStatusEnumMap = {
  RoomStatus.waiting: 'waiting',
  RoomStatus.playing: 'playing',
  RoomStatus.finished: 'finished',
};
