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
import 'package:medaan_almaarifa/core/common/screens/simple_error_screen.dart';
import 'package:medaan_almaarifa/core/di/injection_container.dart';
import 'package:medaan_almaarifa/core/errors/error_handler.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';
import 'package:medaan_almaarifa/znoona_game_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Global error handler
final Logger _logger = Logger();
bool _isInitialized = false; // Track if we've completed initialization

void main() async {
  // Prevent multiple initialization attempts
  if (_isInitialized) return;
  
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize error handling for production
  _initializeErrorHandling();

  try {
    // Check network connectivity first with timeout
    final hasNetwork = await _checkInitialConnectivityWithTimeout();
    
    if (!hasNetwork) {
      _showAppropriateNoNetworkScreen();
      return;
    }

    // Load environment variables with error handling
    await _initializeEnvVariables();
    
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

    // Mark as initialized
    _isInitialized = true;
    
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

    if (!EnvVariables.instance.debugMode) {
      ErrorHandler.logError(
        details.exception,
        details.stack ?? StackTrace.current,
        message: 'Flutter Error',
      );
    } else {
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
}

Future<bool> _checkInitialConnectivityWithTimeout() async {
  try {
    return await Connectivity()
        .checkConnectivity()
        .timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            _logger.w('Connectivity check timed out');
            return []; // Return empty list on timeout
          },
        )
        .then((results) => results.any(
              (r) =>
                  r == ConnectivityResult.mobile ||
                  r == ConnectivityResult.wifi ||
                  r == ConnectivityResult.ethernet,
            ));
  } catch (e) {
    _logger.e('Failed to check connectivity', error: e);
    return false;
  }
}

Future<void> _initializeEnvVariables() async {
  try {
    await EnvVariables.instance.init(
      envType: EnvVariables.instance.debugMode
          ? EnvTypeEnum.dev
          : EnvTypeEnum.prod,
    );
    _logger.i('✅ Environment variables initialized');
  } catch (e) {
    _logger.e('Failed to initialize environment variables', error: e);
    rethrow;
  }
}

void _showAppropriateNoNetworkScreen() {
  try {
    // Try to show NoNetworkScreen
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoNetworkScreen(
          onRetry: () {
            _isInitialized = false;
            main();
          },
        ),
      ),
    );
  } catch (e) {
    _logger.e('Failed to show NoNetworkScreen, using SimpleErrorScreen', error: e);
    // Use SimpleErrorScreen as fallback
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SimpleErrorScreen(
          isNetworkError: true,
          errorMessage: 'No internet connection. Please check your network and try again.',
          onRetry: () {
            _isInitialized = false;
            main();
          },
        ),
      ),
    );
  }
}

Future<void> _initializeSupabaseWithRetry({int maxRetries = 3}) async {
  int attempts = 0;
  Duration delay = const Duration(seconds: 1);

  while (attempts < maxRetries) {
    try {
      // Ensure we have valid URLs
      final supabaseUrl = EnvVariables.instance.supabaseUrl;
      final supabaseAnonKey = EnvVariables.instance.supabaseAnonKey;
      
      if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
        throw Exception('Supabase URL or Anon Key is empty');
      }

      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
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
      delay *= 2;
    }
  }
}

Future<void> _initializeAudioService() async {
  try {
    // Check if service locator has AudioService before accessing
    if (sl.isRegistered<AudioService>()) {
      final audioService = sl<AudioService>();
      await audioService.initialize();
      if (EnvVariables.instance.debugMode) {
        _logger.i('✅ AudioService initialized');
      }
    } else {
      _logger.w('⚠️ AudioService not registered in service locator');
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

  final errorString = e.toString().toLowerCase();
  
  if (errorString.contains('network') ||
      errorString.contains('connection') ||
      errorString.contains('socket')) {
    isNetworkError = true;
    errorMessage = ErrorHandler.getNetworkErrorMessage(e);
  } else if (e is TimeoutException) {
    errorMessage = 'Connection timeout. Please try again.';
  } else if (errorString.contains('supabase')) {
    errorMessage = 'Failed to connect to server. Please try again.';
  } else if (errorString.contains('lateinitializationerror')) {
    errorMessage = 'App initialization error. Please restart the app.';
    _logger.e('Late initialization error detected', error: e, stackTrace: stackTrace);
  } else if (errorString.contains('null')) {
    errorMessage = 'Required configuration is missing. Please check your setup.';
  } else {
    // Clean up error message
    String cleanError = e.toString()
        .replaceAll('Exception:', '')
        .replaceAll('Error:', '')
        .trim();
    errorMessage = 'Failed to initialize app: $cleanError';
  }

  // Try to use ErrorScreen first
  try {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorScreen(
          errorMessage: errorMessage,
          onRetry: () {
            _isInitialized = false;
            main();
          },
        ),
      ),
    );
  } catch (errorScreenError) {
    _logger.e('Failed to show ErrorScreen, using SimpleErrorScreen', error: errorScreenError);
    // Use SimpleErrorScreen as ultimate fallback
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SimpleErrorScreen(
          isNetworkError: isNetworkError,
          errorMessage: errorMessage,
          onRetry: () {
            _isInitialized = false;
            main();
          },
        ),
      ),
    );
  }
}