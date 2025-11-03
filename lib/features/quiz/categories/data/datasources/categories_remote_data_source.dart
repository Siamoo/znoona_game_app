import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/features/quiz/categories/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<CategoryModel>> getMainCategories();
  Future<List<CategoryModel>> getSubCategories(String parentId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  CategoriesRemoteDataSourceImpl(this.client);
  final SupabaseClient client;

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

  Future<List<CategoryModel>> getMainCategories() async {
    final response = await client
        .from('categories')
        .select()
        .filter('parent_id', 'is', null)
        .order('created_at', ascending: true);

    final data = response as List<dynamic>;
    return data
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    final response = await client
        .from('categories')
        .select()
        .eq('parent_id', parentId)
        .order('created_at', ascending: true);

    final data = response as List<dynamic>;
    return data
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
