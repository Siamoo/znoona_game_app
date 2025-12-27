import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
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

  // Initialize SharedPreferences
  await SharedPref().instantiatePreferences();
  
  // Setup dependency injection (includes AudioService initialization)
  await setupInjector();
    // **IMPORTANT: Initialize AudioService AFTER DI setup**
  try {
    await sl<AudioService>().initialize();
    print('✅ AudioService initialized in main()');
  } catch (e) {
    print('⚠️ AudioService initialization failed: $e');
    // Continue without audio - don't crash the app
  }
  // Setup Bloc observer
  Bloc.observer = AppBlocObserver();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const ZnoonaGameApp());
  });
}