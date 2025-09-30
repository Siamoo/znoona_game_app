import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/routes/base_routes.dart';

class ZnoonaNavigate {
  // Push a widget with animation
  static Future<T?> pushTo<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(
      context,
      BaseRoute<T>(page: page),
    );
  }

  // PushReplacement a widget with animation
  static Future<T?> pushReplacementTo<T>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, T>(
      context,
      BaseRoute<T>(page: page),
    );
  }

  // Pop current screen
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  // PushReplacement without back
  static Future<T?> navigateWithoutBack<T>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, T>(
      context,
      BaseRoute<T>(page: page),
    );
  }

  static Future<T?> pushReplacementAndRemoveUntil<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      BaseRoute<T>(page: page),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }
}
