// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomPlayerModelImpl _$$RoomPlayerModelImplFromJson(
  Map<String, dynamic> json,
) => _$RoomPlayerModelImpl(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  userId: json['userId'] as String,
  username: json['username'] as String,
  isHost: json['isHost'] as bool,
  isConnected: json['isConnected'] as bool,
  score: (json['score'] as num).toInt(),
  joinedAt: json['joinedAt'] == null
      ? null
      : DateTime.parse(json['joinedAt'] as String),
);

Map<String, dynamic> _$$RoomPlayerModelImplToJson(
  _$RoomPlayerModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'userId': instance.userId,
  'username': instance.username,
  'isHost': instance.isHost,
  'isConnected': instance.isConnected,
  'score': instance.score,
  'joinedAt': instance.joinedAt?.toIso8601String(),
};
