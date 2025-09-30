import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// App Core
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';

// Auth Feature
import 'package:znoona_game_app/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:znoona_game_app/features/user/auth/data/repositories/auth_repository_impl.dart';
import 'package:znoona_game_app/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/logout_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/sign_up_usecase.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  /// Core
  sl
    ..registerFactory(AppCubit.new)
    /// External
    ..registerLazySingleton(() => Supabase.instance.client)
    /// Datasources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()),
    )
    /// Repository
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    /// Usecases
    ..registerLazySingleton(() => LoginUseCase(sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => LogoutUseCase(sl()))
    ..registerLazySingleton(() => LoginWithGoogleUseCase(sl()))
    ..registerLazySingleton(() => GetCurrentUserUseCase(sl()))
    /// Cubits
    ..registerFactory(() => AuthCubit(sl(), sl(), sl(), sl(), sl()));
}
