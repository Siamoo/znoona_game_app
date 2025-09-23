import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/common/screens/no_network_screen.dart';
import 'package:znoona_game_app/core/common/screens/page_under_build_screen.dart';
import 'package:znoona_game_app/core/routes/base_routes.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/sereens/login_screen.dart';

class AppRoutes {
  static const String login = 'login';
  static const String noNetwork = 'noNetwork';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return BaseRoute(page: const LoginScreen());
      case noNetwork:
        return BaseRoute(page: const NoNetworkScreen ());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
