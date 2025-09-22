import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:znoona_game_app/core/app/connectivity_controller.dart';
import 'package:znoona_game_app/core/app/env.variables.dart';
import 'package:znoona_game_app/core/common/screens/no_network_screen.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectivityController.instance.isConnected,
      builder: (_, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Znoona Game App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) {
            return Scaffold(
              body: Builder(
                builder: (context) {
                  ConnectivityController.instance.init();
                  return child!;
                },
              ),
            );
          },
          home: value
              ? const Scaffold(body: Center(child: Text('Connected')))
              : const NoNetworkScreen(),
        );
      },
    );
  }
}
