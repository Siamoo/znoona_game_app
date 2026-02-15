import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medaan_almaarifa/core/style/colors/colors_dark.dart';
import 'package:medaan_almaarifa/core/style/colors/colors_light.dart';
import 'package:medaan_almaarifa/core/style/theme/my_colors_extension.dart';

// Create constant instances
const myColorsDark = MyColors(
  mainColor: ColorsDark.mainColor,
  bluePinkLight: ColorsDark.blueLight,
  bluePinkDark: ColorsDark.blueDark,
  textColor: ColorsDark.white,
  textFormBorder: ColorsDark.blueLight,
  navBarbg: ColorsDark.navBarDark,
  navBarSelectedTab: ColorsDark.white,
  containerShadow1: ColorsDark.blueLight,
  containerShadow2: ColorsDark.mainColor,
  containerLinear1: ColorsDark.black1,
  containerLinear2: ColorsDark.black2,
);

const myColorsLight = MyColors(
  mainColor: ColorsLight.mainColor,
  bluePinkDark: ColorsLight.redDark,
  bluePinkLight: ColorsLight.redLight,
  textColor: ColorsLight.black,
  textFormBorder: ColorsLight.redLight,
  navBarbg: ColorsLight.mainColor,
  navBarSelectedTab: ColorsLight.black,
  containerShadow1: ColorsLight.redDark,
  containerShadow2: ColorsLight.redLight,
  containerLinear1: ColorsLight.white1,
  containerLinear2: ColorsLight.white2,
);

ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsDark.mainColor,
    extensions: const <ThemeExtension<dynamic>>[
      myColorsDark,  // ✅ Use the constant instance
      // MyAssets.dark,
    ],
    useMaterial3: true,
    textTheme: GoogleFonts.beirutiTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(fontSize: 20),
      ),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsLight.mainColor,
    extensions: const <ThemeExtension<dynamic>>[
      myColorsLight,  // ✅ Use the constant instance
      // MyAssets.light,
    ],
    useMaterial3: true,
    textTheme: GoogleFonts.beirutiTextTheme(
      const TextTheme(
        bodyMedium: TextStyle(fontSize: 20),
      ),
    ).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}