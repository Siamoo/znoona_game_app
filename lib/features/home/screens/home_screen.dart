import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
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
    if (!_audioService.isBackgroundMusicEnabled) return;
    
    switch (state) {
      case AppLifecycleState.paused:
        _audioService.pauseBackgroundMusic();
        break;
      case AppLifecycleState.resumed:
        _audioService.resumeBackgroundMusic();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _audioService.stopBackgroundMusic();
        break;
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