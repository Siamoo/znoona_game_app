import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/di/injection_container.dart';
import 'package:medaan_almaarifa/core/errors/error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/app/connectivity_controller.dart';
import 'package:medaan_almaarifa/core/common/screens/error_screen.dart';
import 'package:medaan_almaarifa/core/common/screens/no_network_screen.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/language/app_localizations_setup.dart';
import 'package:medaan_almaarifa/core/style/theme/app_theme.dart';
import 'package:medaan_almaarifa/features/home/screens/home_screen.dart';
import 'package:medaan_almaarifa/features/quiz/categories/presentation/cubit/categories_cubit.dart';
import 'package:medaan_almaarifa/features/quiz/room/presentation/cubit/room_cubit.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/screens/login_screen.dart';

class ZnoonaGameApp extends StatefulWidget {
  const ZnoonaGameApp({super.key});

  @override
  State<ZnoonaGameApp> createState() => _ZnoonaGameAppState();
}

class _ZnoonaGameAppState extends State<ZnoonaGameApp> {
  bool _hasCriticalError = false;
  String? _criticalErrorMessage;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize connectivity after widget is mounted
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ConnectivityController.instance.init();
      });
    } catch (e, stackTrace) {
      ErrorHandler.logError(e, stackTrace, message: 'App initialization error');
      setState(() {
        _hasCriticalError = true;
        _criticalErrorMessage = ErrorHandler.getNetworkErrorMessage(e);
      });
    }
  }

  void _handleAppError(Object error, StackTrace stackTrace) {
    ErrorHandler.logError(error, stackTrace, message: 'App runtime error');

    if (mounted) {
      setState(() {
        _hasCriticalError = true;
        _criticalErrorMessage = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check for critical errors
    if (_hasCriticalError) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ErrorScreen(
          errorMessage: _criticalErrorMessage,
          onRetry: () {
            setState(() {
              _hasCriticalError = false;
              _criticalErrorMessage = null;
            });
            _initializeApp();
          },
        ),
      );
    }

    final session = Supabase.instance.client.auth.currentSession;

    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, isConnected, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AppCubit>(),
            ),
            BlocProvider(create: (_) => sl<AuthCubit>()..getCurrentUser()),
            BlocProvider(create: (_) => sl<RoomCubit>()),
            BlocProvider(
              create: (_) => sl<CategoriesCubit>()..loadMainCategories(),
            ),
          ],
          child: ScreenUtilInit(
            designSize: const Size(384, 805),
            builder: (_, __) => BlocBuilder<AppCubit, AppState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                // Handle app state changes
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  try {
                    final audioService = sl<AudioService>();
                    audioService.onAppStateChanged(state);
                  } catch (e) {
                    // Ignore audio service errors during initialization
                  }
                });

                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Znoona Game App',
                  theme: state.isDarkMode ? darkTheme() : lightTheme(),
                  locale: state.locale,
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,

                  builder: (context, child) {
                    // Wrap with error handling
                    return _ErrorBoundary(
                      onError: _handleAppError,
                      child: _buildMediaQuery(context, child!),
                    );
                  },

                  home: !isConnected
                      ? NoNetworkScreen(
                          onRetry:
                              ConnectivityController.instance.refreshConnection,
                        )
                      : session != null
                      ? const HomeScreen()
                      : const LoginScreen(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildMediaQuery(BuildContext context, Widget child) {
    final mediaQuery = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQuery.copyWith(
        textScaler: TextScaler.noScaling,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    ConnectivityController.instance.dispose();
    super.dispose();
  }
}

/// Error boundary widget to catch widget tree errors
class _ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Function(Object, StackTrace) onError;

  const _ErrorBoundary({
    required this.child,
    required this.onError,
  });

  @override
  State<_ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<_ErrorBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    // Set up error handling for this widget tree
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      widget.onError(details.exception, details.stack ?? StackTrace.current);
    };
  }
}
