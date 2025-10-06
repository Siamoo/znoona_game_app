// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomQuestionModelImpl _$$RoomQuestionModelImplFromJson(
  Map<String, dynamic> json,
) => _$RoomQuestionModelImpl(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  questionId: json['questionId'] as String,
  orderIndex: (json['orderIndex'] as num).toInt(),
);

Map<String, dynamic> _$$RoomQuestionModelImplToJson(
  _$RoomQuestionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'questionId': instance.questionId,
  'orderIndex': instance.orderIndex,
};
