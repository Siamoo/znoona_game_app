part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    // Theme
    required bool isDarkMode,
    
    // Language
    required Locale locale,
    
    // Audio Settings
    required bool isSoundEnabled,
    required bool isVibrationEnabled,
    required bool isBackgroundMusicEnabled,
    required double soundVolume,
    required double musicVolume,
  }) = _AppState;

  // Factory for initial state
  factory AppState.initial() => const AppState(
    isDarkMode: false,
    locale: Locale('en'),
    isSoundEnabled: true,
    isVibrationEnabled: true, 
    isBackgroundMusicEnabled: true,
    soundVolume: 1.0,
    musicVolume: 0.5,
  );
}