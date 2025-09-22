import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:znoona_game_app/core/style/colors/dark_colors.dart';
import 'package:znoona_game_app/core/style/colors/light_colors.dart';
import 'package:znoona_game_app/core/style/theme/color_extension.dart';
import 'package:znoona_game_app/core/style/theme/image_extension.dart';

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: DarkColors.secondaryColor,
    extensions: <ThemeExtension<dynamic>>{
      MyColors.dark,
      MyImages.dark,
    },
    textTheme: GoogleFonts.beirutiTextTheme(),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: LightColors.secondaryColor,
    extensions: <ThemeExtension<dynamic>>{
      MyColors.light,
      MyImages.light,
    },
    textTheme: GoogleFonts.beirutiTextTheme(),
  );
}
