import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_question.freezed.dart';
part 'room_question.g.dart';

@freezed
class RoomQuestion with _$RoomQuestion {
  const factory RoomQuestion({
    required String id,
    required String roomId,
    required String questionId,
    required int orderIndex,
  }) = _RoomQuestion;

  factory RoomQuestion.fromJson(Map<String, dynamic> json) =>
      _$RoomQuestionFromJson(json);
}
