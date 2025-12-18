// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return _ProfileModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileModel {
  String get id => throw _privateConstructorUsedError;
  String get full_name => throw _privateConstructorUsedError;
  String get level => throw _privateConstructorUsedError;
  String? get avatar_url => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;
  int get all_cups => throw _privateConstructorUsedError;
  int get cups_by_month => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime? get lastMonthReset => throw _privateConstructorUsedError;
  int get games_played => throw _privateConstructorUsedError;
  int get games_won => throw _privateConstructorUsedError;
  int get total_score => throw _privateConstructorUsedError;
  double get average_score => throw _privateConstructorUsedError;
  double get win_rate => throw _privateConstructorUsedError;
  String? get best_category => throw _privateConstructorUsedError;
  int get streak_days => throw _privateConstructorUsedError;
  DateTime? get last_played => throw _privateConstructorUsedError;

  /// Serializes this ProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileModelCopyWith<ProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileModelCopyWith<$Res> {
  factory $ProfileModelCopyWith(
    ProfileModel value,
    $Res Function(ProfileModel) then,
  ) = _$ProfileModelCopyWithImpl<$Res, ProfileModel>;
  @useResult
  $Res call({
    String id,
    String full_name,
    String level,
    String? avatar_url,
    DateTime created_at,
    int all_cups,
    int cups_by_month,
    String? username,
    String? email,
    DateTime? lastMonthReset,
    int games_played,
    int games_won,
    int total_score,
    double average_score,
    double win_rate,
    String? best_category,
    int streak_days,
    DateTime? last_played,
  });
}

/// @nodoc
class _$ProfileModelCopyWithImpl<$Res, $Val extends ProfileModel>
    implements $ProfileModelCopyWith<$Res> {
  _$ProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? full_name = null,
    Object? level = null,
    Object? avatar_url = freezed,
    Object? created_at = null,
    Object? all_cups = null,
    Object? cups_by_month = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? lastMonthReset = freezed,
    Object? games_played = null,
    Object? games_won = null,
    Object? total_score = null,
    Object? average_score = null,
    Object? win_rate = null,
    Object? best_category = freezed,
    Object? streak_days = null,
    Object? last_played = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            full_name: null == full_name
                ? _value.full_name
                : full_name // ignore: cast_nullable_to_non_nullable
                      as String,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar_url: freezed == avatar_url
                ? _value.avatar_url
                : avatar_url // ignore: cast_nullable_to_non_nullable
                      as String?,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            all_cups: null == all_cups
                ? _value.all_cups
                : all_cups // ignore: cast_nullable_to_non_nullable
                      as int,
            cups_by_month: null == cups_by_month
                ? _value.cups_by_month
                : cups_by_month // ignore: cast_nullable_to_non_nullable
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
            games_played: null == games_played
                ? _value.games_played
                : games_played // ignore: cast_nullable_to_non_nullable
                      as int,
            games_won: null == games_won
                ? _value.games_won
                : games_won // ignore: cast_nullable_to_non_nullable
                      as int,
            total_score: null == total_score
                ? _value.total_score
                : total_score // ignore: cast_nullable_to_non_nullable
                      as int,
            average_score: null == average_score
                ? _value.average_score
                : average_score // ignore: cast_nullable_to_non_nullable
                      as double,
            win_rate: null == win_rate
                ? _value.win_rate
                : win_rate // ignore: cast_nullable_to_non_nullable
                      as double,
            best_category: freezed == best_category
                ? _value.best_category
                : best_category // ignore: cast_nullable_to_non_nullable
                      as String?,
            streak_days: null == streak_days
                ? _value.streak_days
                : streak_days // ignore: cast_nullable_to_non_nullable
                      as int,
            last_played: freezed == last_played
                ? _value.last_played
                : last_played // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileModelImplCopyWith<$Res>
    implements $ProfileModelCopyWith<$Res> {
  factory _$$ProfileModelImplCopyWith(
    _$ProfileModelImpl value,
    $Res Function(_$ProfileModelImpl) then,
  ) = __$$ProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String full_name,
    String level,
    String? avatar_url,
    DateTime created_at,
    int all_cups,
    int cups_by_month,
    String? username,
    String? email,
    DateTime? lastMonthReset,
    int games_played,
    int games_won,
    int total_score,
    double average_score,
    double win_rate,
    String? best_category,
    int streak_days,
    DateTime? last_played,
  });
}

