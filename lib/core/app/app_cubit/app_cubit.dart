import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/pref_keys.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  final SharedPref _sharedPref;
  final AudioService _audioService;
  final Logger _logger;
  
  // Debouncer for frequent operations
  Timer? _debounceTimer;
  bool _isLoading = false;
  
  // Cache for preferences to reduce disk reads
  final Map<String, dynamic> _prefCache = {};

  AppCubit({
    required SharedPref sharedPref,
    required AudioService audioService,
    Logger? logger,
  })  : _sharedPref = sharedPref,
        _audioService = audioService,
        _logger = logger ?? Logger(),
        super(AppState.initial()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    // Prevent multiple simultaneous loads
    if (_isLoading) return;
    _isLoading = true;

    try {
      // Load all preferences with proper fallbacks
      final loadTasks = await Future.wait([
        _loadThemeMode(),
        _loadLanguage(),
        _loadSoundEnabled(),
        _loadBackgroundMusicEnabled(),
        _loadSoundVolume(),
        _loadMusicVolume(),
      ]);

      final themeMode = loadTasks[0] as bool;
      final languageCode = loadTasks[1] as String;
      final isSoundEnabled = loadTasks[2] as bool;
      final isBackgroundMusicEnabled = loadTasks[3] as bool;
      final soundVolume = loadTasks[4] as double;
      final musicVolume = loadTasks[5] as double;

      // Cache loaded values
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
      
      // Emit initial state as fallback
      if (!isClosed) {
        emit(AppState.initial());
        _audioService.onAppStateChanged(AppState.initial());
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> _loadThemeMode() async {
    final value = _sharedPref.getBoolean(PrefKeys.themeMode);
    return value ?? true; // Default to dark mode
  }

  Future<String> _loadLanguage() async {
    final value = _sharedPref.getString(PrefKeys.language);
    return value ?? 'ar'; // Default to Arabic
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

  // T? _getFromCache<T>(String key) {
  //   return _prefCache[key] as T?;
  // }

  Future<void> toggleTheme() async {
    try {
      final newMode = !state.isDarkMode;
      
      // Update cache first for immediate response
      _updateCache({PrefKeys.themeMode: newMode});
      
      // Save to preferences (don't await to avoid blocking UI)
      unawaited(_sharedPref.setBoolean(PrefKeys.themeMode, newMode));
      
      if (!isClosed) {
        emit(state.copyWith(isDarkMode: newMode));
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle theme', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    try {
      _updateCache({PrefKeys.language: languageCode});
      unawaited(_sharedPref.setString(PrefKeys.language, languageCode));
      
      if (!isClosed) {
        emit(state.copyWith(locale: Locale(languageCode)));
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to change language', error: e, stackTrace: stackTrace);
    }
  }

  void toArabic() => changeLanguage('ar');
  void toEnglish() => changeLanguage('en');

  Future<void> toggleSound() async {
    try {
      final newValue = !state.isSoundEnabled;
      
      _updateCache({PrefKeys.soundEnabled: newValue});
      unawaited(_sharedPref.setBoolean(PrefKeys.soundEnabled, newValue));
      
      if (!isClosed) {
        emit(state.copyWith(isSoundEnabled: newValue));
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to toggle sound', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> toggleBackgroundMusic() async {
    try {
      final newValue = !state.isBackgroundMusicEnabled;

      _updateCache({PrefKeys.backgroundMusicEnabled: newValue});
      await _sharedPref.setBoolean(PrefKeys.backgroundMusicEnabled, newValue);

      if (!isClosed) {
        emit(state.copyWith(isBackgroundMusicEnabled: newValue));
      }

      // Small delay to ensure state is updated
      await Future<dynamic>.delayed(const Duration(milliseconds: 100));

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
      
      // Debounce rapid volume changes
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () async {
        _updateCache({PrefKeys.soundVolume: clampedVolume});
        await _sharedPref.setDouble(PrefKeys.soundVolume, clampedVolume);
        await _audioService.updateSoundVolume(clampedVolume);
      });
      
      if (!isClosed) {
        emit(state.copyWith(soundVolume: clampedVolume));
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to set sound volume', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> setMusicVolume(double volume) async {
    try {
      final clampedVolume = volume.clamp(0.0, 1.0);
      
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () async {
        _updateCache({PrefKeys.musicVolume: clampedVolume});
        await _sharedPref.setDouble(PrefKeys.musicVolume, clampedVolume);
        await _audioService.updateMusicVolume(clampedVolume);
      });
      
      if (!isClosed) {
        emit(state.copyWith(musicVolume: clampedVolume));
      }
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
    return super.close();
  }
}