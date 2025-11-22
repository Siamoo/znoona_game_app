import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String full_name,
    required String level,
    String? avatar_url,
    required DateTime created_at,
    // NEW FIELDS
    @Default(0) int all_cups,
    @Default(0) int cups_by_month,
    String? username,
    String? email,
    @JsonKey(name: 'last_month_reset') DateTime? lastMonthReset,
    @Default(0) int games_played,
    @Default(0) int games_won,
    @Default(0) int total_score,
    @Default(0.0) double average_score,
    @Default(0.0) double win_rate,
    String? best_category,
    @Default(0) int streak_days,
    DateTime? last_played,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

extension ProfileModelX on ProfileModel {
  Profile toEntity() {
    return Profile(
      id: id,
      fullName: full_name,
      avatarUrl: avatar_url,
      level: level,
      createdAt: created_at,
      // NEW FIELDS
      allCups: all_cups,
      cupsByMonth: cups_by_month,
      username: username,
      email: email,
      lastMonthReset: lastMonthReset,
      gamesPlayed: games_played,
      gamesWon: games_won,
      totalScore: total_score,
      averageScore: average_score,
      winRate: win_rate,
      bestCategory: best_category,
      streakDays: streak_days,
      lastPlayed: last_played,
    );
  }
}
