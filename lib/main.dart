import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:znoona_game_app/core/app/env.variables.dart';
import 'package:znoona_game_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvVariables.instance.init(envType: EnvTypeEnum.prod);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
