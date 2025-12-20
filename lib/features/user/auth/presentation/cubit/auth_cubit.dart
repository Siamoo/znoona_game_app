// auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/entities/profile.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/usecases/login_usecase.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/usecases/logout_usecase.dart';
import 'package:medaan_almaarifa/features/user/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

enum AuthMethod { email, google }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.authRepository, 
  }) : super(const AuthState.initial());

  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AuthRepository authRepository; 

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (error) => emit(AuthState.error(error)),
      (profile) => emit(AuthState.authenticated(
        profile: profile,
        authMethod: AuthMethod.email,
      )),
    );
  }

  Future<void> signUp(String email, String password, String fullName) async {
    emit(const AuthState.loading());
    final result = await signUpUseCase(
      SignUpParams(email: email, password: password, fullName: fullName),
    );
    result.fold(
      (error) => emit(AuthState.error(error)),
      (profile) => emit(AuthState.authenticated(
        profile: profile,
        authMethod: AuthMethod.email,
      )),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthState.loading());
    final result = await loginWithGoogleUseCase();
    result.fold(
      (error) => emit(AuthState.error(error)),
      (profile) => emit(AuthState.authenticated(
        profile: profile,
        authMethod: AuthMethod.google,
      )),
    );
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(const AuthState.unauthenticated());
  }

  Future<void> getCurrentUser() async {
    emit(const AuthState.loading());
    final result = await getCurrentUserUseCase();
    result.fold(
      (error) => emit(AuthState.error(error)),
      (profile) => emit(AuthState.authenticated(
        profile: profile,
        authMethod: AuthMethod.email, 
      )),
    );
  }

  Future<void> updateProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
    String? level,
  }) async {
    final currentState = state;
    if (currentState is! _Authenticated) {
      emit(const AuthState.error('User not authenticated'));
      return;
    }

    final profile = currentState.profile;
    final authMethod = currentState.authMethod;

    final result = await authRepository.updateProfile(
      id: profile.id,
      username: username,
      fullName: fullName,
      avatarUrl: avatarUrl,
      level: level,
    );

    result.fold(
      (error) => emit(AuthState.error(error.toString())), 
      (updatedProfile) => emit(AuthState.authenticated(
        profile: updatedProfile,
        authMethod: authMethod,
      )),
    );
  }

  Future<void> updatePlayerStats({
    required bool won,
    required int score,
    String? categoryId,
  }) async {
    final currentState = state;
    if (currentState is! _Authenticated) {
      return; 
    }

    final profile = currentState.profile;

    final result = await authRepository.updatePlayerStats(
      userId: profile.id,
      won: won,
      score: score,
      categoryId: categoryId,
    );

    result.fold(
      (error) => print('Failed to update stats: $error'), // Log error
      (_) async {
        await getCurrentUser();
      },
    );
  }

  Future<void> getLeaderboard({
    required String type,
    int limit = 50,
  }) async {
    // You might want to emit a different state for leaderboard
    // or create a separate cubit for leaderboard data
  }
}