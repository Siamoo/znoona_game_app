// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      arabic_name: json['arabic_name'] as String,
      discription: json['discription'] as String,
      image: json['image'] as String,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      type: json['type'] as String?,
      parentId: json['parentId'] as String?,
      total_questions_count:
          (json['total_questions_count'] as num?)?.toInt() ?? 0,
      show: json['show'] as bool? ?? true,
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arabic_name': instance.arabic_name,
      'discription': instance.discription,
      'image': instance.image,
      'created_at': instance.created_at?.toIso8601String(),
      'type': instance.type,
      'parentId': instance.parentId,
      'total_questions_count': instance.total_questions_count,
      'show': instance.show,
    };
