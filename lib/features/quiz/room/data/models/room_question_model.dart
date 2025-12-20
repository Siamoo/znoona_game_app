import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room_question.dart';

part 'room_question_model.freezed.dart';

@freezed
class RoomQuestionModel with _$RoomQuestionModel {
  const factory RoomQuestionModel({
    required String id,
    required String roomId,
    required String questionId,
    required int orderIndex,
  }) = _RoomQuestionModel;

  factory RoomQuestionModel.fromJson(Map<String, dynamic> json) {
    return RoomQuestionModel(
      id: json['id']?.toString() ?? '',
      roomId: json['room_id']?.toString() ?? '',
      questionId: json['question_id']?.toString() ?? '',
      orderIndex: (json['order_index'] is int)
          ? json['order_index'] as int
          : int.tryParse(json['order_index']?.toString() ?? '0') ?? 0,
    );
  }

  factory RoomQuestionModel.fromEntity(RoomQuestion question) =>
      RoomQuestionModel(
        id: question.id,
        roomId: question.roomId,
        questionId: question.questionId,
        orderIndex: question.orderIndex,
      );
}

extension RoomQuestionModelX on RoomQuestionModel {
  RoomQuestion toEntity() => RoomQuestion(
        id: id,
        roomId: roomId,
        questionId: questionId,
        orderIndex: orderIndex,
      );
}
