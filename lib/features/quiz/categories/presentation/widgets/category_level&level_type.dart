
class CategoryLevel {
  CategoryLevel({
    required this.type,
    required this.title,
    this.parentId,
  });
  final LevelType type;
  final String title;
  final String? parentId;
}

enum LevelType {
  main,
  faculty,
  year,
  subject,
  unit,
  lesson,
}
