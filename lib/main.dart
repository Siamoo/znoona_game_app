import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/bloc_observer.dart';
import 'package:medaan_almaarifa/core/app/env.variables.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';
import 'package:medaan_almaarifa/znoona_game_app.dart';
import 'package:logger/logger.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize error handling for production
  _initializeErrorHandling();

  try {
    // Load environment variables
    await EnvVariables.instance.init(envType: EnvTypeEnum.dev);
    
    // Initialize Supabase with timeout
    await Supabase.initialize(
      url: EnvVariables.instance.supabaseUrl,
      anonKey: EnvVariables.instance.supabaseAnonKey,
    ).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception('Supabase initialization timeout'),
    );

    // ✅ FIXED: Use create() instead of instantiatePreferences()
    // Initialize SharedPreferences
    final sharedPref = await SharedPref.create();
    
    // Setup dependency injection (pass the initialized sharedPref)
    await setupInjector(sharedPref: sharedPref);
    
    // Initialize AudioService after DI setup
    await _initializeAudioService();
    
    // Setup Bloc observer
    Bloc.observer = AppBlocObserver();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // Run the app
    runApp(const ZnoonaGameApp());
    
  } catch (e, stackTrace) {
    // Handle initialization errors gracefully
    _handleInitializationError(e, stackTrace);
  }
}

void _initializeErrorHandling() {
  // Capture Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // Log to crash reporting service in production
    if (!EnvVariables.instance.debugMode) {
      // FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
  };
  
  // Capture async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    // Log to crash reporting service in production
    if (!EnvVariables.instance.debugMode) {
      // FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
}

Future<void> _initializeAudioService() async {
  try {
    final audioService = sl<AudioService>();
    await audioService.initialize();
    
    // Log success in debug mode
    if (EnvVariables.instance.debugMode) {
      Logger().i('AudioService initialized successfully');
    }
  } catch (e, stackTrace) {
    // Log error but don't crash
    Logger().e('Failed to initialize AudioService', error: e, stackTrace: stackTrace);
  }
}

void _handleInitializationError(Object e, StackTrace stackTrace) {
  Logger().e('App initialization failed', error: e, stackTrace: stackTrace);
  
  // Show error screen
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade50,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red.shade700,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to initialize app',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Please restart the app or contact support if the issue persists.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: const Text('Close App'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}