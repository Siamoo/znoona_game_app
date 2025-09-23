import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/theme/my_colors_extension.dart';

class ZnoonaColors {
  static MyColors of(BuildContext context) {
    return Theme.of(context).extension<MyColors>()!;
  }

  static Color main(BuildContext context) {
    return of(context).mainColor!;
  }

  static Color textcolor(BuildContext context) {
    return of(context).textColor!;
  }

}
