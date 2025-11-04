import 'package:flutter/material.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/screens/category_hierarchy_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({required this.isRoom, super.key});

  final bool isRoom;

  @override
  Widget build(BuildContext context) {
    return CategoryHierarchyScreen(
      isRoom: isRoom,
    );
  }
}
