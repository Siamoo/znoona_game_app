import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/theme/my_assets_extension.dart';

class ZnoonaImages {
  static MyAssets of(BuildContext context) {
    return Theme.of(context).extension<MyAssets>()!;
  }

  static String bigNavBar(BuildContext context) =>
      of(context).bigNavBar!;

  static String homeBg(BuildContext context) =>
      of(context).homeBg!;
}
