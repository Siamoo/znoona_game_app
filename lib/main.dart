import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:znoona_game_app/core/app/bloc_observer.dart';
import 'package:znoona_game_app/core/app/env.variables.dart';
import 'package:znoona_game_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvVariables.instance.init(envType: EnvTypeEnum.prod);
  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
