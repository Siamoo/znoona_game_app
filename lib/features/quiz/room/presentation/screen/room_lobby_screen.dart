import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/quiz/room/domain/entities/room.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/refactors/room_lobby_body.dart';

class RoomLobbyScreen extends StatelessWidget {
  const RoomLobbyScreen({required this.room, super.key});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return RoomLobbyBody(
      room: room,
    );
  }
}
