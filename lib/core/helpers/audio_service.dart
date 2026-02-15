import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';

class AudioService with WidgetsBindingObserver {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  AudioPlayer? _soundPlayer;
  AudioPlayer? _musicPlayer;

  bool _isInitialized = false;
  AppState? _currentState;
  bool _isMusicPlaying = false;
  
  // Track lifecycle state
  bool _isAppPaused = false;
  bool _isDisposed = false;

  bool get isSoundEnabled => _currentState?.isSoundEnabled ?? true;
  bool get isBackgroundMusicEnabled =>
      _currentState?.isBackgroundMusicEnabled ?? true;
  double get soundVolume => _currentState?.soundVolume ?? 1.0;
  double get musicVolume => _currentState?.musicVolume ?? 0.5;
  bool get isMusicActuallyPlaying =>
      _isInitialized && _musicPlayer?.playerState.playing == true;

  // Initialize with lifecycle observer
  Future<void> initialize() async {
    if (_isInitialized || _isDisposed) return;

    try {
      // Add lifecycle observer
      WidgetsBinding.instance.addObserver(this);
      
      // Configure audio session for better audio handling
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      // Initialize audio players with error handling
      _soundPlayer = AudioPlayer()..playbackEventStream.listen(_handleSoundEvents);
      _musicPlayer = AudioPlayer()..playbackEventStream.listen(_handleMusicEvents);

      // Set up music player
      await _musicPlayer!.setLoopMode(LoopMode.all);
      await _musicPlayer!.setVolume(0.5);

      // Preload the background music file - FIXED: Don't try to modify any maps
      try {
        // Just set the asset, don't try to verify or modify anything else
        await _musicPlayer!.setAsset('assets/audio/background.mp3');
        debugPrint('✅ Background music preloaded successfully');
      } catch (e) {
        debugPrint('⚠️ Could not preload background music: $e');
        // Continue initialization even if preload fails
      }

      _isInitialized = true;
      debugPrint('✅ AudioService initialized successfully');

      // Set initial state if it was provided before initialization
      if (_currentState != null) {
        _applyStateToPlayers(_currentState!);
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Failed to initialize AudioService: $e');
      debugPrint('Stack trace: $stackTrace');
      _isInitialized = false;
    }
  }

  void _handleSoundEvents(PlaybackEvent event) {
    // Handle sound playback events if needed
  }

  void _handleMusicEvents(PlaybackEvent event) {
    // Update music playing state based on actual playback
    if (_musicPlayer != null) {
      _isMusicPlaying = _musicPlayer!.playerState.playing;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _isAppPaused = true;
        // Pause music when app goes to background
        if (isBackgroundMusicEnabled) {
          pauseBackgroundMusic();
        }
        break;
      case AppLifecycleState.resumed:
        _isAppPaused = false;
        // Resume music if it was playing and should be enabled
        if (isBackgroundMusicEnabled) {
          resumeBackgroundMusic();
        }
        break;
      case AppLifecycleState.detached:
        // App is being destroyed
        dispose();
        break;
      default:
        break;
    }
  }

  void onAppStateChanged(AppState state) {
    _currentState = state;

    if (_isInitialized && _soundPlayer != null && _musicPlayer != null) {
      _applyStateToPlayers(state);
    }
  }

  void _applyStateToPlayers(AppState state) {
    try {
      _soundPlayer?.setVolume(state.soundVolume);
      _musicPlayer?.setVolume(state.musicVolume);
      
      // Handle music playback based on state
      if (state.isBackgroundMusicEnabled && !_isAppPaused) {
        if (!_isMusicPlaying) {
          startBackgroundMusic();
        }
      } else {
        if (_isMusicPlaying) {
          pauseBackgroundMusic();
        }
      }
    } catch (e) {
      debugPrint('Error applying state to players: $e');
    }
  }

  Future<void> _playAsset(String assetPath) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    if (!(_currentState?.isSoundEnabled ?? true)) {
      return;
    }

    try {
      await _soundPlayer?.stop();
      await _soundPlayer?.setAsset(assetPath);
      await _soundPlayer?.setVolume(_currentState?.soundVolume ?? 1.0);
      await _soundPlayer?.play();
      debugPrint('✅ Playing sound: $assetPath');
    } catch (e) {
      debugPrint('❌ Failed to play sound asset $assetPath: $e');
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
    await _playAsset('assets/audio/win.mp3');
  }

  Future<void> playBadResultSound() async {
    await _playAsset('assets/audio/bad.mp3');
  }

  // Background music methods
  Future<void> startBackgroundMusic() async {
    if (_isDisposed) return;
    
    if (!_isInitialized) {
      await initialize();
    }

    if (!(_isInitialized)) {
      debugPrint('❌ Cannot start music: AudioService not initialized');
      return;
    }

    if (!(_currentState?.isBackgroundMusicEnabled ?? true) || _isAppPaused) {
      return;
    }

    if (_isMusicPlaying || _musicPlayer?.playerState.playing == true) {
      return;
    }

    try {
      await _musicPlayer?.setAsset('assets/audio/background.mp3');
      await _musicPlayer?.setVolume(_currentState?.musicVolume ?? 0.5);
      await _musicPlayer?.play();
      _isMusicPlaying = true;
      debugPrint('✅ Background music started');
    } catch (e) {
      _isMusicPlaying = false;
      debugPrint('❌ Failed to start background music: $e');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer?.stop();
      _isMusicPlaying = false;
      debugPrint('⏹️ Background music stopped');
    } catch (e) {
      debugPrint('❌ Failed to stop background music: $e');
    }
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      await _musicPlayer?.pause();
      _isMusicPlaying = false;
      debugPrint('⏸️ Background music paused');
    } catch (e) {
      debugPrint('❌ Failed to pause background music: $e');
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (_isDisposed || _isAppPaused) return;
    
    if (_currentState?.isBackgroundMusicEnabled ?? true) {
      try {
        await _musicPlayer?.play();
        _isMusicPlaying = true;
        debugPrint('▶️ Background music resumed');
      } catch (e) {
        debugPrint('❌ Failed to resume background music: $e');
        await startBackgroundMusic();
      }
    }
  }

  /// Update music volume without restarting playback
  Future<void> updateMusicVolume(double volume) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      await _musicPlayer?.setVolume(clampedVolume);
      debugPrint('🔊 Music volume updated to: $clampedVolume');
    } catch (e) {
      debugPrint('❌ Failed to update music volume: $e');
    }
  }

  /// Update sound effects volume
  Future<void> updateSoundVolume(double volume) async {
    if (!_isInitialized) {
      await initialize();
    }
    
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      await _soundPlayer?.setVolume(clampedVolume);
      debugPrint('🔊 Sound volume updated to: $clampedVolume');
    } catch (e) {
      debugPrint('❌ Failed to update sound volume: $e');
    }
  }

  Future<void> stopAllSounds() async {
    try {
      await _soundPlayer?.stop();
      await _musicPlayer?.stop();
      _isMusicPlaying = false;
      debugPrint('⏹️ All sounds stopped');
    } catch (e) {
      debugPrint('❌ Error stopping all sounds: $e');
    }
  }

  @mustCallSuper
  void dispose() {
    if (_isDisposed) return;
    
    WidgetsBinding.instance.removeObserver(this);
    
    try {
      _soundPlayer?.dispose();
      _musicPlayer?.dispose();
      debugPrint('✅ AudioService disposed');
    } catch (e) {
      debugPrint('❌ Error disposing audio players: $e');
    } finally {
      _soundPlayer = null;
      _musicPlayer = null;
      _isInitialized = false;
      _isMusicPlaying = false;
      _isDisposed = true;
    }
  }
}