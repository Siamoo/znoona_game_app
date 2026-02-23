import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';
import 'package:medaan_almaarifa/core/app/connectivity_controller.dart';
import 'package:medaan_almaarifa/core/common/screens/no_network_screen.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
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
  @override
  void initState() {
    super.initState();
    // Initialize connectivity after widget is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityController.instance.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;

    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, _) {
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
                // **FIXED: Only update AudioService if it's initialized**
                // This prevents calling onAppStateChanged before initialization
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  try {
                    final audioService = sl<AudioService>();
                    // Check if audio service is ready before updating
                    audioService.onAppStateChanged(state);
                  } catch (e) {}
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
                    final mediaQuery = MediaQuery.of(context);
                    // Option 1: Fully disable system font scaling
                    return MediaQuery(
                      data: mediaQuery.copyWith(
                        textScaler: TextScaler.noScaling,
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: Scaffold(
                          body: child!,
                        ),
                      ),
                    );
                  },

                  home: !value
                      ? const NoNetworkScreen()
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
}
