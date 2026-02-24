import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logger/logger.dart';
import 'package:medaan_almaarifa/core/app/app_cubit/app_cubit.dart';

class AudioService with WidgetsBindingObserver {
  factory AudioService() => _instance;
  AudioService._internal();
  static final AudioService _instance = AudioService._internal();

  AudioPlayer? _soundPlayer;
  AudioPlayer? _musicPlayer;
  final Logger _logger = Logger();
  
  bool _isInitialized = false;
  AppState? _currentState;
  // Add to AudioService class
bool get isBackgroundMusicEnabled => _currentState?.isBackgroundMusicEnabled ?? true;
  
  // Track lifecycle state
  bool _isAppPaused = false;
  bool _isDisposed = false;
  
  // Stream subscriptions for cleanup
  StreamSubscription<PlaybackEvent>? _soundEventSubscription;
  StreamSubscription<PlaybackEvent>? _musicEventSubscription;
  StreamSubscription<PlayerState>? _soundStateSubscription;
  StreamSubscription<PlayerState>? _musicStateSubscription;
  
  // Audio session
  AudioSession? _audioSession;
  
  // Cache for asset readiness
  bool _backgroundMusicReady = false;
  
  // Getter for state
  bool get isInitialized => _isInitialized;
  bool get isMusicPlaying => _musicPlayer?.playing ?? false;

  Future<void> initialize() async {
    if (_isInitialized || _isDisposed) return;

    try {
      // Add lifecycle observer
      WidgetsBinding.instance.addObserver(this);
      
      // Configure audio session for better audio handling
      _audioSession = await AudioSession.instance;
      await _audioSession!.configure(const AudioSessionConfiguration.music());
      
      // Activate audio session
      await _audioSession!.setActive(true);

      // Initialize audio players with error handling
      _soundPlayer = AudioPlayer();
      _musicPlayer = AudioPlayer();

      // Set up listeners with proper cleanup
      _setupPlayerListeners();

      // Set up music player
      await _musicPlayer!.setLoopMode(LoopMode.all);
      await _musicPlayer!.setVolume(0.5);

      // Preload background music
      await _preloadBackgroundMusic();

      _isInitialized = true;
      _logger.i('✅ AudioService initialized successfully');

      // Apply any pending state
      if (_currentState != null) {
        _applyStateToPlayers(_currentState!);
      }
    } catch (e, stackTrace) {
      _logger.e('❌ Failed to initialize AudioService', error: e, stackTrace: stackTrace);
      _isInitialized = false;
      await _cleanup();
    }
  }

  void _setupPlayerListeners() {
    // Sound player listeners
    _soundEventSubscription = _soundPlayer?.playbackEventStream.listen(
      _handleSoundEvents,
      onError: (Object e) => _logger.e('Sound player error', error: e),
    );
    
    _soundStateSubscription = _soundPlayer?.playerStateStream.listen(
      (state) => _logger.d('Sound state: ${state.playing}'),
      onError: (Object e) => _logger.e('Sound state error', error: e),
    );

    // Music player listeners
    _musicEventSubscription = _musicPlayer?.playbackEventStream.listen(
      _handleMusicEvents,
      onError: (Object e) => _logger.e('Music player error', error: e),
    );
    
    _musicStateSubscription = _musicPlayer?.playerStateStream.listen(
      (state) {
        _logger.d('Music state: ${state.playing}');
        if (state.processingState == ProcessingState.completed) {
          _logger.d('Music completed, restarting');
          _musicPlayer?.seek(Duration.zero);
          if (_currentState?.isBackgroundMusicEnabled ?? false) {
            _musicPlayer?.play();
          }
        }
      },
      onError: (Object e) => _logger.e('Music state error', error: e),
    );
  }

  Future<void> _preloadBackgroundMusic() async {
    try {
      await _musicPlayer!.setAsset('assets/audio/background.mp3');
      _backgroundMusicReady = true;
      _logger.i('✅ Background music preloaded');
    } catch (e) {
      _backgroundMusicReady = false;
      _logger.w('⚠️ Could not preload background music: $e');
    }
  }

  void _handleSoundEvents(PlaybackEvent event) {
    // Handle sound events if needed
  }

  void _handleMusicEvents(PlaybackEvent event) {
    // Handle music events if needed
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_isDisposed) return;
    
