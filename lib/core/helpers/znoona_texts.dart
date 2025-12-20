import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/core/language/app_localizations.dart';

class ZnoonaTexts {
  static String tr(BuildContext context, String key) {
    return AppLocalizations.of(context)?.translate(key) ?? key;
  }
}
