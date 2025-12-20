import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/entities/category.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/repositories/categories_repository.dart';

class GetSubCategoriesUseCase {
  GetSubCategoriesUseCase(this.repository);
  final CategoriesRepository repository;

  Future<Either<String, List<Category>>> call(String parentId) {
    return repository.getSubCategories(parentId);
  }
}