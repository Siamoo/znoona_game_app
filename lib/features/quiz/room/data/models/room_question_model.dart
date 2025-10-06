import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/room_question.dart';

part 'room_question_model.freezed.dart';
part 'room_question_model.g.dart';

@freezed
class RoomQuestionModel with _$RoomQuestionModel {
  const factory RoomQuestionModel({
    required String id,
    required String roomId,
    required String questionId,
    required int orderIndex,
  }) = _RoomQuestionModel;

  factory RoomQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$RoomQuestionModelFromJson(json);
}

// ✅ تحويلات Model ↔ Entity
extension RoomQuestionModelX on RoomQuestionModel {
  RoomQuestion toEntity() => RoomQuestion(
        id: id,
        roomId: roomId,
        questionId: questionId,
        orderIndex: orderIndex,
      );

  static RoomQuestionModel fromEntity(RoomQuestion question) =>
      RoomQuestionModel(
        id: question.id,
        roomId: question.roomId,
        questionId: question.questionId,
        orderIndex: question.orderIndex,
      );
}
