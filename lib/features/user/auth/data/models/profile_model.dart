import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    required String full_name,
    String? avatar_url,
    required DateTime created_at,
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
      createdAt: created_at,
    );
  }
}
