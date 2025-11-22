// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Profile {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError; // NEW FIELDS
  int get allCups => throw _privateConstructorUsedError;
  int get cupsByMonth => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get lastMonthReset => throw _privateConstructorUsedError;
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get gamesWon => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  double get averageScore => throw _privateConstructorUsedError;
  double get winRate => throw _privateConstructorUsedError;
  String? get bestCategory => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  DateTime? get lastPlayed => throw _privateConstructorUsedError;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileCopyWith<Profile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileCopyWith<$Res> {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) then) =
      _$ProfileCopyWithImpl<$Res, Profile>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String level,
    DateTime createdAt,
    String? avatarUrl,
    int allCups,
    int cupsByMonth,
    String? username,
    String? email,
    DateTime? lastMonthReset,
    int gamesPlayed,
    int gamesWon,
    int totalScore,
    double averageScore,
    double winRate,
    String? bestCategory,
    int streakDays,
    DateTime? lastPlayed,
  });
}

/// @nodoc
class _$ProfileCopyWithImpl<$Res, $Val extends Profile>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? level = null,
    Object? createdAt = null,
    Object? avatarUrl = freezed,
    Object? allCups = null,
    Object? cupsByMonth = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? lastMonthReset = freezed,
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? totalScore = null,
    Object? averageScore = null,
    Object? winRate = null,
    Object? bestCategory = freezed,
    Object? streakDays = null,
    Object? lastPlayed = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            allCups: null == allCups
                ? _value.allCups
                : allCups // ignore: cast_nullable_to_non_nullable
                      as int,
            cupsByMonth: null == cupsByMonth
                ? _value.cupsByMonth
                : cupsByMonth // ignore: cast_nullable_to_non_nullable
                      as int,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastMonthReset: freezed == lastMonthReset
                ? _value.lastMonthReset
                : lastMonthReset // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gamesPlayed: null == gamesPlayed
                ? _value.gamesPlayed
                : gamesPlayed // ignore: cast_nullable_to_non_nullable
                      as int,
            gamesWon: null == gamesWon
                ? _value.gamesWon
                : gamesWon // ignore: cast_nullable_to_non_nullable
                      as int,
            totalScore: null == totalScore
                ? _value.totalScore
                : totalScore // ignore: cast_nullable_to_non_nullable
                      as int,
            averageScore: null == averageScore
                ? _value.averageScore
                : averageScore // ignore: cast_nullable_to_non_nullable
                      as double,
            winRate: null == winRate
                ? _value.winRate
                : winRate // ignore: cast_nullable_to_non_nullable
                      as double,
            bestCategory: freezed == bestCategory
                ? _value.bestCategory
                : bestCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            streakDays: null == streakDays
                ? _value.streakDays
                : streakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            lastPlayed: freezed == lastPlayed
                ? _value.lastPlayed
                : lastPlayed // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileImplCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$$ProfileImplCopyWith(
    _$ProfileImpl value,
    $Res Function(_$ProfileImpl) then,
  ) = __$$ProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String level,
    DateTime createdAt,
    String? avatarUrl,
    int allCups,
    int cupsByMonth,
    String? username,
    String? email,
    DateTime? lastMonthReset,
    int gamesPlayed,
    int gamesWon,
    int totalScore,
    double averageScore,
    double winRate,
    String? bestCategory,
    int streakDays,
    DateTime? lastPlayed,
  });
}

