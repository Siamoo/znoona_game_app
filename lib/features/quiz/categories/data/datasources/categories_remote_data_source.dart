import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/features/quiz/categories/data/models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getMainCategories();
  Future<List<CategoryModel>> getSubCategories(String parentId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  CategoriesRemoteDataSourceImpl(this.client);
  final SupabaseClient client;

  @override
  Future<List<CategoryModel>> getMainCategories() async {
    final response = await client
        .from('categories')
        .select()
        .filter('parent_id', 'is', null)
        .eq('show', true)  // Only show categories with show = true
        .order('sort_by', ascending: true);

    final data = response as List<dynamic>;
    return data
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    final response = await client
        .from('categories')
        .select()
        .eq('parent_id', parentId)
        .eq('show', true)  // Only show categories with show = true
        .order('sort_by', ascending: true);

    final data = response as List<dynamic>;
    return data
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}