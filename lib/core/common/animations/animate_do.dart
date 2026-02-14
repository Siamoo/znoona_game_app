import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/core/common/animations/animation_constants.dart';

class CustomFadeInDown extends StatelessWidget {
  const CustomFadeInDown({
    required this.child,
    this.duration = AnimationDurations.medium,
    this.delay = AnimationDelays.medium,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: delay,
      duration: duration,
      curve: AnimationCurves.defaultCurve,
      child: child,
    );
  }
}

class CustomFadeInUp extends StatelessWidget {
  const CustomFadeInUp({
    required this.child,
    this.duration = AnimationDurations.medium,
    this.delay = AnimationDelays.medium,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: delay,
      duration: duration,
      curve: AnimationCurves.defaultCurve,
      child: child,
    );
  }
}

class CustomFadeInLeft extends StatelessWidget {
  const CustomFadeInLeft({
    required this.child,
    this.duration = AnimationDurations.medium,
    this.delay = AnimationDelays.medium,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    // Get language once and cache it
    final isRtl = Localizations.localeOf(context).languageCode == 'en';

    return isRtl
        ? FadeInRight(
            delay: delay,
            duration: duration,
            curve: AnimationCurves.defaultCurve,
            child: child,
          )
        : FadeInLeft(
            delay: delay,
            duration: duration,
            curve: AnimationCurves.defaultCurve,
            child: child,
          );
  }
}

class CustomFadeInRight extends StatelessWidget {
  const CustomFadeInRight({
    required this.child,
    this.duration = AnimationDurations.medium,
    this.delay = AnimationDelays.medium,
    super.key,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final isRtl = Localizations.localeOf(context).languageCode == 'en';

    return isRtl
        ? FadeInLeft(
            delay: delay,
            duration: duration,
            curve: AnimationCurves.defaultCurve,
            child: child,
          )
        : FadeInRight(
            delay: delay,
            duration: duration,
            curve: AnimationCurves.defaultCurve,
            child: child,
          );
  }
}
