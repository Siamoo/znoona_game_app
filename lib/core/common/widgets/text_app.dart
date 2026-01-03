import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  const TextApp({
    required this.text,
    this.textStyle,
    this.maxLines,
    this.softWrap,
    this.textOverflow,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      softWrap: softWrap ?? true, // Default to true for better text wrapping
      overflow: textOverflow ?? TextOverflow.ellipsis, // Default to ellipsis
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );
  }
}

// Optional: Add extension methods for common use cases
extension TextAppExtensions on TextApp {
  // Factory constructor for heading text
  static TextApp heading(String text, {Color? color}) {
    return TextApp(
      text: text,
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
      maxLines: 2,
      textOverflow: TextOverflow.ellipsis,
    );
  }

  // Factory constructor for body text
  static TextApp body(String text, {Color? color}) {
    return TextApp(
      text: text,
      textStyle: TextStyle(
        fontSize: 16,
        color: color,
      ),
      maxLines: 3,
      textOverflow: TextOverflow.ellipsis,
    );
  }

  // Factory constructor for caption/small text
  static TextApp caption(String text, {Color? color}) {
    return TextApp(
      text: text,
      textStyle: TextStyle(
        fontSize: 12,
        color: color,
      ),
      maxLines: 1,
      textOverflow: TextOverflow.ellipsis,
    );
  }
}