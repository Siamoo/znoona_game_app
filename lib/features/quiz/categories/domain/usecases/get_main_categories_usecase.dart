import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/repositories/categories_repository.dart';

class GetMainCategoriesUseCase {
  GetMainCategoriesUseCase(this.repository);
  final CategoriesRepository repository;

  Future<Either<String, List<Category>>> call() {
    return repository.getMainCategories();
  }
}