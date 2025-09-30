part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.googleloading() = _GoogleLoading;
  const factory AuthState.authenticated(Profile profile) = _Authenticated;
  const factory AuthState.googleauthenticated(Profile profile) = _GoogleAuthenticated;

  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}
