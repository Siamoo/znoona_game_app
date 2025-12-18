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
      all_cups: (json['all_cups'] as num?)?.toInt() ?? 0,
      cups_by_month: (json['cups_by_month'] as num?)?.toInt() ?? 0,
      username: json['username'] as String?,
      email: json['email'] as String?,
      lastMonthReset: json['lastMonthReset'] == null
          ? null
          : DateTime.parse(json['lastMonthReset'] as String),
      games_played: (json['games_played'] as num?)?.toInt() ?? 0,
      games_won: (json['games_won'] as num?)?.toInt() ?? 0,
      total_score: (json['total_score'] as num?)?.toInt() ?? 0,
      average_score: (json['average_score'] as num?)?.toDouble() ?? 0.0,
      win_rate: (json['win_rate'] as num?)?.toDouble() ?? 0.0,
      best_category: json['best_category'] as String?,
      streak_days: (json['streak_days'] as num?)?.toInt() ?? 0,
      last_played: json['last_played'] == null
          ? null
          : DateTime.parse(json['last_played'] as String),
    );

Map<String, dynamic> _$$ProfileModelImplToJson(_$ProfileModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'level': instance.level,
      'avatar_url': instance.avatar_url,
      'created_at': instance.created_at.toIso8601String(),
      'all_cups': instance.all_cups,
      'cups_by_month': instance.cups_by_month,
      'username': instance.username,
      'email': instance.email,
      'lastMonthReset': instance.lastMonthReset?.toIso8601String(),
      'games_played': instance.games_played,
      'games_won': instance.games_won,
      'total_score': instance.total_score,
      'average_score': instance.average_score,
      'win_rate': instance.win_rate,
      'best_category': instance.best_category,
      'streak_days': instance.streak_days,
      'last_played': instance.last_played?.toIso8601String(),
    };
