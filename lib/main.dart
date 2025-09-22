import 'package:flutter/material.dart';
import 'package:znoona_game_app/core/app/env.variables.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvVariables.instance.init(envType: EnvTypeEnum.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  EnvVariables.instance.debugMode,
      home: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            Center(child: Text('Hello, World!')),
          ],
        ),
      ),
    );
  }
}
