// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomPlayerModel _$RoomPlayerModelFromJson(Map<String, dynamic> json) {
  return _RoomPlayerModel.fromJson(json);
}

/// @nodoc
mixin _$RoomPlayerModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  bool get isHost => throw _privateConstructorUsedError;

  /// Serializes this RoomPlayerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomPlayerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomPlayerModelCopyWith<RoomPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomPlayerModelCopyWith<$Res> {
  factory $RoomPlayerModelCopyWith(
    RoomPlayerModel value,
    $Res Function(RoomPlayerModel) then,
  ) = _$RoomPlayerModelCopyWithImpl<$Res, RoomPlayerModel>;
  @useResult
  $Res call({String id, String name, int score, bool isHost});
}

/// @nodoc
class _$RoomPlayerModelCopyWithImpl<$Res, $Val extends RoomPlayerModel>
    implements $RoomPlayerModelCopyWith<$Res> {
  _$RoomPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomPlayerModel
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
abstract class _$$RoomPlayerModelImplCopyWith<$Res>
    implements $RoomPlayerModelCopyWith<$Res> {
  factory _$$RoomPlayerModelImplCopyWith(
    _$RoomPlayerModelImpl value,
    $Res Function(_$RoomPlayerModelImpl) then,
  ) = __$$RoomPlayerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, int score, bool isHost});
}

/// @nodoc
class __$$RoomPlayerModelImplCopyWithImpl<$Res>
    extends _$RoomPlayerModelCopyWithImpl<$Res, _$RoomPlayerModelImpl>
    implements _$$RoomPlayerModelImplCopyWith<$Res> {
  __$$RoomPlayerModelImplCopyWithImpl(
    _$RoomPlayerModelImpl _value,
    $Res Function(_$RoomPlayerModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomPlayerModel
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
      _$RoomPlayerModelImpl(
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
@JsonSerializable()
class _$RoomPlayerModelImpl implements _RoomPlayerModel {
  const _$RoomPlayerModelImpl({
    required this.id,
    required this.name,
    required this.score,
    required this.isHost,
  });

  factory _$RoomPlayerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomPlayerModelImplFromJson(json);

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
    return 'RoomPlayerModel(id: $id, name: $name, score: $score, isHost: $isHost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomPlayerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.isHost, isHost) || other.isHost == isHost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, score, isHost);

  /// Create a copy of RoomPlayerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomPlayerModelImplCopyWith<_$RoomPlayerModelImpl> get copyWith =>
      __$$RoomPlayerModelImplCopyWithImpl<_$RoomPlayerModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomPlayerModelImplToJson(this);
  }
}

abstract class _RoomPlayerModel implements RoomPlayerModel {
  const factory _RoomPlayerModel({
    required final String id,
    required final String name,
    required final int score,
    required final bool isHost,
  }) = _$RoomPlayerModelImpl;

  factory _RoomPlayerModel.fromJson(Map<String, dynamic> json) =
      _$RoomPlayerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get score;
  @override
  bool get isHost;

  /// Create a copy of RoomPlayerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomPlayerModelImplCopyWith<_$RoomPlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
