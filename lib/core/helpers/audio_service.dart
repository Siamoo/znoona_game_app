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

      // Preload the background music file
      try {
        await _musicPlayer!.setAsset('assets/audio/background.mp3');
        print('✅ Background music file loaded successfully');
      } catch (e) {
        print('⚠️ Could not preload background music: $e');
      }

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

  // Background music methods - using ONLY local file
  Future<void> startBackgroundMusic() async {
    if (!_isInitialized) {
      print('⚠️ AudioService not initialized, attempting to initialize...');
      await initialize();
    }
    
    if (!(_currentState?.isBackgroundMusicEnabled ?? true)) {
      print('⚠️ Background music disabled in settings');
      return;
    }
    
    if (_isMusicPlaying || _musicPlayer?.playerState.playing == true) {
      print('🎶 Background music already playing');
      return;
    }
    
    try {
      print('🎵 Starting background music from local file...');
      
      // Set the audio source to your local file
      await _musicPlayer?.setAsset('assets/audio/background.mp3');
      await _musicPlayer?.setVolume(_currentState?.musicVolume ?? 0.5);
      await _musicPlayer?.play();
      
      _isMusicPlaying = true;
      print('✅ Background music started successfully from local file');
    } catch (e) {
      print('❌ Failed to start background music: $e');
      print('⚠️ Please check that assets/audio/background.mp3 exists');
      _isMusicPlaying = false;
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer?.stop();
      _isMusicPlaying = false;
      print('🎶 Background music stopped');
    } catch (e) {
      print('❌ Stop background music error: $e');
    }
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      await _musicPlayer?.pause();
      _isMusicPlaying = false;
      print('🎶 Background music paused');
    } catch (e) {
      print('❌ Pause background music error: $e');
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (_currentState?.isBackgroundMusicEnabled ?? true) {
      try {
        await _musicPlayer?.play();
        _isMusicPlaying = true;
        print('🎶 Background music resumed');
      } catch (e) {
        print('❌ Resume background music error: $e');
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
    _isMusicPlaying = false;
    print('🗑️ AudioService disposed');
  }
}