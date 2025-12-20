import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/refactors/category_hierarchy_body.dart';

class CategoryHierarchyScreen extends StatelessWidget {
  const CategoryHierarchyScreen({required this.isRoom, super.key});
  final bool isRoom;
  @override
  Widget build(BuildContext context) {
    return CategoryHierarchyBody(
      isRoom: isRoom,
    );
  }
}