/// @nodoc
class __$$ProfileModelImplCopyWithImpl<$Res>
    extends _$ProfileModelCopyWithImpl<$Res, _$ProfileModelImpl>
    implements _$$ProfileModelImplCopyWith<$Res> {
  __$$ProfileModelImplCopyWithImpl(
    _$ProfileModelImpl _value,
    $Res Function(_$ProfileModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? full_name = null,
    Object? level = null,
    Object? avatar_url = freezed,
    Object? created_at = null,
    Object? all_cups = null,
    Object? cups_by_month = null,
    Object? username = freezed,
    Object? email = freezed,
    Object? lastMonthReset = freezed,
    Object? games_played = null,
    Object? games_won = null,
    Object? total_score = null,
    Object? average_score = null,
    Object? win_rate = null,
    Object? best_category = freezed,
    Object? streak_days = null,
    Object? last_played = freezed,
  }) {
    return _then(
      _$ProfileModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        full_name: null == full_name
            ? _value.full_name
            : full_name // ignore: cast_nullable_to_non_nullable
                  as String,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar_url: freezed == avatar_url
            ? _value.avatar_url
            : avatar_url // ignore: cast_nullable_to_non_nullable
                  as String?,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        all_cups: null == all_cups
            ? _value.all_cups
            : all_cups // ignore: cast_nullable_to_non_nullable
                  as int,
        cups_by_month: null == cups_by_month
            ? _value.cups_by_month
            : cups_by_month // ignore: cast_nullable_to_non_nullable
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
        games_played: null == games_played
            ? _value.games_played
            : games_played // ignore: cast_nullable_to_non_nullable
                  as int,
        games_won: null == games_won
            ? _value.games_won
            : games_won // ignore: cast_nullable_to_non_nullable
                  as int,
        total_score: null == total_score
            ? _value.total_score
            : total_score // ignore: cast_nullable_to_non_nullable
                  as int,
        average_score: null == average_score
            ? _value.average_score
            : average_score // ignore: cast_nullable_to_non_nullable
                  as double,
        win_rate: null == win_rate
            ? _value.win_rate
            : win_rate // ignore: cast_nullable_to_non_nullable
                  as double,
        best_category: freezed == best_category
            ? _value.best_category
            : best_category // ignore: cast_nullable_to_non_nullable
                  as String?,
        streak_days: null == streak_days
            ? _value.streak_days
            : streak_days // ignore: cast_nullable_to_non_nullable
                  as int,
        last_played: freezed == last_played
            ? _value.last_played
            : last_played // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileModelImpl implements _ProfileModel {
  const _$ProfileModelImpl({
    required this.id,
    required this.full_name,
    required this.level,
    this.avatar_url,
    required this.created_at,
    this.all_cups = 0,
    this.cups_by_month = 0,
    this.username,
    this.email,
    this.lastMonthReset,
    this.games_played = 0,
    this.games_won = 0,
    this.total_score = 0,
    this.average_score = 0.0,
    this.win_rate = 0.0,
    this.best_category,
    this.streak_days = 0,
    this.last_played,
  });

  factory _$ProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileModelImplFromJson(json);

  @override
  final String id;
  @override
  final String full_name;
  @override
  final String level;
  @override
  final String? avatar_url;
  @override
  final DateTime created_at;
  @override
  @JsonKey()
  final int all_cups;
  @override
  @JsonKey()
  final int cups_by_month;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final DateTime? lastMonthReset;
  @override
  @JsonKey()
  final int games_played;
  @override
  @JsonKey()
  final int games_won;
  @override
  @JsonKey()
  final int total_score;
  @override
  @JsonKey()
  final double average_score;
  @override
  @JsonKey()
  final double win_rate;
  @override
  final String? best_category;
  @override
  @JsonKey()
  final int streak_days;
  @override
  final DateTime? last_played;

  @override
  String toString() {
    return 'ProfileModel(id: $id, full_name: $full_name, level: $level, avatar_url: $avatar_url, created_at: $created_at, all_cups: $all_cups, cups_by_month: $cups_by_month, username: $username, email: $email, lastMonthReset: $lastMonthReset, games_played: $games_played, games_won: $games_won, total_score: $total_score, average_score: $average_score, win_rate: $win_rate, best_category: $best_category, streak_days: $streak_days, last_played: $last_played)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.avatar_url, avatar_url) ||
                other.avatar_url == avatar_url) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.all_cups, all_cups) ||
                other.all_cups == all_cups) &&
            (identical(other.cups_by_month, cups_by_month) ||
                other.cups_by_month == cups_by_month) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.lastMonthReset, lastMonthReset) ||
                other.lastMonthReset == lastMonthReset) &&
            (identical(other.games_played, games_played) ||
                other.games_played == games_played) &&
            (identical(other.games_won, games_won) ||
                other.games_won == games_won) &&
            (identical(other.total_score, total_score) ||
                other.total_score == total_score) &&
            (identical(other.average_score, average_score) ||
                other.average_score == average_score) &&
            (identical(other.win_rate, win_rate) ||
                other.win_rate == win_rate) &&
            (identical(other.best_category, best_category) ||
                other.best_category == best_category) &&
            (identical(other.streak_days, streak_days) ||
                other.streak_days == streak_days) &&
            (identical(other.last_played, last_played) ||
                other.last_played == last_played));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    full_name,
    level,
    avatar_url,
    created_at,
    all_cups,
    cups_by_month,
    username,
    email,
    lastMonthReset,
    games_played,
    games_won,
    total_score,
    average_score,
    win_rate,
    best_category,
    streak_days,
    last_played,
  );

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      __$$ProfileModelImplCopyWithImpl<_$ProfileModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileModelImplToJson(this);
  }
}

abstract class _ProfileModel implements ProfileModel {
  const factory _ProfileModel({
    required final String id,
    required final String full_name,
    required final String level,
    final String? avatar_url,
    required final DateTime created_at,
    final int all_cups,
    final int cups_by_month,
    final String? username,
    final String? email,
    final DateTime? lastMonthReset,
    final int games_played,
    final int games_won,
    final int total_score,
    final double average_score,
    final double win_rate,
    final String? best_category,
    final int streak_days,
    final DateTime? last_played,
  }) = _$ProfileModelImpl;

  factory _ProfileModel.fromJson(Map<String, dynamic> json) =
      _$ProfileModelImpl.fromJson;

  @override
  String get id;
  @override
  String get full_name;
  @override
  String get level;
  @override
  String? get avatar_url;
  @override
  DateTime get created_at;
  @override
  int get all_cups;
  @override
  int get cups_by_month;
  @override
  String? get username;
  @override
  String? get email;
  @override
  DateTime? get lastMonthReset;
  @override
  int get games_played;
  @override
  int get games_won;
  @override
  int get total_score;
  @override
  double get average_score;
  @override
  double get win_rate;
  @override
  String? get best_category;
  @override
  int get streak_days;
  @override
  DateTime? get last_played;

  /// Create a copy of ProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileModelImplCopyWith<_$ProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
