import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/pref_keys.dart';
import 'package:medaan_almaarifa/core/service/shared_pref/shared_pref.dart';

part 'app_state.dart';
part 'app_cubit.freezed.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial()) {
    // Load settings when cubit is created
    _loadSettings();
  }

  /// Load all settings from SharedPreferences
  Future<void> _loadSettings() async {
    // Load from SharedPreferences
    final isDarkMode = SharedPref().getBoolean(PrefKeys.themeMode) ?? false;
    final languageCode = SharedPref().getString(PrefKeys.language) ?? 'en';
    final isSoundEnabled = SharedPref().getBoolean(PrefKeys.soundEnabled) ?? true;
    final isBackgroundMusicEnabled = 
        SharedPref().getBoolean(PrefKeys.backgroundMusicEnabled) ?? true;
    final soundVolume = SharedPref().getDouble(PrefKeys.soundVolume) ?? 1.0;
    final musicVolume = SharedPref().getDouble(PrefKeys.musicVolume) ?? 0.5;

    // Emit the loaded state
    final loadedState = AppState(
      isDarkMode: isDarkMode,
      locale: Locale(languageCode),
      isSoundEnabled: isSoundEnabled,
      isBackgroundMusicEnabled: isBackgroundMusicEnabled,
      soundVolume: soundVolume,
      musicVolume: musicVolume,
    );
    
    emit(loadedState);
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final newMode = !state.isDarkMode;
    
    // Save to preferences
    await SharedPref().setBoolean(PrefKeys.themeMode, newMode);
    
    // Update state
    emit(state.copyWith(isDarkMode: newMode));
  }

  /// Change app language
  Future<void> changeLanguage(String languageCode) async {
    // Save to preferences
    await SharedPref().setString(PrefKeys.language, languageCode);
    
    // Update state
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  /// Convenience methods for specific languages
  void toArabic() => changeLanguage('ar');
  void toEnglish() => changeLanguage('en');

  /// Toggle sound effects
  Future<void> toggleSound() async {
    final newValue = !state.isSoundEnabled;
    
    await SharedPref().setBoolean(PrefKeys.soundEnabled, newValue);
    emit(state.copyWith(isSoundEnabled: newValue));
  }

  /// Toggle background music
  Future<void> toggleBackgroundMusic() async {
    final newValue = !state.isBackgroundMusicEnabled;
    
    await SharedPref().setBoolean(PrefKeys.backgroundMusicEnabled, newValue);
    emit(state.copyWith(isBackgroundMusicEnabled: newValue));
  }

  /// Update sound effects volume (0.0 to 1.0)
  Future<void> setSoundVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    
    await SharedPref().setDouble(PrefKeys.soundVolume, clampedVolume);
    emit(state.copyWith(soundVolume: clampedVolume));
  }

  /// Update background music volume (0.0 to 1.0)
  Future<void> setMusicVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    
    await SharedPref().setDouble(PrefKeys.musicVolume, clampedVolume);
    emit(state.copyWith(musicVolume: clampedVolume));
  }

  /// Reset all settings to defaults
  Future<void> resetToDefaults() async {
    // Clear all preferences
    await SharedPref().removePreference(PrefKeys.themeMode);
    await SharedPref().removePreference(PrefKeys.language);
    await SharedPref().removePreference(PrefKeys.soundEnabled);
    await SharedPref().removePreference(PrefKeys.backgroundMusicEnabled);
    await SharedPref().removePreference(PrefKeys.soundVolume);
    await SharedPref().removePreference(PrefKeys.musicVolume);
    
    // Load defaults
    await _loadSettings();
  }
}