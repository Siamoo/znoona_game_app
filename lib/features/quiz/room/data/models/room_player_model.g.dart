// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomPlayerModelImpl _$$RoomPlayerModelImplFromJson(
  Map<String, dynamic> json,
) => _$RoomPlayerModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  score: (json['score'] as num).toInt(),
  isHost: json['isHost'] as bool,
);

Map<String, dynamic> _$$RoomPlayerModelImplToJson(
  _$RoomPlayerModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'score': instance.score,
  'isHost': instance.isHost,
};
