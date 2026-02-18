import 'package:flutter/material.dart';

class AnimationDurations {
  static const Duration fastest = Duration(milliseconds: 500);
  static const Duration fast = Duration(milliseconds: 600);
  static const Duration normal = Duration(milliseconds: 800);
  static const Duration medium = Duration(milliseconds: 1000);
  static const Duration slow = Duration(milliseconds: 1200);
  static const Duration slower = Duration(milliseconds: 1500);
  static const Duration slowest = Duration(milliseconds: 2000);
}

class AnimationDelays {
  static const Duration none = Duration.zero;
  static const Duration short = Duration(milliseconds: 100);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration long = Duration(milliseconds: 500);
}

class AnimationCurves {
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve decelerate = Curves.decelerate;
}
