import 'dart:math';
import 'package:znoona_game_app/features/quiz/single/domain/entities/question.dart';

class QuestionModel {
  const QuestionModel({
    required this.id,
    required this.categoryId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // Load options
    final opts = (json['options'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [];

    // randomize
    opts.shuffle(Random());

    return QuestionModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      question: json['question'] as String,
      options: opts,
      correctAnswer: json['correct_answer'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  final String id;
  final String categoryId;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

extension QuestionModelX on QuestionModel {
  Question toEntity() {
    return Question(
      id: id,
      categoryId: categoryId,
      question: question,
      options: options,
      correctAnswer: correctAnswer,
      createdAt: createdAt,
    );
  }
}
