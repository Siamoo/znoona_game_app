import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String categoryId,
    required String question,
    required List<String> options,
    required String correctAnswer,
    String? image, 
    int? goodQuestion,
    DateTime? createdAt,
  }) = _Question;
}