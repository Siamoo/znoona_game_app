import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/features/quiz/categories/domain/entities/category.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required String id,
    required String name,
    required String arabic_name,
    required String discription,
    required String image,
    DateTime? created_at,
    String? type,
    String? parentId,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

extension CategoryModelX on CategoryModel {
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      arabicName: arabic_name,
      discription: discription,
      image: image,
      createdAt: created_at,
      type: type,
      parentId: parentId,
    );
  }
}
