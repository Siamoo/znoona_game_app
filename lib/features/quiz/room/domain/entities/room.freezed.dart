// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // waiting | playing | finished
  String? get categoryId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get state => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<RoomPlayer>? get players => throw _privateConstructorUsedError;
  List<RoomQuestion>? get questions => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call({
    String id,
    String code,
    String hostId,
    String status,
    String? categoryId,
    Map<String, dynamic>? state,
    String? title,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  });
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostId = null,
    Object? status = null,
    Object? categoryId = freezed,
    Object? state = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? players = freezed,
    Object? questions = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            hostId: null == hostId
                ? _value.hostId
                : hostId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            players: freezed == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as List<RoomPlayer>?,
            questions: freezed == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<RoomQuestion>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
    _$RoomImpl value,
    $Res Function(_$RoomImpl) then,
  ) = __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    String hostId,
    String status,
    String? categoryId,
    Map<String, dynamic>? state,
    String? title,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  });
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
    : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostId = null,
    Object? status = null,
    Object? categoryId = freezed,
    Object? state = freezed,
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? players = freezed,
    Object? questions = freezed,
  }) {
    return _then(
      _$RoomImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        hostId: null == hostId
            ? _value.hostId
            : hostId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value._state
            : state // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        players: freezed == players
            ? _value._players
            : players // ignore: cast_nullable_to_non_nullable
                  as List<RoomPlayer>?,
        questions: freezed == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<RoomQuestion>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl({
    required this.id,
    required this.code,
    required this.hostId,
    required this.status,
    this.categoryId,
    final Map<String, dynamic>? state,
    this.title,
    this.createdAt,
    final List<RoomPlayer>? players,
    final List<RoomQuestion>? questions,
  }) : _state = state,
       _players = players,
       _questions = questions;

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String hostId;
  @override
  final String status;
  // waiting | playing | finished
  @override
  final String? categoryId;
  final Map<String, dynamic>? _state;
  @override
  Map<String, dynamic>? get state {
    final value = _state;
    if (value == null) return null;
    if (_state is EqualUnmodifiableMapView) return _state;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? title;
  @override
  final DateTime? createdAt;
  final List<RoomPlayer>? _players;
  @override
  List<RoomPlayer>? get players {
    final value = _players;
    if (value == null) return null;
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RoomQuestion>? _questions;
  @override
  List<RoomQuestion>? get questions {
    final value = _questions;
    if (value == null) return null;
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Room(id: $id, code: $code, hostId: $hostId, status: $status, categoryId: $categoryId, state: $state, title: $title, createdAt: $createdAt, players: $players, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            const DeepCollectionEquality().equals(other._state, _state) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    hostId,
    status,
    categoryId,
    const DeepCollectionEquality().hash(_state),
    title,
    createdAt,
    const DeepCollectionEquality().hash(_players),
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(this);
  }
}

abstract class _Room implements Room {
  const factory _Room({
    required final String id,
    required final String code,
    required final String hostId,
    required final String status,
    final String? categoryId,
    final Map<String, dynamic>? state,
    final String? title,
    final DateTime? createdAt,
    final List<RoomPlayer>? players,
    final List<RoomQuestion>? questions,
  }) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get hostId;
  @override
  String get status; // waiting | playing | finished
  @override
  String? get categoryId;
  @override
  Map<String, dynamic>? get state;
  @override
  String? get title;
  @override
  DateTime? get createdAt;
  @override
  List<RoomPlayer>? get players;
  @override
  List<RoomQuestion>? get questions;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
