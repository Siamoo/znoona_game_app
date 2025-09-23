import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/common/animations/animate_do.dart';
import 'package:znoona_game_app/core/helpers/znoona.colors.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/refactors/auth_custom_painter.dart';
import 'package:znoona_game_app/features/admin/auth/presentation/refactors/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomFadeInUp(
        duration: 800,
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 150),
          painter: AuthCustomPainter(
            gradient: LinearGradient(
              colors: [
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkDark(context),
              ],
              begin: const Alignment(0.46, -0.89),
              end: const Alignment(-0.46, 0.89),
            ),
          ),
        ),
      ),
      body: const SafeArea(bottom: false, child: LoginBody()),
    );
  }
}
