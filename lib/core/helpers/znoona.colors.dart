import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/core/style/theme/my_colors_extension.dart';

class ZnoonaColors {
  static MyColors of(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>();
    assert(colors != null, 'MyColors extension not found in theme');
    return colors ?? const MyColors.dark(); // Return default as fallback
  }

  static Color main(BuildContext context) => of(context).mainColor!;

  static Color bluePinkDark(BuildContext context) => of(context).bluePinkDark!;

  static Color bluePinkLight(BuildContext context) =>
      of(context).bluePinkLight!;

  static Color text(BuildContext context) => of(context).textColor!;

  static Color textFormBorder(BuildContext context) =>
      of(context).textFormBorder!;

  static Color navBarbg(BuildContext context) => of(context).navBarbg!;

  static Color navBarSelectedTab(BuildContext context) =>
      of(context).navBarSelectedTab!;

  static Color containerShadow1(BuildContext context) =>
      of(context).containerShadow1!;

  static Color containerShadow2(BuildContext context) =>
      of(context).containerShadow2!;

  static Color containerLinear1(BuildContext context) =>
      of(context).containerLinear1!;
      
  static Color containerLinear2(BuildContext context) =>
      of(context).containerLinear2!;
}
