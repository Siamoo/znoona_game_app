import 'package:dartz/dartz.dart';
import '../entities/profile.dart';

abstract class AuthRepository {
  Future<Either<String, Profile>> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<Either<String, Profile>> login({
    required String email,
    required String password,
  });
}
