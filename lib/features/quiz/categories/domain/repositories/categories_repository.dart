import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';

abstract class CategoriesRepository {
  Future<Either<String, List<Category>>> getCategories();
}
