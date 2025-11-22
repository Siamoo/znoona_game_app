import 'package:dartz/dartz.dart';
import 'package:znoona_game_app/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:znoona_game_app/features/user/auth/data/models/profile_model.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remote);
  final AuthRemoteDataSource remote;

  @override
  Future<Either<String, Profile>> signUp({
    required String email,
    required String password,
    required String fullName,
    String? username, // NEW
  }) async {
    try {
      final result = await remote.signUp(
        email: email,
        password: password,
        fullName: fullName,
        username: username,
      );
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Profile>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remote.login(
        email: email,
        password: password,
      );
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Profile>> loginWithGoogle() async {
    try {
      final result = await remote.loginWithGoogle();
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> logout() {
    return remote.logout();
  }

  @override
  Future<Either<String, Profile>> getCurrentUser() async {
    try {
      final result = await remote.getCurrentUser();
      if (result == null) return const Left('User not found');
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Profile>> updateProfile({
    required String id,
    String? username,
    String? fullName,
    String? avatarUrl,
    String? level,
  }) async {
    try {
      final result = await remote.updateProfile(
        id: id,
        username: username,
        fullName: fullName,
        avatarUrl: avatarUrl,
        level: level,
      );
      return Right(result.toEntity());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updatePlayerStats({
    required String userId,
    required bool won,
    required int score,
    String? categoryId,
  }) async {
    try {
      await remote.updatePlayerStats(
        userId: userId,
        won: won,
        score: score,
        categoryId: categoryId,
      );
      return const Right(null);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Profile>>> getLeaderboard({
    required String type,
    int limit = 50,
  }) async {
    try {
      final result = await remote.getLeaderboard(
        type: type,
        limit: limit,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}