import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/images/app_images.dart';

class MyImages extends ThemeExtension<MyImages> {
  MyImages({
    required this.underBuildImage,
  });

  final String underBuildImage;
  @override
  ThemeExtension<MyImages> copyWith() {
    return MyImages(
      underBuildImage: underBuildImage,
    );
  }

  @override
  ThemeExtension<MyImages> lerp(
    covariant ThemeExtension<MyImages>? other,
    double t,
  ) {
    if (other is! MyImages) {
      return this;
    }
    return MyImages(
      underBuildImage:  underBuildImage,
    );
  }

  static MyImages dark = MyImages(
    underBuildImage: AppImages.darkUnderBuild,
  );
  static MyImages light = MyImages(
    underBuildImage: AppImages.lightUnderBuild,
  );
}
