import 'package:flutter/material.dart';

class TestScreenTwo extends StatelessWidget {
  const TestScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen Two'),
      ),
      body: const Center(
        child: Text('This is Test Screen Two'),
      ),
      );
  }
}