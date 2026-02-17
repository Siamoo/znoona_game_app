import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  AudioPlayer? _soundPlayer;
  AudioPlayer? _musicPlayer;

  bool _isInitialized = false;
  AppState? _currentState;
  bool _isMusicPlaying = false;

  bool get isSoundEnabled => _currentState?.isSoundEnabled ?? true;
  bool get isBackgroundMusicEnabled =>
      _currentState?.isBackgroundMusicEnabled ?? true;
  bool get isVibrationEnabled => _currentState?.isVibrationEnabled ?? true;
  double get soundVolume => _currentState?.soundVolume ?? 1.0;
  double get musicVolume => _currentState?.musicVolume ?? 0.5;
  bool get isMusicActuallyPlaying =>
      _isInitialized && _musicPlayer?.playerState.playing == true;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Configure audio session for better audio handling
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      // Initialize audio players
      _soundPlayer = AudioPlayer();
      _musicPlayer = AudioPlayer();

      // Set up music player
      await _musicPlayer!.setLoopMode(LoopMode.all);
      await _musicPlayer!.setVolume(0.5);

      // Preload the background music file
      try {
        await _musicPlayer!.setAsset('assets/audio/background.mp3');
      } catch (e) {}

      _isInitialized = true;

      // Set initial state if it was provided before initialization
      if (_currentState != null) {
        _applyStateToPlayers(_currentState!);
      }
    } catch (e) {
      _isInitialized = false;
    }
  }

  void onAppStateChanged(AppState state) {
    _currentState = state;

    if (_isInitialized && _soundPlayer != null && _musicPlayer != null) {
      _applyStateToPlayers(state);
    } else {}
  }

  void _applyStateToPlayers(AppState state) {
    try {
      _soundPlayer?.setVolume(state.soundVolume);
      _musicPlayer?.setVolume(state.musicVolume);
    } catch (e) {}
  }

  Future<void> _playAsset(String assetPath) async {
    if (!_isInitialized || !(_currentState?.isSoundEnabled ?? true)) {
      return;
    }

    try {
      await _soundPlayer?.stop();
      await _soundPlayer?.setAsset(assetPath);
      await _soundPlayer?.play();
    } catch (e) {}
  }

  // Sound effect methods
  Future<void> playCorrectSound() async {
    await _playAsset('assets/audio/correct.mp3');
  }

  Future<void> playWrongSound() async {
    await _playAsset('assets/audio/wrong.mp3');
  }

  Future<void> playTimerWarningSound() async {
    await _playAsset('assets/audio/timer_warning.mp3');
  }

  Future<void> playTimerCriticalSound() async {
    await _playAsset('assets/audio/timer_critical.mp3');
  }

  Future<void> playWinSound() async {
    await _playAsset('assets/audio/win.mp3');
  }

  Future<void> playGoodResultSound() async {
    await _playAsset('assets/audio/good.mp3');
  }

  Future<void> playBadResultSound() async {
    await _playAsset('assets/audio/bad.mp3');
  }

  Future<void> playTestSound() async {
    await _playAsset('assets/audio/test.mp3');
  }

  // Background music methods - using ONLY local file
  Future<void> startBackgroundMusic() async {
    if (!_isInitialized) {
      await initialize();
    }

    if (!(_currentState?.isBackgroundMusicEnabled ?? true)) {
      return;
    }

    if (_isMusicPlaying || _musicPlayer?.playerState.playing == true) {
      return;
    }

    try {
      // Set the audio source to your local file
      await _musicPlayer?.setAsset('assets/audio/background.mp3');
      await _musicPlayer?.setVolume(_currentState?.musicVolume ?? 0.5);
      await _musicPlayer?.play();

      _isMusicPlaying = true;
    } catch (e) {
      _isMusicPlaying = false;
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer?.stop();
      _isMusicPlaying = false;
    } catch (e) {}
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      await _musicPlayer?.pause();
      _isMusicPlaying = false;
    } catch (e) {}
  }

  Future<void> resumeBackgroundMusic() async {
    if (_currentState?.isBackgroundMusicEnabled ?? true) {
      try {
        await _musicPlayer?.play();
        _isMusicPlaying = true;
      } catch (e) {
        // If resume fails, try starting fresh
        await startBackgroundMusic();
      }
    }
  }

  Future<void> stopAllSounds() async {
    try {
      await _soundPlayer?.stop();
      await _musicPlayer?.stop();
      _isMusicPlaying = false;
    } catch (e) {}
  }

  void dispose() {
    _soundPlayer?.dispose();
    _musicPlayer?.dispose();
    _soundPlayer = null;
    _musicPlayer = null;
    _isInitialized = false;
    _isMusicPlaying = false;
  }
}
