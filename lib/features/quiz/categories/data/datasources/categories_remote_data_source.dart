// features/quiz/categories/data/datasources/categories_remote_data_source.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/categories/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  CategoriesRemoteDataSourceImpl(this.client);
  final SupabaseClient client;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client
        .from('categories')
        .select()
        .order('created_at', ascending: true);

    final data = response as List<dynamic>;
    return data
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
