import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:znoona_game_app/core/app/app_cubit/app_cubit.dart';
import 'package:znoona_game_app/core/app/connectivity_controller.dart';
import 'package:znoona_game_app/core/common/screens/no_network_screen.dart';
import 'package:znoona_game_app/core/di/injcetion_container.dart';
import 'package:znoona_game_app/core/language/app_localizations_setup.dart';
import 'package:znoona_game_app/core/service/shared_pref/pref_keys.dart';
import 'package:znoona_game_app/core/service/shared_pref/shared_pref.dart';
import 'package:znoona_game_app/core/style/theme/app_theme.dart';
import 'package:znoona_game_app/features/home/screens/home_screen.dart';
import 'package:znoona_game_app/features/user/auth/presentation/cubit/auth_cubit.dart';
import 'package:znoona_game_app/features/user/auth/presentation/screens/login_screen.dart';

class ZnoonaGameApp extends StatelessWidget {
  const ZnoonaGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, _) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AppCubit>()
                ..changeAppThemeMode(
                  sheredMode: SharedPref().getBoolean(PrefKeys.themeMode),
                )
                ..getSavedLanguage(),
            ),
            BlocProvider(create: (_) => sl<AuthCubit>()..getCurrentUser()),
          ],
          child: ScreenUtilInit(
            designSize: const Size(384, 805),
            child: BlocBuilder<AppCubit, AppState>(
              buildWhen: (previous, current) {
                return previous != current;
              },
              builder: (context, state) {
                final cubit = context.read<AppCubit>();
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Znoona Game App',
                  theme: cubit.isDarkMode ? darkTheme() : lightTheme(),
                  locale: Locale(cubit.currentLangcode),
                  supportedLocales: AppLocalizationsSetup.supportedLocales,
                  localeResolutionCallback:
                      AppLocalizationsSetup.localeResolutionCallback,
                  localizationsDelegates:
                      AppLocalizationsSetup.localizationsDelegates,
                  builder: (context, child) {
                    return GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Scaffold(
                        body: Builder(
                          builder: (context) {
                            ConnectivityController.instance.init();
                            return child!;
                          },
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
