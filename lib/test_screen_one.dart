import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/app_colors.dart';

class TestScreenOne extends StatelessWidget {
  const TestScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen one'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'This is Test Screen one',
              style: TextStyle(fontSize: 30, color: AppColors.primary(context)),
            ),
            Text(
              'This is Test Screen one',
              style: TextStyle(
                fontSize: 30,
                color: AppColors.secondary(context),
              ),
            ),
            Text(
              'This is Test Screen one',
              style: TextStyle(fontSize: 30, color: AppColors.primary(context)),
            ),
          ],
        ),
      ),
    );
  }
}
