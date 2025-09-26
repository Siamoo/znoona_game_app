import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/app/bloc_observer.dart';
import 'package:znoona_game_app/core/app/env.variables.dart';
import 'package:znoona_game_app/core/di/injcetion_container.dart';
import 'package:znoona_game_app/core/service/shared_pref/shared_pref.dart';
import 'package:znoona_game_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
    await EnvVariables.instance.init(envType: EnvTypeEnum.dev);

  // Initialize Supabase
  await Supabase.initialize(
    url: EnvVariables.instance.supabaseUrl,
    anonKey: EnvVariables.instance.supabaseAnonKey,
  );

  await SharedPref().instantiatePreferences();
  await setupInjector();
  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
