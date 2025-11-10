import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String  arabicName,
    required String discription,
    required String image,
    DateTime? createdAt,
    String? type,        
    String? parentId,    
  }) = _Category;
}