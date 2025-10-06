// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoomQuestionModel _$RoomQuestionModelFromJson(Map<String, dynamic> json) {
  return _RoomQuestionModel.fromJson(json);
}

/// @nodoc
mixin _$RoomQuestionModel {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;

  /// Serializes this RoomQuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomQuestionModelCopyWith<RoomQuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomQuestionModelCopyWith<$Res> {
  factory $RoomQuestionModelCopyWith(
    RoomQuestionModel value,
    $Res Function(RoomQuestionModel) then,
  ) = _$RoomQuestionModelCopyWithImpl<$Res, RoomQuestionModel>;
  @useResult
  $Res call({String id, String roomId, String questionId, int orderIndex});
}

/// @nodoc
class _$RoomQuestionModelCopyWithImpl<$Res, $Val extends RoomQuestionModel>
    implements $RoomQuestionModelCopyWith<$Res> {
  _$RoomQuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? questionId = null,
    Object? orderIndex = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            roomId: null == roomId
                ? _value.roomId
                : roomId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoomQuestionModelImplCopyWith<$Res>
    implements $RoomQuestionModelCopyWith<$Res> {
  factory _$$RoomQuestionModelImplCopyWith(
    _$RoomQuestionModelImpl value,
    $Res Function(_$RoomQuestionModelImpl) then,
  ) = __$$RoomQuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String roomId, String questionId, int orderIndex});
}

/// @nodoc
class __$$RoomQuestionModelImplCopyWithImpl<$Res>
    extends _$RoomQuestionModelCopyWithImpl<$Res, _$RoomQuestionModelImpl>
    implements _$$RoomQuestionModelImplCopyWith<$Res> {
  __$$RoomQuestionModelImplCopyWithImpl(
    _$RoomQuestionModelImpl _value,
    $Res Function(_$RoomQuestionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? questionId = null,
    Object? orderIndex = null,
  }) {
    return _then(
      _$RoomQuestionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomQuestionModelImpl implements _RoomQuestionModel {
  const _$RoomQuestionModelImpl({
    required this.id,
    required this.roomId,
    required this.questionId,
    required this.orderIndex,
  });

  factory _$RoomQuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomQuestionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String questionId;
  @override
  final int orderIndex;

  @override
  String toString() {
    return 'RoomQuestionModel(id: $id, roomId: $roomId, questionId: $questionId, orderIndex: $orderIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomQuestionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, roomId, questionId, orderIndex);

  /// Create a copy of RoomQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomQuestionModelImplCopyWith<_$RoomQuestionModelImpl> get copyWith =>
      __$$RoomQuestionModelImplCopyWithImpl<_$RoomQuestionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomQuestionModelImplToJson(this);
  }
}

abstract class _RoomQuestionModel implements RoomQuestionModel {
  const factory _RoomQuestionModel({
    required final String id,
    required final String roomId,
    required final String questionId,
    required final int orderIndex,
  }) = _$RoomQuestionModelImpl;

  factory _RoomQuestionModel.fromJson(Map<String, dynamic> json) =
      _$RoomQuestionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get questionId;
  @override
  int get orderIndex;

  /// Create a copy of RoomQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomQuestionModelImplCopyWith<_$RoomQuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
