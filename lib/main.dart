import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/bloc_observer.dart';
import 'package:medaan_almaarifa/core/app/env.variables.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';
import 'package:medaan_almaarifa/znoona_game_app.dart';
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
    runApp(const ZnoonaGameApp());
  });
}
