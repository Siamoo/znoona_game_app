import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/entities/category.dart';

abstract class CategoriesRepository {
  Future<Either<String, List<Category>>> getMainCategories();
  Future<Either<String, List<Category>>> getSubCategories(String parentId);
}