import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/theme/color_extension.dart';

class AppColors {
  static MyColors of(BuildContext context) {
    return Theme.of(context).extension<MyColors>()!;
  }

  static Color primary(BuildContext context) {
    return of(context).premaryColor;
  }

  static Color secondary(BuildContext context) {
    return of(context).secondaryColor;
  }

}
