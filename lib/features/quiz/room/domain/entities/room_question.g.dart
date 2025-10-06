// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomQuestionImpl _$$RoomQuestionImplFromJson(Map<String, dynamic> json) =>
    _$RoomQuestionImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      questionId: json['questionId'] as String,
      orderIndex: (json['orderIndex'] as num).toInt(),
    );

Map<String, dynamic> _$$RoomQuestionImplToJson(_$RoomQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'questionId': instance.questionId,
      'orderIndex': instance.orderIndex,
    };
