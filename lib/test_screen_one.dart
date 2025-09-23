import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/znoona_colors.dart';
import 'package:znoona_game_app/core/helpers/znoona_images.dart';
import 'package:znoona_game_app/core/helpers/znoona_texts.dart';

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
              ZnoonaTexts.tr(context, 'app_name'),
              style: TextStyle(
                fontSize: 30,
                color: ZnoonaColors.main(context),
              ),
            ),
            Text(
              'This is Test Screen one',
              style: TextStyle(
                fontSize: 30,
                color: ZnoonaColors.main(context),
              ),
            ),
            Text(
              'This is Test Screen one',
              style: TextStyle(
                fontSize: 30,
                color: ZnoonaColors.main(context),
              ),
            ),
            Image.asset(ZnoonaImages.underBuild(context))
          ],
        ),
      ),
    );
  }
}
