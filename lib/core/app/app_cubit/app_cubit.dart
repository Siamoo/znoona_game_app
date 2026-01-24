import 'dart:ui';

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
    final isSoundEnabled = SharedPref().getBoolean(PrefKeys.soundEnabled) ?? true;
    final isVibrationEnabled = SharedPref().getBoolean(PrefKeys.vibrationEnabled) ?? true;
    final isBackgroundMusicEnabled = 
        SharedPref().getBoolean(PrefKeys.backgroundMusicEnabled) ?? true;
    final soundVolume = SharedPref().getDouble(PrefKeys.soundVolume) ?? 1.0;
    final musicVolume = SharedPref().getDouble(PrefKeys.musicVolume) ?? 0.5;

    final loadedState = AppState(
      isDarkMode: isDarkMode,
      locale: Locale(languageCode),
      isSoundEnabled: isSoundEnabled,
      isVibrationEnabled: isVibrationEnabled,
      isBackgroundMusicEnabled: isBackgroundMusicEnabled,
      soundVolume: soundVolume,
      musicVolume: musicVolume,
    );
    
    emit(loadedState);
  }

  /// Toggle vibration feedback
  Future<void> toggleVibration() async {
    final newValue = !state.isVibrationEnabled;
    await SharedPref().setBoolean(PrefKeys.vibrationEnabled, newValue);
    emit(state.copyWith(isVibrationEnabled: newValue));
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newMode = !state.isDarkMode;
    await SharedPref().setBoolean(PrefKeys.themeMode, newMode);
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

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    await SharedPref().removePreference(PrefKeys.themeMode);
    await SharedPref().removePreference(PrefKeys.language);
    await SharedPref().removePreference(PrefKeys.soundEnabled);
    await SharedPref().removePreference(PrefKeys.vibrationEnabled);
    await SharedPref().removePreference(PrefKeys.backgroundMusicEnabled);
    await SharedPref().removePreference(PrefKeys.soundVolume);
    await SharedPref().removePreference(PrefKeys.musicVolume);
    
    await _loadSettings();
    _audioService.onAppStateChanged(state);
  }
}