/// @nodoc
class __$$ProfileImplCopyWithImpl<$Res>
    extends _$ProfileCopyWithImpl<$Res, _$ProfileImpl>
    implements _$$ProfileImplCopyWith<$Res> {
  __$$ProfileImplCopyWithImpl(
    _$ProfileImpl _value,
    $Res Function(_$ProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? level = null,
    Object? createdAt = null,
    Object? avatarUrl = freezed,
    Object? allCups = null,
    Object? cupsByMonth = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? lastMonthReset = freezed,
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? totalScore = null,
    Object? averageScore = null,
    Object? winRate = null,
    Object? bestCategory = freezed,
    Object? streakDays = null,
    Object? lastPlayed = freezed,
  }) {
    return _then(
      _$ProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        allCups: null == allCups
            ? _value.allCups
            : allCups // ignore: cast_nullable_to_non_nullable
                  as int,
        cupsByMonth: null == cupsByMonth
            ? _value.cupsByMonth
            : cupsByMonth // ignore: cast_nullable_to_non_nullable
                  as int,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastMonthReset: freezed == lastMonthReset
            ? _value.lastMonthReset
            : lastMonthReset // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gamesPlayed: null == gamesPlayed
            ? _value.gamesPlayed
            : gamesPlayed // ignore: cast_nullable_to_non_nullable
                  as int,
        gamesWon: null == gamesWon
            ? _value.gamesWon
            : gamesWon // ignore: cast_nullable_to_non_nullable
                  as int,
        totalScore: null == totalScore
            ? _value.totalScore
            : totalScore // ignore: cast_nullable_to_non_nullable
                  as int,
        averageScore: null == averageScore
            ? _value.averageScore
            : averageScore // ignore: cast_nullable_to_non_nullable
                  as double,
        winRate: null == winRate
            ? _value.winRate
            : winRate // ignore: cast_nullable_to_non_nullable
                  as double,
        bestCategory: freezed == bestCategory
            ? _value.bestCategory
            : bestCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        streakDays: null == streakDays
            ? _value.streakDays
            : streakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        lastPlayed: freezed == lastPlayed
            ? _value.lastPlayed
            : lastPlayed // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$ProfileImpl implements _Profile {
  const _$ProfileImpl({
    required this.id,
    required this.fullName,
    required this.level,
    required this.createdAt,
    this.avatarUrl,
    this.allCups = 0,
    this.cupsByMonth = 0,
    this.username,
    this.email,
    this.lastMonthReset,
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.totalScore = 0,
    this.averageScore = 0.0,
    this.winRate = 0.0,
    this.bestCategory,
    this.streakDays = 0,
    this.lastPlayed,
  });

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String level;
  @override
  final DateTime createdAt;
  @override
  final String? avatarUrl;
  // NEW FIELDS
  @override
  @JsonKey()
  final int allCups;
  @override
  @JsonKey()
  final int cupsByMonth;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final DateTime? lastMonthReset;
  @override
  @JsonKey()
  final int gamesPlayed;
  @override
  @JsonKey()
  final int gamesWon;
  @override
  @JsonKey()
  final int totalScore;
  @override
  @JsonKey()
  final double averageScore;
  @override
  @JsonKey()
  final double winRate;
  @override
  final String? bestCategory;
  @override
  @JsonKey()
  final int streakDays;
  @override
  final DateTime? lastPlayed;

  @override
  String toString() {
    return 'Profile(id: $id, fullName: $fullName, level: $level, createdAt: $createdAt, avatarUrl: $avatarUrl, allCups: $allCups, cupsByMonth: $cupsByMonth, username: $username, email: $email, lastMonthReset: $lastMonthReset, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, totalScore: $totalScore, averageScore: $averageScore, winRate: $winRate, bestCategory: $bestCategory, streakDays: $streakDays, lastPlayed: $lastPlayed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.allCups, allCups) || other.allCups == allCups) &&
            (identical(other.cupsByMonth, cupsByMonth) ||
                other.cupsByMonth == cupsByMonth) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.lastMonthReset, lastMonthReset) ||
                other.lastMonthReset == lastMonthReset) &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.gamesWon, gamesWon) ||
                other.gamesWon == gamesWon) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore) &&
            (identical(other.winRate, winRate) || other.winRate == winRate) &&
            (identical(other.bestCategory, bestCategory) ||
                other.bestCategory == bestCategory) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    level,
    createdAt,
    avatarUrl,
    allCups,
    cupsByMonth,
    username,
    email,
    lastMonthReset,
    gamesPlayed,
    gamesWon,
    totalScore,
    averageScore,
    winRate,
    bestCategory,
    streakDays,
    lastPlayed,
  );

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      __$$ProfileImplCopyWithImpl<_$ProfileImpl>(this, _$identity);
}

abstract class _Profile implements Profile {
  const factory _Profile({
    required final String id,
    required final String fullName,
    required final String level,
    required final DateTime createdAt,
    final String? avatarUrl,
    final int allCups,
    final int cupsByMonth,
    final String? username,
    final String? email,
    final DateTime? lastMonthReset,
    final int gamesPlayed,
    final int gamesWon,
    final int totalScore,
    final double averageScore,
    final double winRate,
    final String? bestCategory,
    final int streakDays,
    final DateTime? lastPlayed,
  }) = _$ProfileImpl;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get level;
  @override
  DateTime get createdAt;
  @override
  String? get avatarUrl; // NEW FIELDS
  @override
  int get allCups;
  @override
  int get cupsByMonth;
  @override
  String? get username;
  @override
  String? get email;
  @override
  DateTime? get lastMonthReset;
  @override
  int get gamesPlayed;
  @override
  int get gamesWon;
  @override
  int get totalScore;
  @override
  double get averageScore;
  @override
  double get winRate;
  @override
  String? get bestCategory;
  @override
  int get streakDays;
  @override
  DateTime? get lastPlayed;

  /// Create a copy of Profile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImplCopyWith<_$ProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
