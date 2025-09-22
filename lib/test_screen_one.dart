import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/helpers/navigate.dart';
import 'package:znoona_game_app/core/routes/app_routes.dart';

class TestScreenOne extends StatelessWidget {
  const TestScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen one'),
      ),
      body:  Center(
        child: Column(
          children: [
            Text('This is Test Screen one'),
            ElevatedButton(onPressed: () async {
              await Navigate.pushNamed(context, AppRoutes.testTwo);
            } , child: Text('Go to Test Screen Two'))
          ],
        ),
      ),
    );
  }
}
