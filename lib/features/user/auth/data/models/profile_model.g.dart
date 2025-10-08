// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileModelImpl _$$ProfileModelImplFromJson(Map<String, dynamic> json) =>
    _$ProfileModelImpl(
      id: json['id'] as String,
      full_name: json['full_name'] as String,
      level: json['level'] as String,
      avatar_url: json['avatar_url'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'level': instance.level,
      'avatar_url': instance.avatar_url,
      'created_at': instance.created_at.toIso8601String(),
    };
