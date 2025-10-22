// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomPlayerImpl _$$RoomPlayerImplFromJson(Map<String, dynamic> json) =>
    _$RoomPlayerImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      isHost: json['isHost'] as bool,
      isConnected: json['isConnected'] as bool,
      score: (json['score'] as num).toInt(),
      finishedQuiz: json['finishedQuiz'] as bool,
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
      selectedAnswer: json['selectedAnswer'] as String?,
      isCorrect: json['isCorrect'] as bool?,
      answeredAt: json['answeredAt'] == null
          ? null
          : DateTime.parse(json['answeredAt'] as String),
      isReady: json['isReady'] as bool?,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$$RoomPlayerImplToJson(_$RoomPlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'userId': instance.userId,
      'username': instance.username,
      'isHost': instance.isHost,
      'isConnected': instance.isConnected,
      'score': instance.score,
      'finishedQuiz': instance.finishedQuiz,
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'joinedAt': instance.joinedAt?.toIso8601String(),
      'selectedAnswer': instance.selectedAnswer,
      'isCorrect': instance.isCorrect,
      'answeredAt': instance.answeredAt?.toIso8601String(),
      'isReady': instance.isReady,
      'avatarUrl': instance.avatarUrl,
    };
