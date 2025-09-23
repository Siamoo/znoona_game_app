import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:znoona_game_app/core/app/connectivity_controller.dart';
import 'package:znoona_game_app/core/language/app_localizations_setup.dart';
import 'package:znoona_game_app/core/routes/app_routes.dart';
import 'package:znoona_game_app/core/style/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, _) {
        return ScreenUtilInit(
          designSize: const Size(384, 805),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Znoona Game App',
            theme: darkTheme(),
            locale: const Locale('en'),
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            builder: (context, child) {
              return GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: value ? AppRoutes.login : AppRoutes.noNetwork,
          ),
        );
      },
    );
  }
}
