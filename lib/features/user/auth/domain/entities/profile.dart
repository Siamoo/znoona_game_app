import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String fullName,
    required String level,
    required DateTime createdAt,
    String? avatarUrl,
    @Default(0) int allCups,
    @Default(0) int cupsByMonth,
    String? username,
    String? email,
    DateTime? lastMonthReset,
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int totalScore,
    @Default(0.0) double averageScore,
    @Default(0.0) double winRate,
    String? bestCategory,
    @Default(0) int streakDays,
    DateTime? lastPlayed,
  }) = _Profile;
}