import 'package:flutter/widgets.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/refactors/room_results_body.dart';

class RoomResultsScreen extends StatelessWidget {
  const RoomResultsScreen({required this.roomId, super.key});
  final String roomId;
  @override
  Widget build(BuildContext context) {
    return RoomResultsBody(
      roomId: roomId,
    );
  }
}
