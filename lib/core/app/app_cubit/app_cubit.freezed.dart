// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppState {
  // Theme
  bool get isDarkMode => throw _privateConstructorUsedError; // Language
  Locale get locale => throw _privateConstructorUsedError; // Audio Settings
  bool get isSoundEnabled => throw _privateConstructorUsedError;
  bool get isVibrationEnabled => throw _privateConstructorUsedError;
  bool get isBackgroundMusicEnabled => throw _privateConstructorUsedError;
  double get soundVolume => throw _privateConstructorUsedError;
  double get musicVolume => throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call({
    bool isDarkMode,
    Locale locale,
    bool isSoundEnabled,
    bool isVibrationEnabled,
    bool isBackgroundMusicEnabled,
    double soundVolume,
    double musicVolume,
  });
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? locale = null,
    Object? isSoundEnabled = null,
    Object? isVibrationEnabled = null,
    Object? isBackgroundMusicEnabled = null,
    Object? soundVolume = null,
    Object? musicVolume = null,
  }) {
    return _then(
      _value.copyWith(
            isDarkMode: null == isDarkMode
                ? _value.isDarkMode
                : isDarkMode // ignore: cast_nullable_to_non_nullable
                      as bool,
            locale: null == locale
                ? _value.locale
                : locale // ignore: cast_nullable_to_non_nullable
                      as Locale,
            isSoundEnabled: null == isSoundEnabled
                ? _value.isSoundEnabled
                : isSoundEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isVibrationEnabled: null == isVibrationEnabled
                ? _value.isVibrationEnabled
                : isVibrationEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBackgroundMusicEnabled: null == isBackgroundMusicEnabled
                ? _value.isBackgroundMusicEnabled
                : isBackgroundMusicEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            soundVolume: null == soundVolume
                ? _value.soundVolume
                : soundVolume // ignore: cast_nullable_to_non_nullable
                      as double,
            musicVolume: null == musicVolume
                ? _value.musicVolume
                : musicVolume // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
    _$AppStateImpl value,
    $Res Function(_$AppStateImpl) then,
  ) = __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isDarkMode,
    Locale locale,
    bool isSoundEnabled,
    bool isVibrationEnabled,
    bool isBackgroundMusicEnabled,
    double soundVolume,
    double musicVolume,
  });
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
    _$AppStateImpl _value,
    $Res Function(_$AppStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDarkMode = null,
    Object? locale = null,
    Object? isSoundEnabled = null,
    Object? isVibrationEnabled = null,
    Object? isBackgroundMusicEnabled = null,
    Object? soundVolume = null,
    Object? musicVolume = null,
  }) {
    return _then(
      _$AppStateImpl(
        isDarkMode: null == isDarkMode
            ? _value.isDarkMode
            : isDarkMode // ignore: cast_nullable_to_non_nullable
                  as bool,
        locale: null == locale
            ? _value.locale
            : locale // ignore: cast_nullable_to_non_nullable
                  as Locale,
        isSoundEnabled: null == isSoundEnabled
            ? _value.isSoundEnabled
            : isSoundEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isVibrationEnabled: null == isVibrationEnabled
            ? _value.isVibrationEnabled
            : isVibrationEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBackgroundMusicEnabled: null == isBackgroundMusicEnabled
            ? _value.isBackgroundMusicEnabled
            : isBackgroundMusicEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        soundVolume: null == soundVolume
            ? _value.soundVolume
            : soundVolume // ignore: cast_nullable_to_non_nullable
                  as double,
        musicVolume: null == musicVolume
            ? _value.musicVolume
            : musicVolume // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl({
    required this.isDarkMode,
    required this.locale,
    required this.isSoundEnabled,
    required this.isVibrationEnabled,
    required this.isBackgroundMusicEnabled,
    required this.soundVolume,
    required this.musicVolume,
  });

  // Theme
  @override
  final bool isDarkMode;
  // Language
  @override
  final Locale locale;
  // Audio Settings
  @override
  final bool isSoundEnabled;
  @override
  final bool isVibrationEnabled;
  @override
  final bool isBackgroundMusicEnabled;
  @override
  final double soundVolume;
  @override
  final double musicVolume;

  @override
  String toString() {
    return 'AppState(isDarkMode: $isDarkMode, locale: $locale, isSoundEnabled: $isSoundEnabled, isVibrationEnabled: $isVibrationEnabled, isBackgroundMusicEnabled: $isBackgroundMusicEnabled, soundVolume: $soundVolume, musicVolume: $musicVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.isSoundEnabled, isSoundEnabled) ||
                other.isSoundEnabled == isSoundEnabled) &&
            (identical(other.isVibrationEnabled, isVibrationEnabled) ||
                other.isVibrationEnabled == isVibrationEnabled) &&
            (identical(
                  other.isBackgroundMusicEnabled,
                  isBackgroundMusicEnabled,
                ) ||
                other.isBackgroundMusicEnabled == isBackgroundMusicEnabled) &&
            (identical(other.soundVolume, soundVolume) ||
                other.soundVolume == soundVolume) &&
            (identical(other.musicVolume, musicVolume) ||
                other.musicVolume == musicVolume));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isDarkMode,
    locale,
    isSoundEnabled,
    isVibrationEnabled,
    isBackgroundMusicEnabled,
    soundVolume,
    musicVolume,
  );

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState({
    required final bool isDarkMode,
    required final Locale locale,
    required final bool isSoundEnabled,
    required final bool isVibrationEnabled,
    required final bool isBackgroundMusicEnabled,
    required final double soundVolume,
    required final double musicVolume,
  }) = _$AppStateImpl;

  // Theme
  @override
  bool get isDarkMode; // Language
  @override
  Locale get locale; // Audio Settings
  @override
  bool get isSoundEnabled;
  @override
  bool get isVibrationEnabled;
  @override
  bool get isBackgroundMusicEnabled;
  @override
  double get soundVolume;
  @override
  double get musicVolume;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
