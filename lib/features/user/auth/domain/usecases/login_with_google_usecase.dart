import 'package:dartz/dartz.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  LoginWithGoogleUseCase(this.repository);
  final AuthRepository repository;

  Future<Either<String, Profile>> call()  {
    return repository.loginWithGoogle();
  }
}
