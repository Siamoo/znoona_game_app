import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/pref_keys.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit({
    required SharedPref sharedPref,
    required AudioService audioService,
    Logger? logger,
  })  : _sharedPref = sharedPref,
        _audioService = audioService,
        _logger = logger ?? Logger(),
        super(AppState.initial()) {
    _initialize();
  }
  final SharedPref _sharedPref;
  final AudioService _audioService;
  final Logger _logger;
  
  // Debouncer for frequent operations
  Timer? _debounceTimer;
  
  // Throttle for very frequent operations
  DateTime? _lastSaveTime;
  static const Duration _saveThrottleDuration = Duration(milliseconds: 200);
  
  // Batch updates
  final List<Future<void> Function()> _pendingOperations = [];
  Timer? _batchTimer;
  
  // Cache for preferences
  final Map<String, dynamic> _prefCache = {};
  
  // Track loading state
  bool _isLoading = false;
  bool _isInitialized = false;

  Future<void> _initialize() async {
    if (_isInitialized) return;
    await _loadSettings();
    _isInitialized = true;
  }

  Future<void> _loadSettings() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      // Load all preferences in parallel with timeout
      final results = await Future.wait([
        _loadWithTimeout(_loadThemeMode),
        _loadWithTimeout(_loadLanguage),
        _loadWithTimeout(_loadSoundEnabled),
        _loadWithTimeout(_loadBackgroundMusicEnabled),
        _loadWithTimeout(_loadSoundVolume),
        _loadWithTimeout(_loadMusicVolume),
      ]).timeout(
        const Duration(seconds: 3),
        onTimeout: _getDefaultValues,
      );

      final themeMode = results[0] as bool;
      final languageCode = results[1] as String;
      final isSoundEnabled = results[2] as bool;
      final isBackgroundMusicEnabled = results[3] as bool;
      final soundVolume = results[4] as double;
      final musicVolume = results[5] as double;

      // Update cache
      _updateCache({
        PrefKeys.themeMode: themeMode,
        PrefKeys.language: languageCode,
        PrefKeys.soundEnabled: isSoundEnabled,
        PrefKeys.backgroundMusicEnabled: isBackgroundMusicEnabled,
        PrefKeys.soundVolume: soundVolume,
        PrefKeys.musicVolume: musicVolume,
      });

      final loadedState = AppState(
        isDarkMode: themeMode,
        locale: Locale(languageCode),
        isSoundEnabled: isSoundEnabled,
        isBackgroundMusicEnabled: isBackgroundMusicEnabled,
        soundVolume: soundVolume,
        musicVolume: musicVolume,
      );

      if (!isClosed) {
        emit(loadedState);
        _audioService.onAppStateChanged(loadedState);
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to load app settings', error: e, stackTrace: stackTrace);
      
      if (!isClosed) {
        emit(AppState.initial());
        _audioService.onAppStateChanged(AppState.initial());
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<dynamic> _loadWithTimeout(Future<dynamic> Function() loader) async {
    try {
      return await loader().timeout(const Duration(seconds: 1));
    } catch (e) {
      return null;
    }
  }

  List<dynamic> _getDefaultValues() {
    return [
      true, // themeMode
      'ar', // language
      true, // soundEnabled
      true, // backgroundMusicEnabled
      1.0,  // soundVolume
      0.5,  // musicVolume
    ];
  }

  Future<bool> _loadThemeMode() async {
    final value = _sharedPref.getBoolean(PrefKeys.themeMode);
    return value ?? true;
  }

  Future<String> _loadLanguage() async {
    final value = _sharedPref.getString(PrefKeys.language);
    return value ?? 'ar';
  }

  Future<bool> _loadSoundEnabled() async {
    final value = _sharedPref.getBoolean(PrefKeys.soundEnabled);
    return value ?? true;
  }

  Future<bool> _loadBackgroundMusicEnabled() async {
    final value = _sharedPref.getBoolean(PrefKeys.backgroundMusicEnabled);
    return value ?? true;
  }

  Future<double> _loadSoundVolume() async {
    final value = _sharedPref.getDouble(PrefKeys.soundVolume);
    return value?.clamp(0.0, 1.0) ?? 1.0;
  }

  Future<double> _loadMusicVolume() async {
    final value = _sharedPref.getDouble(PrefKeys.musicVolume);
    return value?.clamp(0.0, 1.0) ?? 0.5;
  }

  void _updateCache(Map<String, dynamic> values) {
    _prefCache.addAll(values);
  }

  Future<void> _saveWithThrottle(String key, Future<bool> Function() saveOp) async {
    final now = DateTime.now();
    
    if (_lastSaveTime == null || 
        now.difference(_lastSaveTime!) > _saveThrottleDuration) {
      // Execute immediately
      _lastSaveTime = now;
      try {
        await saveOp();
      } catch (e) {
        _logger.e('Failed to save $key', error: e);
      }
    } else {
      // Queue for later
      _pendingOperations.add(() async {
        try {
          await saveOp();
        } catch (e) {
          _logger.e('Failed to save $key (queued)', error: e);
        }
      });
      
      // Schedule batch processing
      _batchTimer ??= Timer(_saveThrottleDuration, _processBatch);
    }
  }

  Future<void> _processBatch() async {
    final operations = List<dynamic>.from(_pendingOperations);
    _pendingOperations.clear();
    _batchTimer = null;
    
    for (final op in operations) {
      await op();
    }
  }

  // Public methods with optimized saving
  Future<void> toggleTheme() async {
    try {
      final newMode = !state.isDarkMode;
      
      // Update UI immediately
      if (!isClosed) {
        emit(state.copyWith(isDarkMode: newMode));
      }
      
      // Save with throttling
      unawaited(_saveWithThrottle(
        PrefKeys.themeMode,
        () => _sharedPref.setBoolean(PrefKeys.themeMode, newMode),
      ));
      
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle theme', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      if (!isClosed) {
        emit(state.copyWith(locale: Locale(languageCode)));
      }
      
      unawaited(_saveWithThrottle(
        PrefKeys.language,
        () => _sharedPref.setString(PrefKeys.language, languageCode),
      ));
      
    } catch (e, stackTrace) {
      _logger.e('Failed to change language', error: e, stackTrace: stackTrace);
    }
  }

  void toArabic() => changeLanguage('ar');
  void toEnglish() => changeLanguage('en');

  Future<void> toggleSound() async {
    try {
      final newValue = !state.isSoundEnabled;
      
      if (!isClosed) {
        emit(state.copyWith(isSoundEnabled: newValue));
      }
      
      unawaited(_saveWithThrottle(
        PrefKeys.soundEnabled,
        () => _sharedPref.setBoolean(PrefKeys.soundEnabled, newValue),
      ));
      
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle sound', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> toggleBackgroundMusic() async {
    try {
      final newValue = !state.isBackgroundMusicEnabled;

      if (!isClosed) {
        emit(state.copyWith(isBackgroundMusicEnabled: newValue));
      }

      // Save with throttling
      unawaited(_saveWithThrottle(
        PrefKeys.backgroundMusicEnabled,
        () => _sharedPref.setBoolean(PrefKeys.backgroundMusicEnabled, newValue),
      ));

      // Handle audio
      if (newValue) {
        await _audioService.startBackgroundMusic();
      } else {
        await _audioService.stopBackgroundMusic();
      }
      
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle background music', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> setSoundVolume(double volume) async {
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      
      // Update UI immediately
      if (!isClosed) {
        emit(state.copyWith(soundVolume: clampedVolume));
      }
      
      // Debounce the audio update
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 50), () async {
        await _audioService.updateSoundVolume(clampedVolume);
      });
      
      // Save with throttling
      unawaited(_saveWithThrottle(
        PrefKeys.soundVolume,
        () => _sharedPref.setDouble(PrefKeys.soundVolume, clampedVolume),
      ));
      
    } catch (e, stackTrace) {
      _logger.e('Failed to set sound volume', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> setMusicVolume(double volume) async {
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      
      // Update UI immediately
      if (!isClosed) {
        emit(state.copyWith(musicVolume: clampedVolume));
      }
      
      // Debounce the audio update
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 50), () async {
        await _audioService.updateMusicVolume(clampedVolume);
      });
      
      // Save with throttling
      unawaited(_saveWithThrottle(
        PrefKeys.musicVolume,
        () => _sharedPref.setDouble(PrefKeys.musicVolume, clampedVolume),
      ));
      
    } catch (e, stackTrace) {
      _logger.e('Failed to set music volume', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> resetToDefaults() async {
    try {
      // Clear all preferences
      await Future.wait([
        _sharedPref.remove(PrefKeys.themeMode),
        _sharedPref.remove(PrefKeys.language),
        _sharedPref.remove(PrefKeys.soundEnabled),
        _sharedPref.remove(PrefKeys.backgroundMusicEnabled),
        _sharedPref.remove(PrefKeys.soundVolume),
        _sharedPref.remove(PrefKeys.musicVolume),
      ]);

      // Clear cache
      _prefCache.clear();
      
      // Reload settings
      await _loadSettings();
      
    } catch (e, stackTrace) {
      _logger.e('Failed to reset settings', error: e, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _batchTimer?.cancel();
    _pendingOperations.clear();
    return super.close();
  }
}