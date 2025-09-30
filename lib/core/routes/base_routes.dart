import 'package:flutter/material.dart';

class BaseRoute<T> extends PageRouteBuilder<T> {
  BaseRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            const beginOffset = Offset(0.1, 0); // slide from right
            const endOffset = Offset.zero;
            const curve = Curves.easeInOut;

            final slideTween = Tween<Offset>(
              begin: beginOffset,
              end: endOffset,
            ).chain(CurveTween(curve: curve));

            final fadeTween = Tween<double>(
              begin: 0,
              end: 1,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(slideTween),
              child: FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
            );
          },
        );

  final Widget page;
}
