import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/style/colors/colors_dark.dart';
import 'package:znoona_game_app/core/style/colors/colors_light.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.mainColor,
    required this.bluePinkDark,
    required this.bluePinkLight,
    required this.textColor,
    required this.textFormBorder,
    required this.navBarbg,
    required this.navBarSelectedTab,
    required this.containerShadow1,
    required this.containerShadow2,
    required this.containerLinear1,
    required this.containerLinear2,
  });

  final Color? mainColor;
  final Color? bluePinkDark;
  final Color? bluePinkLight;
  final Color? textColor;
  final Color? textFormBorder;
  final Color? navBarbg;
  final Color? navBarSelectedTab;
  final Color? containerShadow1;
  final Color? containerShadow2;
  final Color? containerLinear1;
  final Color? containerLinear2;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? mainColor,
    Color? bluePinkDark,
    Color? bluePinkLight,
    Color? textColor,
    Color? textFormBorder,
    Color? navBarbg,
    Color? navBarSelectedTab,
    Color? containerShadow1,
    Color? containerShadow2,
    Color? containerLinear1,
  }) {
    return MyColors(
      mainColor: mainColor,
      bluePinkDark: bluePinkDark,
      bluePinkLight: bluePinkLight,
      textColor: textColor,
      textFormBorder: textFormBorder,
      navBarbg: navBarbg,
      navBarSelectedTab: navBarSelectedTab,
      containerShadow1: containerShadow1,
      containerShadow2: containerShadow2,
      containerLinear1: containerLinear1,
      containerLinear2: containerLinear2,
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
      mainColor: mainColor,
      bluePinkDark: bluePinkDark,
      bluePinkLight: bluePinkLight,
      textColor: textColor,
      textFormBorder: textFormBorder,
      navBarbg: navBarbg,
      navBarSelectedTab: navBarSelectedTab,
      containerShadow1: containerShadow1,
      containerShadow2: containerShadow2,
      containerLinear1: containerLinear1,
      containerLinear2: containerLinear2,
    );
  }

  static const MyColors dark = MyColors(
    mainColor: ColorsDark.mainColor,
    bluePinkLight: ColorsDark.blueLight,
    bluePinkDark: ColorsDark.blueDark,
    textColor: ColorsDark.white,
    textFormBorder: ColorsDark.blueLight,
    navBarbg: ColorsDark.navBarDark,
    navBarSelectedTab: ColorsDark.white,
    containerShadow1: ColorsDark.blueLight,
    containerShadow2: ColorsDark.black2,
    containerLinear1: ColorsDark.black1,
    containerLinear2: ColorsDark.black2,
  );

  static const MyColors light = MyColors(
    mainColor: ColorsLight.mainColor,
    bluePinkDark: ColorsLight.redDark,
    bluePinkLight: ColorsLight.redLight,
    textColor: ColorsLight.black,
    textFormBorder: ColorsLight.redLight,
    navBarbg: ColorsLight.mainColor,
    navBarSelectedTab: ColorsLight.black,
    containerShadow1: ColorsLight.redDark,
    containerShadow2: ColorsLight.white2,
    containerLinear1: ColorsLight.white1,
    containerLinear2: ColorsLight.white2,
  );
}
