import 'package:flutter/material.dart';
import 'package:medaan_almaarifa/core/style/images/app_images.dart';

class NoNetworkScreen extends StatelessWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Network'),
      ),
      body: Center(
        child: Image.asset(AppImages.noNetwork),
      ),
    );
  }
}
