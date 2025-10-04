// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RoomPlayer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  bool get isHost => throw _privateConstructorUsedError;

  /// Create a copy of RoomPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomPlayerCopyWith<RoomPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomPlayerCopyWith<$Res> {
  factory $RoomPlayerCopyWith(
    RoomPlayer value,
    $Res Function(RoomPlayer) then,
  ) = _$RoomPlayerCopyWithImpl<$Res, RoomPlayer>;
  @useResult
  $Res call({String id, String name, int score, bool isHost});
}

/// @nodoc
class _$RoomPlayerCopyWithImpl<$Res, $Val extends RoomPlayer>
    implements $RoomPlayerCopyWith<$Res> {
  _$RoomPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? score = null,
    Object? isHost = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            isHost: null == isHost
                ? _value.isHost
                : isHost // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomPlayerImplCopyWith<$Res>
    implements $RoomPlayerCopyWith<$Res> {
  factory _$$RoomPlayerImplCopyWith(
    _$RoomPlayerImpl value,
    $Res Function(_$RoomPlayerImpl) then,
  ) = __$$RoomPlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int score, bool isHost});
}

/// @nodoc
class __$$RoomPlayerImplCopyWithImpl<$Res>
    extends _$RoomPlayerCopyWithImpl<$Res, _$RoomPlayerImpl>
    implements _$$RoomPlayerImplCopyWith<$Res> {
  __$$RoomPlayerImplCopyWithImpl(
    _$RoomPlayerImpl _value,
    $Res Function(_$RoomPlayerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? score = null,
    Object? isHost = null,
  }) {
    return _then(
      _$RoomPlayerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        isHost: null == isHost
            ? _value.isHost
            : isHost // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RoomPlayerImpl implements _RoomPlayer {
  const _$RoomPlayerImpl({
    required this.id,
    required this.name,
    required this.score,
    required this.isHost,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final int score;
  @override
  final bool isHost;

  @override
  String toString() {
    return 'RoomPlayer(id: $id, name: $name, score: $score, isHost: $isHost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomPlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isHost, isHost) || other.isHost == isHost));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, score, isHost);

  /// Create a copy of RoomPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomPlayerImplCopyWith<_$RoomPlayerImpl> get copyWith =>
      __$$RoomPlayerImplCopyWithImpl<_$RoomPlayerImpl>(this, _$identity);
}

abstract class _RoomPlayer implements RoomPlayer {
  const factory _RoomPlayer({
    required final String id,
    required final String name,
    required final int score,
    required final bool isHost,
  }) = _$RoomPlayerImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  int get score;
  @override
  bool get isHost;

  /// Create a copy of RoomPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomPlayerImplCopyWith<_$RoomPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
