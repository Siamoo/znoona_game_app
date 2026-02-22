import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:medaan_almaarifa/core/app/bloc_observer.dart';
import 'package:medaan_almaarifa/core/app/env.variables.dart';
import 'package:medaan_almaarifa/core/common/screens/error_screen.dart';
import 'package:medaan_almaarifa/core/common/screens/no_network_screen.dart';
import 'package:medaan_almaarifa/core/di/injection_container.dart';
import 'package:medaan_almaarifa/core/errors/error_handler.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';
import 'package:medaan_almaarifa/znoona_game_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Global error handler
final Logger _logger = Logger();

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize error handling for production
  _initializeErrorHandling();

  // Check network connectivity first
  final hasNetwork = await _checkInitialConnectivity();

  if (!hasNetwork) {
    _showNoNetworkScreen();
    return;
  }

  try {
    // Load environment variables
    await EnvVariables.instance.init(
      envType: EnvVariables.instance.debugMode
          ? EnvTypeEnum.dev
          : EnvTypeEnum.prod,
    );

    // Initialize Supabase with retry mechanism
    await _initializeSupabaseWithRetry();

    // Initialize SharedPreferences
    final sharedPref = await SharedPref.create();

    // Setup dependency injection
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
    // Handle initialization errors gracefully using ErrorScreen
    _handleInitializationError(e, stackTrace);
  }
}

void _initializeErrorHandling() {
  // Capture Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);

    if (!EnvVariables.instance.debugMode) {
      // Log to crash reporting service
      ErrorHandler.logError(
        details.exception,
        details.stack ?? StackTrace.current,
        message: 'Flutter Error',
      );
    } else {
      // In debug, print with more details
      _logger.e(
        'Flutter Error',
        error: details.exception,
        stackTrace: details.stack ?? StackTrace.current,
      );
    }
  };

  // Capture async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!EnvVariables.instance.debugMode) {
      ErrorHandler.logError(error, stack, message: 'Platform Error');
    } else {
      _logger.e('Platform Error', error: error, stackTrace: stack);
    }
    return true;
  };

  // Handle uncaught exceptions
  runZonedGuarded(
    () {
      // Your app runs here
    },
    (error, stack) {
      if (!EnvVariables.instance.debugMode) {
        ErrorHandler.logError(error, stack, message: 'Uncaught Error');
      } else {
        _logger.e('Uncaught Error', error: error, stackTrace: stack);
      }
    },
  );
}

Future<bool> _checkInitialConnectivity() async {
  try {
    final results = await Connectivity().checkConnectivity();
    return results.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet,
    );
  } catch (e) {
    _logger.e('Failed to check connectivity', error: e);
    return false; // Assume no connection on error
  }
}

void _showNoNetworkScreen() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoNetworkScreen(
        onRetry: main,
      ),
    ),
  );
}

Future<void> _initializeSupabaseWithRetry({int maxRetries = 3}) async {
  int attempts = 0;
  Duration delay = const Duration(seconds: 1);

  while (attempts < maxRetries) {
    try {
      await Supabase.initialize(
        url: EnvVariables.instance.supabaseUrl,
        anonKey: EnvVariables.instance.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          autoRefreshToken: true,
        ),
        realtimeClientOptions: const RealtimeClientOptions(
          eventsPerSecond: 10,
        ),
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () =>
            throw TimeoutException('Supabase initialization timeout'),
      );

      _logger.i('✅ Supabase initialized successfully');
      return;
    } catch (e) {
      attempts++;
      _logger.w('⚠️ Supabase initialization attempt $attempts failed: $e');

      if (attempts == maxRetries) {
        rethrow;
      }

      await Future<dynamic>.delayed(delay);
      delay *= 2; // Exponential backoff
    }
  }
}

Future<void> _initializeAudioService() async {
  try {
    final audioService = sl<AudioService>();
    await audioService.initialize();

    if (EnvVariables.instance.debugMode) {
      _logger.i('✅ AudioService initialized');
    }
  } catch (e, stackTrace) {
    ErrorHandler.logError(
      e,
      stackTrace,
      message: 'Failed to initialize AudioService',
    );
    // Continue app without audio if needed
  }
}

void _handleInitializationError(Object e, StackTrace stackTrace) {
  ErrorHandler.logError(e, stackTrace, message: 'App initialization failed');

  // Determine error type for better messaging
  String errorMessage = 'Unknown error occurred';
  bool isNetworkError = false;

  if (e.toString().toLowerCase().contains('network') ||
      e.toString().toLowerCase().contains('connection')) {
    isNetworkError = true;
    errorMessage = ErrorHandler.getNetworkErrorMessage(e);
  } else if (e is TimeoutException) {
    errorMessage = 'Connection timeout. Please try again.';
  } else if (e.toString().contains('supabase')) {
    errorMessage = 'Failed to connect to server. Please try again.';
  } else {
    errorMessage = 'Failed to initialize app: ${e.toString()}';
  }

  // Show error screen using the ErrorScreen widget
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ErrorScreen(
        errorMessage: errorMessage,
        onRetry: main,
      ),
    ),
  );
}
