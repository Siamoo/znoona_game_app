// auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';

abstract class AuthRepository {
  Future<Either<String, Profile>> signUp({
    required String email,
    required String password,
    required String fullName,
    String? username,
  });

  Future<Either<String, Profile>> login({
    required String email,
    required String password,
  });

  Future<Either<String, Profile>> loginWithGoogle();

  Future<void> logout();

  Future<Either<String, Profile>> getCurrentUser();

  Future<Either<String, Profile>> updateProfile({
    required String id,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? level,
  });

  Future<Either<String, void>> updatePlayerStats({
    required String userId,
    required bool won,
    required int score,
    String? categoryId,
  });

  Future<Either<String, List<Profile>>> getLeaderboard({
    required String type,
    int limit = 50,
  });
}