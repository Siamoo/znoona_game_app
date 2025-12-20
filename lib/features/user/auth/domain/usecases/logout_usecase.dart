import 'package:medaan_almaarifa/features/user/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this.repository);
  final AuthRepository repository;

  Future<void> call()  {
    return  repository.logout();
  }
}
