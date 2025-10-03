import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/quiz/categories/data/datasources/categories_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/categories/data/models/category_model.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/repositories/categories_repository.dart';


class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesRepositoryImpl(this.remote);
  final CategoriesRemoteDataSource remote;

  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      final result = await remote.getCategories();
      return Right(result.map((m) => m.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
