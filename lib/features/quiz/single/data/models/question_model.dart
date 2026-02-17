import 'dart:math';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';

class QuestionModel {
  const QuestionModel({
    required this.id,
    required this.categoryId,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.image,
    this.goodQuestion,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    // Load options
    final opts =
        (json['options'] as List<dynamic>?)?.map((e) => e as String).toList() ??
        [];

    // randomize
    opts.shuffle(Random());

    return QuestionModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      question: json['question'] as String,
      options: opts,
      correctAnswer: json['correct_answer'] as String,
      image: json['image'] as String?, // This should now work
      goodQuestion: json['good_question'] != null
          ? (json['good_question'] is int
                ? json['good_question'] as int
                : int.tryParse(json['good_question'].toString()) ?? 0)
          : null,
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
  final String? image;
  final int? goodQuestion;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'question': question,
      'options': options,
      'correct_answer': correctAnswer,
      'image': image,
      'good_question': goodQuestion,
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
      image: image,
      goodQuestion: goodQuestion,
      createdAt: createdAt,
    );
  }
}
