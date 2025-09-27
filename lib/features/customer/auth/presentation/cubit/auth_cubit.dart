import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:znoona_game_app/features/customer/auth/domain/entities/profile.dart';
import 'package:znoona_game_app/features/customer/auth/domain/usecases/login_usecase.dart';
import 'package:znoona_game_app/features/customer/auth/domain/usecases/sign_up_usecase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginUseCase, this.signUpUseCase)
    : super(const AuthState.initial());

  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;

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
}
