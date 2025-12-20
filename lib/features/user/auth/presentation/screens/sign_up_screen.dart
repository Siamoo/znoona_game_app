import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medaan_almaarifa/core/common/animations/animate_do.dart';
import 'package:medaan_almaarifa/core/helpers/znoona.colors.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/refactors/auth_custom_painter.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/refactors/sign_up_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomFadeInUp(
        duration: 800,
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 140.h),
          painter: AuthCustomPainter(
            gradient: LinearGradient(
              colors: [
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkLight(context),
                ZnoonaColors.bluePinkDark(context),
              ],
            ),
          ),
        ),
      ),
      body:  SafeArea(bottom: false, child: SignUpBody()),
    );
  }
}
