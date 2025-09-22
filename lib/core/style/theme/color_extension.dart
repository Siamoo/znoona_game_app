import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/colors/dark_colors.dart';
import 'package:znoona_game_app/core/style/colors/light_colors.dart';

class MyColors extends ThemeExtension<MyColors> {
  MyColors({
    required this.premaryColor,
    required this.secondaryColor,
  });

  final Color premaryColor;
  final Color secondaryColor;
  @override
  ThemeExtension<MyColors> copyWith() {
    return MyColors(
      premaryColor: premaryColor,
      secondaryColor: secondaryColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      premaryColor: Color.lerp(premaryColor, other.premaryColor, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
    );
  }

  static MyColors dark = MyColors(
    premaryColor: DarkColors.primaryColor,
    secondaryColor: DarkColors.secondaryColor,
  );
  static MyColors light = MyColors(
    premaryColor: LightColors.primaryColor,
    secondaryColor: LightColors.secondaryColor,
  );
}
