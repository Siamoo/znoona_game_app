import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/categories/data/datasources/categories_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/categories/data/models/category_model.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/repositories/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this.remoteDataSource);
  final CategoriesRemoteDataSource remoteDataSource;


  @override
  Future<Either<String, List<Category>>> getMainCategories() async {
    try {
      final result = await remoteDataSource.getMainCategories();
      return Right(result.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Category>>> getSubCategories(
    String parentId,
  ) async {
    try {
      final result = await remoteDataSource.getSubCategories(parentId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
