import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// App Core
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_main_categories_usecase.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/usecases/get_sub_categories_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/data/datasources/room_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/room/data/repositories/room_repository_impl.dart';
import 'package:znoona_game_app/features/quiz/room/domain/repositories/room_repository.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/create_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_results_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_players_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_room_questions_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/get_rooms_stream_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/join_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/leave_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/mark_player_finished_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/reset_answers_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/start_game_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/submit_answer_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/watch_player_answers_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/domain/usecases/watch_room_usecase.dart';
import 'package:znoona_game_app/features/quiz/room/presentation/cubit/room_cubit.dart';

// ---------------- QUIZ (Single Player) ----------------
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
import 'package:znoona_game_app/features/quiz/categories/data/datasources/categories_remote_data_source.dart';
import 'package:znoona_game_app/features/quiz/categories/data/repositories/categories_repository_impl.dart';
import 'package:znoona_game_app/features/quiz/categories/domain/repositories/categories_repository.dart';
import 'package:znoona_game_app/features/quiz/categories/presentation/cubit/categories_cubit.dart';

// ---------------- MULTIPLAYER ROOM ----------------

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
    ..registerLazySingleton(() => GetMainCategoriesUseCase(sl()))
    ..registerLazySingleton(() => GetSubCategoriesUseCase(sl()))
    
    /// Cubits
    ..registerFactory(
      () => CategoriesCubit(
        getMainCategoriesUseCase: sl(),
        getSubCategoriesUseCase: sl(),
      ),
    )
    // ---------------- QUESTIONS (Single Player) ----------------
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
    ..registerFactory(() => QuestionsCubit(sl()))
    // ---------------- MULTIPLAYER ROOM ----------------
    /// Datasources
    ..registerLazySingleton<RoomRemoteDataSource>(
      () => RoomRemoteDataSource(sl()),
    )
    /// Repository
    ..registerLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(sl()),
    )
    /// Usecases
    ..registerLazySingleton(() => CreateRoomUseCase(sl()))
    ..registerLazySingleton(() => JoinRoomUseCase(sl()))
    ..registerLazySingleton(() => LeaveRoomUseCase(sl()))
    ..registerLazySingleton(() => GetRoomsStreamUseCase(sl()))
    ..registerLazySingleton(() => GetRoomPlayersStreamUseCase(sl()))
    ..registerLazySingleton(() => GetRoomQuestionsUseCase(sl()))
    ..registerLazySingleton(() => StartGameUseCase(sl()))
    ..registerLazySingleton(() => WatchRoomUseCase(sl()))
    ..registerLazySingleton(() => GetQuestionsUseCase(sl()))
    ..registerLazySingleton(() => SubmitAnswerUseCase(sl()))
    ..registerLazySingleton(() => ResetAnswersUseCase(sl()))
    ..registerLazySingleton(() => WatchPlayerAnswersUseCase(sl()))
    ..registerLazySingleton(() => MarkPlayerFinishedUseCase(sl()))
    ..registerLazySingleton(() => GetRoomPlayersStreamResultsUseCase(sl()))
    ..registerLazySingleton(() => GetRoomPlayersUseCase(sl()))
    /// Cubits
    ..registerFactory(
      () => RoomCubit(
        createRoomUseCase: sl(),
        joinRoomUseCase: sl(),
        leaveRoomUseCase: sl(),
        getRoomsStreamUseCase: sl(),
        getRoomPlayersStreamUseCase: sl(),
        getRoomQuestionsUseCase: sl(),
        startGameUseCase: sl(),
        watchRoomUseCase: sl(),
        getQuestionsUseCase: sl(),
        submitAnswerUseCase: sl(),
        resetAnswersUseCase: sl(),
        watchPlayerAnswersUseCase: sl(),
        markPlayerFinishedUseCase: sl(),
        getRoomPlayersStreamResultsUseCase: sl(),
        getRoomPlayersUseCase: sl(),
      ),
    );
}
