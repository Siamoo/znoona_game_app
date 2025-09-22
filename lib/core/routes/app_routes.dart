import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/common/screens/no_network_screen.dart';
import 'package:znoona_game_app/core/common/screens/page_under_build_screen.dart';
import 'package:znoona_game_app/core/routes/base_routes.dart';
import 'package:znoona_game_app/test_screen_one.dart';
import 'package:znoona_game_app/test_screen_two.dart';

class AppRoutes {
  static const String testOne = 'testOne';
  static const String testTwo = 'testTwo';
  static const String noNetwork = 'noNetwork';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case testOne:
        return BaseRoute(page: const TestScreenOne());
      case testTwo:
        return BaseRoute(page: const TestScreenTwo());
      case noNetwork:
        return BaseRoute(page: const NoNetworkScreen ());
      default:
        return BaseRoute(page: const PageUnderBuildScreen());
    }
  }
}
