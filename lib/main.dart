import 'dart:async';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:medaan_almaarifa/core/app/bloc_observer.dart';
import 'package:medaan_almaarifa/core/app/env.variables.dart';
import 'package:medaan_almaarifa/core/common/screens/no_network_screen.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
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
    // Handle initialization errors gracefully
    _handleInitializationError(e, stackTrace);
  }
}

void _initializeErrorHandling() {
  // Capture Flutter errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    
    if (!EnvVariables.instance.debugMode) {
      // Log to crash reporting service - FIXED: handle nullable stack trace
      _logErrorToService(
        details.exception, 
        details.stack ?? StackTrace.current
      );
      
      // You can add Firebase Crashlytics here
      // FirebaseCrashlytics.instance.recordFlutterError(details);
    } else {
      // In debug, print with more details
      _logger.e('Flutter Error', 
          error: details.exception, 
          stackTrace: details.stack ?? StackTrace.current);
    }
  };
  
  // Capture async errors
  PlatformDispatcher.instance.onError = (error, stack) {
    if (!EnvVariables.instance.debugMode) {
      _logErrorToService(error, stack);
      // FirebaseCrashlytics.instance.recordError(error, stack);
    } else {
      _logger.e('Platform Error', error: error, stackTrace: stack);
    }
    return true;
  };
  
  // Handle uncaught exceptions
  runZonedGuarded(() {
    // Your app runs here
  }, (error, stack) {
    if (!EnvVariables.instance.debugMode) {
      _logErrorToService(error, stack);
      // FirebaseCrashlytics.instance.recordError(error, stack);
    } else {
      _logger.e('Uncaught Error', error: error, stackTrace: stack);
    }
  });
}

void _logErrorToService(Object error, StackTrace stack) {
  // Implement your error logging service here
  // For now, just log locally
  _logger.e('Production Error', error: error, stackTrace: stack);
}

Future<bool> _checkInitialConnectivity() async {
  try {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) =>
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.ethernet);
  } catch (e) {
    _logger.e('Failed to check connectivity', error: e);
    return false; // Assume no connection on error
  }
}

void _showNoNetworkScreen() {
  runApp(
    const MaterialApp(
      home: NoNetworkScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> _initializeSupabaseWithRetry({int maxRetries = 3}) async {
  int attempts = 0;
  Duration delay = const Duration(seconds: 1);
  
  while (attempts < maxRetries) {
    try {
      // Fixed: Removed redundant parameters and used correct options
      await Supabase.initialize(
        url: EnvVariables.instance.supabaseUrl,
        anonKey: EnvVariables.instance.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          autoRefreshToken: true,
          // persistSession is default true, removed as it's redundant
        ),
        realtimeClientOptions: const RealtimeClientOptions(
          eventsPerSecond: 10,
          // timeout parameter removed as it doesn't exist
        ),
        // storageOptions removed as parameters don't exist
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw TimeoutException('Supabase initialization timeout'),
      );
      
      _logger.i('✅ Supabase initialized successfully');
      return;
      
    } catch (e) {
      attempts++;
      _logger.w('⚠️ Supabase initialization attempt $attempts failed: $e');
      
      if (attempts == maxRetries) {
        rethrow;
      }
      
      await Future.delayed(delay);
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
    _logger.e('❌ Failed to initialize AudioService', error: e, stackTrace: stackTrace);
    // Continue app without audio if needed
  }
}

void _handleInitializationError(Object e, StackTrace stackTrace) {
  _logger.e('❌ App initialization failed', error: e, stackTrace: stackTrace);
  
  // Show error screen with retry option
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ErrorScreen(
        error: e,
        onRetry: () {
          // Restart the app
          main();
        },
      ),
    ),
  );
}

class _ErrorScreen extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  
  const _ErrorScreen({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    String errorMessage = 'Unknown error occurred';
    bool isNetworkError = error.toString().toLowerCase().contains('network') ||
                          error.toString().toLowerCase().contains('connection');
    
    if (isNetworkError) {
      errorMessage = 'Network connection issue. Please check your internet.';
    } else if (error is TimeoutException) {
      errorMessage = 'Connection timeout. Please try again.';
    } else {
      errorMessage = 'Failed to initialize app: ${error.toString()}';
    }
    
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isNetworkError ? Icons.wifi_off : Icons.error_outline,
                  size: 80,
                  color: Colors.red.shade700,
                ),
                const SizedBox(height: 24),
                Text(
                  isNetworkError ? 'Connection Error' : 'Initialization Failed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  errorMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Retry'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => SystemNavigator.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Close'),
                    ),
                  ],
                ),
                if (!EnvVariables.instance.debugMode) ...[
                  const SizedBox(height: 24),
                  Text(
                    'If the problem persists, please contact support',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}