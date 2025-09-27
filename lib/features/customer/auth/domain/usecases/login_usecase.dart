import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/customer/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/customer/auth/domain/repositories/auth_repository.dart';

part 'login_usecase.freezed.dart';

class LoginUseCase {
  LoginUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<String, Profile>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

@freezed
class LoginParams with _$LoginParams {
  const factory LoginParams({
    required String email,
    required String password,
  }) = _LoginParams;
}
