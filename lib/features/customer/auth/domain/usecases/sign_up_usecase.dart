import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/customer/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/customer/auth/domain/repositories/auth_repository.dart';

part 'sign_up_usecase.freezed.dart';

class SignUpUseCase {
  SignUpUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<String, Profile>> call(SignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      fullName: params.fullName,
    );
  }
}

@freezed
class SignUpParams with _$SignUpParams {
  const factory SignUpParams({
    required String email,
    required String password,
    required String fullName,
  }) = _SignUpParams;
}
