import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/di/injection_container.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/features/home/refactors/home_body.dart';
import 'package:medaan_almaarifa/features/user/auth/presentation/cubit/auth_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final AudioService _audioService = sl<AudioService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Start background music when home screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _audioService.startBackgroundMusic();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_audioService.isInitialized) return;
    
    switch (state) {
      case AppLifecycleState.paused:
        _audioService.pauseBackgroundMusic();
      case AppLifecycleState.resumed:
        _audioService.resumeBackgroundMusic();
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _audioService.stopBackgroundMusic();
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.maybeWhen(
          authenticated: (profile, authMethod) => HomeBody(
            profile: profile,
          ),
          orElse: () {
            return Container();
          },
        );
      },
    );
  }
}