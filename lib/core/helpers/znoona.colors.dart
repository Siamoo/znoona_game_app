import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/core/style/theme/my_colors_extension.dart';

class ZnoonaColors {
  static MyColors of(BuildContext context) {
    try {
      final colors = Theme.of(context).extension<MyColors>();
      if (colors != null) {
        return colors;
      }

      // If extension not found, try to get from default theme
      final theme = Theme.of(context);
      if (theme.brightness == Brightness.dark) {
        return const MyColors.dark();
      } else {
        return const MyColors.light();
      }
    } catch (e) {
      // Return default dark theme colors if theme not available
      return const MyColors.dark();
    }
  }

  static Color main(BuildContext context) =>
      of(context).mainColor ?? const Color(0xFF242C3B);
  static Color bluePinkDark(BuildContext context) =>
      of(context).bluePinkDark ?? const Color(0xFF176B87);
  static Color bluePinkLight(BuildContext context) =>
      of(context).bluePinkLight ?? const Color(0xFF37B6E9);
  static Color text(BuildContext context) =>
      of(context).textColor ?? Colors.white;
  static Color textFormBorder(BuildContext context) =>
      of(context).textFormBorder ?? const Color(0xFF37B6E9);
  static Color navBarbg(BuildContext context) =>
      of(context).navBarbg ?? const Color(0xff2b3361);
  static Color navBarSelectedTab(BuildContext context) =>
      of(context).navBarSelectedTab ?? Colors.white;
  static Color containerShadow1(BuildContext context) =>
      of(context).containerShadow1 ?? const Color(0xFF37B6E9);
  static Color containerShadow2(BuildContext context) =>
      of(context).containerShadow2 ?? const Color(0xFF242C3B);
  static Color containerLinear1(BuildContext context) =>
      of(context).containerLinear1 ?? const Color(0xff353F54);
  static Color containerLinear2(BuildContext context) =>
      of(context).containerLinear2 ?? const Color(0xff222834);

  // Add fallback colors for when context is not available
  static Color get fallbackMain => const Color(0xFF242C3B);
  static Color get fallbackBluePinkDark => const Color(0xFF176B87);
  static Color get fallbackBluePinkLight => const Color(0xFF37B6E9);
  static Color get fallbackText => Colors.white;
  static Color get fallbackTextFormBorder => const Color(0xFF37B6E9);
}
