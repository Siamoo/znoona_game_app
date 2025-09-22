import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/theme/image_extension.dart';

class ZnoonaImages {
  static MyImages of(BuildContext context) {
    return Theme.of(context).extension<MyImages>()!;
  }

  static String underBuild(BuildContext context) {
    return of(context).underBuildImage;
  }

}
