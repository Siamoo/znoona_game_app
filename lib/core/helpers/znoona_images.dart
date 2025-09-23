import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/theme/my_assets_extension.dart';

class ZnoonaImages {
  static MyAssets of(BuildContext context) {
    return Theme.of(context).extension<MyAssets>()!;
  }

  static String underBuild(BuildContext context) {
    return of(context).homeBg!;
  }

}
