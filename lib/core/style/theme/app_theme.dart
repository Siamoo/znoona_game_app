import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/style/colors/colors_dark.dart';
import 'package:znoona_game_app/core/style/colors/colors_light.dart';
import 'package:znoona_game_app/core/style/theme/my_assets_extension.dart';
import 'package:znoona_game_app/core/style/theme/my_colors_extension.dart';

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsDark.mainColor,
    extensions: const <ThemeExtension<dynamic>>{
      MyColors.dark,
      MyAssets.dark,
    },
    textTheme: GoogleFonts.beirutiTextTheme(),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsLight.mainColor,
    extensions: const <ThemeExtension<dynamic>>{
      MyColors.light,
      MyAssets.light,
    },
    textTheme: GoogleFonts.beirutiTextTheme(),
  );
}
