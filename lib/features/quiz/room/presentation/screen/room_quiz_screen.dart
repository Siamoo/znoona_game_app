import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/refactors/room_quiz_body.dart';
import 'package:medaan_almaarifa/features/quiz/single/domain/entities/question.dart';

class RoomQuizScreen extends StatelessWidget {
  const RoomQuizScreen({
    required this.room,
    required this.questions,
    super.key,
  });
  final Room room;
  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return RoomQuizBody(
      room: room,
      questions: questions,
    );
  }
}
