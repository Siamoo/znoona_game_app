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

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      print('🎵 Initializing AudioService...');

      // Configure audio session for better audio handling
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      // Initialize audio players
      _soundPlayer = AudioPlayer();
      _musicPlayer = AudioPlayer();

      // Set up music player
      await _musicPlayer!.setLoopMode(LoopMode.all);
      await _musicPlayer!.setVolume(0.5);

      _isInitialized = true;
      print('✅ AudioService initialized successfully');

      // Set initial state if it was provided before initialization
      if (_currentState != null) {
        _applyStateToPlayers(_currentState!);
      }
    } catch (e) {
      print('❌ AudioService initialization error: $e');
      _isInitialized = false;
    }
  }

  void onAppStateChanged(AppState state) {
    _currentState = state;

    if (_isInitialized && _soundPlayer != null && _musicPlayer != null) {
      _applyStateToPlayers(state);
      
      // Auto-start or stop background music based on settings
      if (state.isBackgroundMusicEnabled) {
        // Only start if not already playing
        if (_musicPlayer?.playerState.playing != true) {
          startBackgroundMusic();
        }
      } else {
        stopBackgroundMusic();
      }
    } else {
      print('⚠️ AudioService not ready yet, storing state for later');
    }
  }

  void _applyStateToPlayers(AppState state) {
    try {
      _soundPlayer?.setVolume(state.soundVolume);
      _musicPlayer?.setVolume(state.musicVolume);
      print(
        '🔊 Audio volume updated: sound=${state.soundVolume}, music=${state.musicVolume}',
      );
    } catch (e) {
      print('❌ Error applying audio state: $e');
    }
  }

  Future<void> _playAsset(String assetPath) async {
    if (!_isInitialized || !(_currentState?.isSoundEnabled ?? true)) {
      print('⚠️ Cannot play sound: AudioService not ready or sound disabled');
      return;
    }

    try {
      await _soundPlayer?.stop();
      await _soundPlayer?.setAsset(assetPath);
      await _soundPlayer?.play();
      print('🎵 Playing: $assetPath');
    } catch (e) {
      print('❌ Play asset error: $e - Asset: $assetPath');
    }
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

  // Background music methods
  Future<void> startBackgroundMusic() async {
    if (!_isInitialized || !(_currentState?.isBackgroundMusicEnabled ?? true)) {
      return;
    }

    try {
      // Check if music is already playing
      if (_musicPlayer?.playerState.playing == true) {
        print('🎶 Background music already playing');
        return;
      }
      
      await _musicPlayer?.setAsset('assets/audio/background.mp3');
      await _musicPlayer?.setVolume(_currentState?.musicVolume ?? 0.5);
      await _musicPlayer?.play();
      print('🎶 Background music started');
    } catch (e) {
      print('❌ Start background music error: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer?.stop();
      print('🎶 Background music stopped');
    } catch (e) {
      print('❌ Stop background music error: $e');
    }
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      await _musicPlayer?.pause();
      print('🎶 Background music paused');
    } catch (e) {
      print('❌ Pause background music error: $e');
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (_currentState?.isBackgroundMusicEnabled ?? true) {
      try {
        await _musicPlayer?.play();
        print('🎶 Background music resumed');
      } catch (e) {
        print('❌ Resume background music error: $e');
      }
    }
  }

  Future<void> stopAllSounds() async {
    try {
      await _soundPlayer?.stop();
      await _musicPlayer?.stop();
      print('🔇 All sounds stopped');
    } catch (e) {
      print('❌ Stop all sounds error: $e');
    }
  }

  void dispose() {
    _soundPlayer?.dispose();
    _musicPlayer?.dispose();
    _soundPlayer = null;
    _musicPlayer = null;
    _isInitialized = false;
    print('🗑️ AudioService disposed');
  }
}