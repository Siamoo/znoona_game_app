// test_audio_screen.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';

class TestAudioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioService = GetIt.I<AudioService>();
    
    return Scaffold(
      appBar: AppBar(title: Text('Test Audio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => audioService.playTestSound(),
              child: Text('Play Test Sound'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => audioService.playCorrectSound(),
              child: Text('Play Correct Sound'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => audioService.playWrongSound(),
              child: Text('Play Wrong Sound'),
            ),
          ],
        ),
      ),
    );
  }
}