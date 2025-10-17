import 'package:flutter/material.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/refactors/room_creation_body.dart';

class RoomCreationScreen extends StatelessWidget {
  const RoomCreationScreen({
    required this.categoryId,
    required this.categoryName,
    required this.imageUrl, super.key,
  });

  final String categoryId;
  final String categoryName;
    final String imageUrl;


  @override
  Widget build(BuildContext context) {
    return RoomCreationBody(
      categoryId: categoryId,
      categoryName: categoryName, imageUrl: imageUrl,
    );
  }
}
