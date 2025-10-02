import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    String? icon_url,
    DateTime? created_at,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelX on CategoryModel {
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      createdAt: created_at,
    );
  }
}
