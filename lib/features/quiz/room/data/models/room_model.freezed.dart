// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RoomModel {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get hostId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get timerDuration => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  Map<String, dynamic>? get state => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  List<RoomPlayer>? get players => throw _privateConstructorUsedError;
  List<RoomQuestion>? get questions => throw _privateConstructorUsedError;

  /// Create a copy of RoomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomModelCopyWith<RoomModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomModelCopyWith<$Res> {
  factory $RoomModelCopyWith(RoomModel value, $Res Function(RoomModel) then) =
      _$RoomModelCopyWithImpl<$Res, RoomModel>;
  @useResult
  $Res call({
    String id,
    String code,
    String hostId,
    String status,
    int timerDuration,
    String? categoryId,
    String? title,
    Map<String, dynamic>? state,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  });
}

/// @nodoc
class _$RoomModelCopyWithImpl<$Res, $Val extends RoomModel>
    implements $RoomModelCopyWith<$Res> {
  _$RoomModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostId = null,
    Object? status = null,
    Object? timerDuration = null,
    Object? categoryId = freezed,
    Object? title = freezed,
    Object? state = freezed,
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
            timerDuration: null == timerDuration
                ? _value.timerDuration
                : timerDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
abstract class _$$RoomModelImplCopyWith<$Res>
    implements $RoomModelCopyWith<$Res> {
  factory _$$RoomModelImplCopyWith(
    _$RoomModelImpl value,
    $Res Function(_$RoomModelImpl) then,
  ) = __$$RoomModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    String hostId,
    String status,
    int timerDuration,
    String? categoryId,
    String? title,
    Map<String, dynamic>? state,
    DateTime? createdAt,
    List<RoomPlayer>? players,
    List<RoomQuestion>? questions,
  });
}

/// @nodoc
class __$$RoomModelImplCopyWithImpl<$Res>
    extends _$RoomModelCopyWithImpl<$Res, _$RoomModelImpl>
    implements _$$RoomModelImplCopyWith<$Res> {
  __$$RoomModelImplCopyWithImpl(
    _$RoomModelImpl _value,
    $Res Function(_$RoomModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? hostId = null,
    Object? status = null,
    Object? timerDuration = null,
    Object? categoryId = freezed,
    Object? title = freezed,
    Object? state = freezed,
    Object? createdAt = freezed,
    Object? players = freezed,
    Object? questions = freezed,
  }) {
    return _then(
      _$RoomModelImpl(
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
        timerDuration: null == timerDuration
            ? _value.timerDuration
            : timerDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value._state
            : state // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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

class _$RoomModelImpl implements _RoomModel {
  const _$RoomModelImpl({
    required this.id,
    required this.code,
    required this.hostId,
    required this.status,
    required this.timerDuration,
    this.categoryId,
    this.title,
    final Map<String, dynamic>? state,
    this.createdAt,
    final List<RoomPlayer>? players,
    final List<RoomQuestion>? questions,
  }) : _state = state,
       _players = players,
       _questions = questions;

  @override
  final String id;
  @override
  final String code;
  @override
  final String hostId;
  @override
  final String status;
  @override
  final int timerDuration;
  @override
  final String? categoryId;
  @override
  final String? title;
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
    return 'RoomModel(id: $id, code: $code, hostId: $hostId, status: $status, timerDuration: $timerDuration, categoryId: $categoryId, title: $title, state: $state, createdAt: $createdAt, players: $players, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.timerDuration, timerDuration) ||
                other.timerDuration == timerDuration) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._state, _state) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    hostId,
    status,
    timerDuration,
    categoryId,
    title,
    const DeepCollectionEquality().hash(_state),
    createdAt,
    const DeepCollectionEquality().hash(_players),
    const DeepCollectionEquality().hash(_questions),
  );

  /// Create a copy of RoomModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      __$$RoomModelImplCopyWithImpl<_$RoomModelImpl>(this, _$identity);
}

abstract class _RoomModel implements RoomModel {
  const factory _RoomModel({
    required final String id,
    required final String code,
    required final String hostId,
    required final String status,
    required final int timerDuration,
    final String? categoryId,
    final String? title,
    final Map<String, dynamic>? state,
    final DateTime? createdAt,
    final List<RoomPlayer>? players,
    final List<RoomQuestion>? questions,
  }) = _$RoomModelImpl;

  @override
  String get id;
  @override
  String get code;
  @override
  String get hostId;
  @override
  String get status;
  @override
  int get timerDuration;
  @override
  String? get categoryId;
  @override
  String? get title;
  @override
  Map<String, dynamic>? get state;
  @override
  DateTime? get createdAt;
  @override
  List<RoomPlayer>? get players;
  @override
  List<RoomQuestion>? get questions;

  /// Create a copy of RoomModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomModelImplCopyWith<_$RoomModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
