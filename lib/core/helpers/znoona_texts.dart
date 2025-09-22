import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/language/app_localizations.dart';

class ZnoonaTexts {
  static String tr(BuildContext context, String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }
}
