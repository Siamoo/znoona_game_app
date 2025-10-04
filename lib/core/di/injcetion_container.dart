import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// App Core
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/features/quiz/single/data/datasources/questions_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/single/data/repositories/questions_repository_impl.dart';
import 'package:znoona_game_app/features/quiz/single/domain/repositories/questions_repository.dart';
import 'package:znoona_game_app/features/quiz/single/domain/usecases/get_questions_by_category_usecase.dart';
import 'package:znoona_game_app/features/quiz/single/presentation/cubit/questions_cubit.dart';

// ---------------- AUTH ----------------
import 'package:znoona_game_app/features/user/auth/data/datasources/auth_remote_data_source.dart';
import 'package:znoona_game_app/features/user/auth/data/repositories/auth_repository_impl.dart';
import 'package:znoona_game_app/features/user/auth/domain/repositories/auth_repository.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/login_with_google_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/logout_usecase.dart';
import 'package:znoona_game_app/features/user/auth/domain/usecases/sign_up_usecase.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';

// ---------------- CATEGORIES ----------------
// ignore: directives_ordering
import 'package:znoona_game_app/features/quiz/categories/data/datasources/categories_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/categories/data/repositories/categories_repository_impl.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/repositories/categories_repository.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_categories_usecase.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';

// ---------------- QUESTIONS ----------------


final GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  /// Core
  sl
    ..registerFactory(AppCubit.new)

    /// External
    ..registerLazySingleton(() => Supabase.instance.client)

    // ---------------- AUTH ----------------
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
    ..registerFactory(() => AuthCubit(sl(), sl(), sl(), sl(), sl()))

    // ---------------- CATEGORIES ----------------
    /// Datasources
    ..registerLazySingleton<CategoriesRemoteDataSource>(
      () => CategoriesRemoteDataSourceImpl(sl()),
    )
    /// Repository
    ..registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepositoryImpl(sl()),
    )
    /// Usecases
    ..registerLazySingleton(() => GetCategoriesUseCase(sl()))
    /// Cubits
    ..registerFactory(() => CategoriesCubit(sl()))

    // ---------------- QUESTIONS ----------------
    /// Datasources
    ..registerLazySingleton<QuestionsRemoteDataSource>(
      () => QuestionsRemoteDataSourceImpl(sl()),
    )
    /// Repository
    ..registerLazySingleton<QuestionsRepository>(
      () => QuestionsRepositoryImpl(sl()),
    )
    /// Usecases
    ..registerLazySingleton(() => GetQuestionsByCategoryUseCase(sl()))
    /// Cubits
    ..registerFactory(() => QuestionsCubit(sl()));
}
