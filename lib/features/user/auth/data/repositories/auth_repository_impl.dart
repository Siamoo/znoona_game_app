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
  }) async {
    try {
      final result = await remote.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return Right(result.toEntity());
    }on Exception catch (e) {
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
    }on Exception catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Profile>> loginWithGoogle() async {
    try {
      final result = await remote.loginWithGoogle();
      return Right(result.toEntity());
    }on Exception catch (e) {
      return Left(e.toString());
    }
  }
  
  @override
  Future<void> logout() {
    return remote.logout();
  }


}
