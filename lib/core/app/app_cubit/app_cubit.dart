import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/core/di/injcetion_container.dart';
import 'package:medaan_almaarifa/core/helpers/audio_service.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/pref_keys.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial()) {
    _loadSettings();
  }

  // Add AudioService instance
  final AudioService _audioService = sl<AudioService>();

  /// Load all settings from SharedPreferences
  Future<void> _loadSettings() async {
    final isDarkMode = SharedPref().getBoolean(PrefKeys.themeMode) ?? false;
    final languageCode = SharedPref().getString(PrefKeys.language) ?? 'en';
    final isSoundEnabled =
        SharedPref().getBoolean(PrefKeys.soundEnabled) ?? true;
    final isBackgroundMusicEnabled =
        SharedPref().getBoolean(PrefKeys.backgroundMusicEnabled) ?? true;
    final soundVolume = SharedPref().getDouble(PrefKeys.soundVolume) ?? 1.0;
    final musicVolume = SharedPref().getDouble(PrefKeys.musicVolume) ?? 0.5;

    // Load animation settings
    final animationCurveString =
        SharedPref().getString(PrefKeys.animationCurve) ?? 'easeInOut';
    final animationDurationMs =
        SharedPref().getInt(PrefKeys.animationDuration) ?? 500;

    final loadedState = AppState(
      isDarkMode: isDarkMode,
      locale: Locale(languageCode),
      isSoundEnabled: isSoundEnabled,
      isBackgroundMusicEnabled: isBackgroundMusicEnabled,
      soundVolume: soundVolume,
      musicVolume: musicVolume,
      animationCurve: _getCurveFromString(animationCurveString),
      animationDuration: Duration(milliseconds: animationDurationMs),
    );

    emit(loadedState);
  }

  /// Helper method to convert string to Curve
  Curve _getCurveFromString(String curveString) {
    switch (curveString) {
      case 'linear':
        return Curves.linear;
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'easeInOut':
        return Curves.easeInOut;
      case 'bounceIn':
        return Curves.bounceIn;
      case 'bounceOut':
        return Curves.bounceOut;
      case 'elasticIn':
        return Curves.elasticIn;
      case 'elasticOut':
        return Curves.elasticOut;
      default:
        return Curves.easeInOut;
    }
  }

  /// Helper method to convert Curve to string for storage
  String _getStringFromCurve(Curve curve) {
    if (curve == Curves.linear) return 'linear';
    if (curve == Curves.easeIn) return 'easeIn';
    if (curve == Curves.easeOut) return 'easeOut';
    if (curve == Curves.easeInOut) return 'easeInOut';
    if (curve == Curves.bounceIn) return 'bounceIn';
    if (curve == Curves.bounceOut) return 'bounceOut';
    if (curve == Curves.elasticIn) return 'elasticIn';
    if (curve == Curves.elasticOut) return 'elasticOut';
    return 'easeInOut';
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newMode = !state.isDarkMode;
    await SharedPref().setBoolean(PrefKeys.themeMode, newMode);

    print(
      'Switching theme with curve: ${_getStringFromCurve(state.animationCurve)}',
    );
    print('Duration: ${state.animationDuration.inMilliseconds}ms');

    // Small delay to ensure the animation system is ready

    emit(state.copyWith(isDarkMode: newMode));
  }

  /// Change app language
  Future<void> changeLanguage(String languageCode) async {
    await SharedPref().setString(PrefKeys.language, languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  void toArabic() => changeLanguage('ar');
  void toEnglish() => changeLanguage('en');

  /// Toggle sound effects
  Future<void> toggleSound() async {
    final newValue = !state.isSoundEnabled;
    await SharedPref().setBoolean(PrefKeys.soundEnabled, newValue);
    emit(state.copyWith(isSoundEnabled: newValue));
  }

  /// Toggle background music - with actual music control
  Future<void> toggleBackgroundMusic() async {
    final newValue = !state.isBackgroundMusicEnabled;

    try {
      // Save to preferences first
      await SharedPref().setBoolean(PrefKeys.backgroundMusicEnabled, newValue);

      // Update state immediately for UI feedback
      emit(state.copyWith(isBackgroundMusicEnabled: newValue));

      // Small delay to ensure state is updated
      await Future<dynamic>.delayed(const Duration(milliseconds: 100));

      // Then control the music
      if (newValue) {
        // User wants to turn music ON
        await _audioService.startBackgroundMusic();

        // Verify it's playing
        if (_audioService.isMusicActuallyPlaying) {
          // Music is playing
        } else {
          // Try one more time after a delay
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!_audioService.isMusicActuallyPlaying) {
              _audioService.startBackgroundMusic();
            }
          });
        }
      } else {
        // User wants to turn music OFF
        await _audioService.stopBackgroundMusic();
      }
    } catch (e) {
      // Handle error
    }
  }

  /// Update sound effects volume
  Future<void> setSoundVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    await SharedPref().setDouble(PrefKeys.soundVolume, clampedVolume);
    emit(state.copyWith(soundVolume: clampedVolume));
  }

  /// Update background music volume
  Future<void> setMusicVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    await SharedPref().setDouble(PrefKeys.musicVolume, clampedVolume);
    emit(state.copyWith(musicVolume: clampedVolume));
  }

  /// NEW: Set animation curve
  Future<void> setAnimationCurve(Curve curve) async {
    final curveString = _getStringFromCurve(curve);
    await SharedPref().setString(PrefKeys.animationCurve, curveString);
    emit(state.copyWith(animationCurve: curve));
  }

  /// NEW: Set animation duration
  Future<void> setAnimationDuration(Duration duration) async {
    await SharedPref().setInt(
      PrefKeys.animationDuration,
      duration.inMilliseconds,
    );
    emit(state.copyWith(animationDuration: duration));
  }

  /// NEW: Get available animation curves with display names
  List<Map<String, dynamic>> getAvailableAnimationCurves() {
    return [
      {
        'curve': Curves.linear,
        'name': 'Linear',
        'description': 'Constant speed',
      },
      {
        'curve': Curves.easeIn,
        'name': 'Ease In',
        'description': 'Slow start, fast end',
      },
      {
        'curve': Curves.easeOut,
        'name': 'Ease Out',
        'description': 'Fast start, slow end',
      },
      {
        'curve': Curves.easeInOut,
        'name': 'Ease In Out',
        'description': 'Slow start and end, fast middle',
      },
      {
        'curve': Curves.bounceIn,
        'name': 'Bounce In',
        'description': 'Bounces at start',
      },
      {
        'curve': Curves.bounceOut,
        'name': 'Bounce Out',
        'description': 'Bounces at end',
      },
      {
        'curve': Curves.elasticIn,
        'name': 'Elastic In',
        'description': 'Elastic effect at start',
      },
      {
        'curve': Curves.elasticOut,
        'name': 'Elastic Out',
        'description': 'Elastic effect at end',
      },
      {
        'curve': Curves.decelerate,
        'name': 'Decelerate',
        'description': 'Gradually slows down',
      },
      {
        'curve': Curves.fastOutSlowIn,
        'name': 'Fast Out Slow In',
        'description': 'Material Design standard',
      },
    ];
  }

  /// NEW: Get available animation durations
  List<Map<String, dynamic>> getAvailableAnimationDurations() {
    return [
      {
        'duration': const Duration(milliseconds: 200),
        'name': 'Very Fast',
        'ms': 200,
      },
      {
        'duration': const Duration(milliseconds: 300),
        'name': 'Fast',
        'ms': 300,
      },
      {
        'duration': const Duration(milliseconds: 500),
        'name': 'Normal',
        'ms': 500,
      },
      {
        'duration': const Duration(milliseconds: 800),
        'name': 'Slow',
        'ms': 800,
      },
      {
        'duration': const Duration(milliseconds: 1000),
        'name': 'Very Slow',
        'ms': 1000,
      },
    ];
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    await SharedPref().removePreference(PrefKeys.themeMode);
    await SharedPref().removePreference(PrefKeys.language);
    await SharedPref().removePreference(PrefKeys.soundEnabled);
    await SharedPref().removePreference(PrefKeys.backgroundMusicEnabled);
    await SharedPref().removePreference(PrefKeys.soundVolume);
    await SharedPref().removePreference(PrefKeys.musicVolume);
    await SharedPref().removePreference(PrefKeys.animationCurve);
    await SharedPref().removePreference(PrefKeys.animationDuration);

    await _loadSettings();
    _audioService.onAppStateChanged(state);
  }
}
