import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/refactors/room_load_questions_body.dart';

class RoomLoadQuestionsScreen extends StatelessWidget {
  const RoomLoadQuestionsScreen({required this.room, super.key});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return RoomLoadQuestionsBody(
      room: room,
    );
  }
}
