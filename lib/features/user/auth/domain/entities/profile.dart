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
  }) = _Profile;
}