    switch (state) {
      case AppLifecycleState.paused:
        _isAppPaused = true;
        pauseBackgroundMusic();
      case AppLifecycleState.resumed:
        _isAppPaused = false;
        resumeBackgroundMusic();
      case AppLifecycleState.detached:
        dispose();
      case AppLifecycleState.inactive:
        // App is inactive (e.g., phone call)
        pauseBackgroundMusic();
      default:
        break;
    }
  }

  void onAppStateChanged(AppState state) {
    _currentState = state;
    if (_isInitialized && !_isDisposed) {
      _applyStateToPlayers(state);
    }
  }

  Future<void> _applyStateToPlayers(AppState state) async {
    try {
      // Update volumes
      await _soundPlayer?.setVolume(state.soundVolume);
      await _musicPlayer?.setVolume(state.musicVolume);
      
      // Handle music playback based on state
      if (state.isBackgroundMusicEnabled && !_isAppPaused) {
        await startBackgroundMusic();
      } else {
        await pauseBackgroundMusic();
      }
    } catch (e) {
      _logger.e('Error applying state to players', error: e);
    }
  }

  Future<void> _playAsset(String assetPath) async {
    if (_isDisposed) return;
    
    if (!_isInitialized) {
      await initialize();
    }
    
    if (!(_currentState?.isSoundEnabled ?? true) || _isAppPaused) {
      return;
    }

    try {
      await _soundPlayer?.stop();
      await _soundPlayer?.setAsset(assetPath);
      await _soundPlayer?.setVolume(_currentState?.soundVolume ?? 1.0);
      await _soundPlayer?.play();
    } catch (e) {
      _logger.e('❌ Failed to play sound asset $assetPath', error: e);
    }
  }

  // Public sound methods
  Future<void> playCorrectSound() => _playAsset('assets/audio/correct.mp3');
  Future<void> playWrongSound() => _playAsset('assets/audio/wrong.mp3');
  Future<void> playTimerWarningSound() => _playAsset('assets/audio/timer_warning.mp3');
  Future<void> playTimerCriticalSound() => _playAsset('assets/audio/timer_critical.mp3');
  Future<void> playWinSound() => _playAsset('assets/audio/win.mp3');
  Future<void> playGoodResultSound() => _playAsset('assets/audio/good.mp3');
  Future<void> playBadResultSound() => _playAsset('assets/audio/bad.mp3');

  Future<void> startBackgroundMusic() async {
    if (_isDisposed || _isAppPaused) return;
    
    if (!_isInitialized) {
      await initialize();
    }

    if (!_isInitialized || !_backgroundMusicReady) {
      return;
    }

    if (_musicPlayer?.playing ?? false) return;

    try {
      if (!_backgroundMusicReady) {
        await _musicPlayer!.setAsset('assets/audio/background.mp3');
        _backgroundMusicReady = true;
      }
      await _musicPlayer!.setVolume(_currentState?.musicVolume ?? 0.5);
      await _musicPlayer!.play();
      _logger.i('✅ Background music started');
    } catch (e) {
      _logger.e('❌ Failed to start background music', error: e);
    }
  }

  Future<void> pauseBackgroundMusic() async {
    try {
      await _musicPlayer?.pause();
      _logger.i('⏸️ Background music paused');
    } catch (e) {
      _logger.e('❌ Failed to pause background music', error: e);
    }
  }

  Future<void> resumeBackgroundMusic() async {
    if (_isDisposed || _isAppPaused) return;
    
    if (_currentState?.isBackgroundMusicEnabled ?? false) {
      try {
        await _musicPlayer?.play();
        _logger.i('▶️ Background music resumed');
      } catch (e) {
        _logger.e('❌ Failed to resume background music', error: e);
        await startBackgroundMusic();
      }
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer?.stop();
      _logger.i('⏹️ Background music stopped');
    } catch (e) {
      _logger.e('❌ Failed to stop background music', error: e);
    }
  }

  Future<void> updateMusicVolume(double volume) async {
    if (_isDisposed) return;
    
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      await _musicPlayer?.setVolume(clampedVolume);
    } catch (e) {
      _logger.e('❌ Failed to update music volume', error: e);
    }
  }

  Future<void> updateSoundVolume(double volume) async {
    if (_isDisposed) return;
    
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      await _soundPlayer?.setVolume(clampedVolume);
    } catch (e) {
      _logger.e('❌ Failed to update sound volume', error: e);
    }
  }

  Future<void> stopAllSounds() async {
    try {
      await _soundPlayer?.stop();
      await _musicPlayer?.stop();
      _logger.i('⏹️ All sounds stopped');
    } catch (e) {
      _logger.e('❌ Error stopping all sounds', error: e);
    }
  }

  Future<void> _cleanup() async {
    // Cancel all subscriptions
    await _soundEventSubscription?.cancel();
    await _musicEventSubscription?.cancel();
    await _soundStateSubscription?.cancel();
    await _musicStateSubscription?.cancel();
    
    // Dispose players
    await _soundPlayer?.dispose();
    await _musicPlayer?.dispose();
    
    // Deactivate audio session
    await _audioSession?.setActive(false);
    
    // Clear references
    _soundPlayer = null;
    _musicPlayer = null;
    _audioSession = null;
    _soundEventSubscription = null;
    _musicEventSubscription = null;
    _soundStateSubscription = null;
    _musicStateSubscription = null;
  }

  @mustCallSuper
  void dispose() {
    if (_isDisposed) return;
    
    _isDisposed = true;
    WidgetsBinding.instance.removeObserver(this);
    
    _cleanup().then((_) {
      _isInitialized = false;
      _logger.i('✅ AudioService disposed');
    }).catchError((Object e) {
      _logger.e('❌ Error during AudioService disposal', error: e);
    });
  }
}