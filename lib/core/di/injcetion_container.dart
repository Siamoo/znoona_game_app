import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// App Core
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';

// Auth Feature
import 'package:znoona_game_app/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:znoona_game_app/features/user/auth/data/repositories/auth_repository_impl.dart';
import 'package:znoona_game_app/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/sign_up_usecase.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  /// Core
  sl.registerFactory(AppCubit.new);

  /// External
  sl.registerLazySingleton(() => Supabase.instance.client);

  /// Datasources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );

  /// Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  /// Usecases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  /// Cubits
  sl.registerFactory(() => AuthCubit(sl(), sl()));
}
