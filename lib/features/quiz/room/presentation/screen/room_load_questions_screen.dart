import 'package:flutter/material.dart';
import 'package:znoona_game_app/features/quiz/room/domain/entities/room.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_load_questions_body.dart';

class GamePlayingScreen extends StatelessWidget {
  const GamePlayingScreen({required this.room, super.key});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return  GamePlayingBody(room: room,);
  }
}