import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/routes/base_routes.dart';

class ZnoonaNavigate {
  // Push a widget with animation
  static Future<void> pushTo(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      BaseRoute(page: page),
    );
  }

  // PushReplacement a widget with animation
  static Future<void> pushReplacementTo(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      BaseRoute(page: page),
    );
  }

  // Pop current screen
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  // PushReplacement without back
  static Future<void> navigateWithoutBack(BuildContext context, Widget page) {
    return Navigator.pushReplacement(
      context,
      BaseRoute(page: page),
    );
  }

  // PushReplacement and remove all previous routes
  static Future<void> pushReplacementAndRemoveUntil(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil(
      context,
      BaseRoute(page: page),
      (Route<dynamic> route) => false, // Remove all previous routes
    );
  }
}
