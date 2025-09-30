import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/user/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/logout_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.loginUseCase,
    this.signUpUseCase,
    this.loginWithGoogleUseCase,
    this.logoutUseCase,
  ) : super(const AuthState.initial());

  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );
    result.fold(
      (error) {
        emit(AuthState.error(error));
      },
      (profile) => emit(AuthState.authenticated(profile)),
    );
  }

  Future<void> signUp(String email, String password, String fullName) async {
    emit(const AuthState.loading());
    final result = await signUpUseCase(
      SignUpParams(email: email, password: password, fullName: fullName),
    );
    result.fold(
      (error) {
        emit(AuthState.error(error));
      },
      (profile) => emit(AuthState.authenticated(profile)),
    );
  }

  Future<void> loginWithGoogle() async {
    emit(const AuthState.googleloading());
    final result = await loginWithGoogleUseCase();
    result.fold(
      (error) {
        emit(AuthState.error(error));
      },
      (profile) => emit(AuthState.googleauthenticated(profile)),
    );
  }

  Future<void> logout() async {
    await logoutUseCase();
    emit(const AuthState.initial());
  }
}
