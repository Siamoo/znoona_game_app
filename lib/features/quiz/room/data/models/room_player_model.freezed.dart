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

/// @nodoc
mixin _$RoomPlayerModel {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  bool get isHost => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  bool get finishedQuiz => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  String? get selectedAnswer => throw _privateConstructorUsedError;
  bool? get isCorrect => throw _privateConstructorUsedError;
  DateTime? get answeredAt => throw _privateConstructorUsedError;
  bool? get isReady => throw _privateConstructorUsedError;

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
  $Res call({
    String id,
    String roomId,
    String userId,
    String username,
    bool isHost,
    bool isConnected,
    int score,
    bool finishedQuiz,
    DateTime? finishedAt,
    DateTime? joinedAt,
    String? selectedAnswer,
    bool? isCorrect,
    DateTime? answeredAt,
    bool? isReady,
  });
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
    Object? roomId = null,
    Object? userId = null,
    Object? username = null,
    Object? isHost = null,
    Object? isConnected = null,
    Object? score = null,
    Object? finishedQuiz = null,
    Object? finishedAt = freezed,
    Object? joinedAt = freezed,
    Object? selectedAnswer = freezed,
    Object? isCorrect = freezed,
    Object? answeredAt = freezed,
    Object? isReady = freezed,
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
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            isHost: null == isHost
                ? _value.isHost
                : isHost // ignore: cast_nullable_to_non_nullable
                      as bool,
            isConnected: null == isConnected
                ? _value.isConnected
                : isConnected // ignore: cast_nullable_to_non_nullable
                      as bool,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            finishedQuiz: null == finishedQuiz
                ? _value.finishedQuiz
                : finishedQuiz // ignore: cast_nullable_to_non_nullable
                      as bool,
            finishedAt: freezed == finishedAt
                ? _value.finishedAt
                : finishedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            joinedAt: freezed == joinedAt
                ? _value.joinedAt
                : joinedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            selectedAnswer: freezed == selectedAnswer
                ? _value.selectedAnswer
                : selectedAnswer // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCorrect: freezed == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool?,
            answeredAt: freezed == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isReady: freezed == isReady
                ? _value.isReady
                : isReady // ignore: cast_nullable_to_non_nullable
                      as bool?,
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
  $Res call({
    String id,
    String roomId,
    String userId,
    String username,
    bool isHost,
    bool isConnected,
    int score,
    bool finishedQuiz,
    DateTime? finishedAt,
    DateTime? joinedAt,
    String? selectedAnswer,
    bool? isCorrect,
    DateTime? answeredAt,
    bool? isReady,
  });
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
    Object? roomId = null,
    Object? userId = null,
    Object? username = null,
    Object? isHost = null,
    Object? isConnected = null,
    Object? score = null,
    Object? finishedQuiz = null,
    Object? finishedAt = freezed,
    Object? joinedAt = freezed,
    Object? selectedAnswer = freezed,
    Object? isCorrect = freezed,
    Object? answeredAt = freezed,
    Object? isReady = freezed,
  }) {
    return _then(
      _$RoomPlayerModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        roomId: null == roomId
            ? _value.roomId
            : roomId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        isHost: null == isHost
            ? _value.isHost
            : isHost // ignore: cast_nullable_to_non_nullable
                  as bool,
        isConnected: null == isConnected
            ? _value.isConnected
            : isConnected // ignore: cast_nullable_to_non_nullable
                  as bool,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        finishedQuiz: null == finishedQuiz
            ? _value.finishedQuiz
            : finishedQuiz // ignore: cast_nullable_to_non_nullable
                  as bool,
        finishedAt: freezed == finishedAt
            ? _value.finishedAt
            : finishedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        joinedAt: freezed == joinedAt
            ? _value.joinedAt
            : joinedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        selectedAnswer: freezed == selectedAnswer
            ? _value.selectedAnswer
            : selectedAnswer // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCorrect: freezed == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool?,
        answeredAt: freezed == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isReady: freezed == isReady
            ? _value.isReady
            : isReady // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$RoomPlayerModelImpl implements _RoomPlayerModel {
  const _$RoomPlayerModelImpl({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.username,
    required this.isHost,
    required this.isConnected,
    required this.score,
    required this.finishedQuiz,
    this.finishedAt,
    this.joinedAt,
    this.selectedAnswer,
    this.isCorrect,
    this.answeredAt,
    this.isReady,
  });

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String userId;
  @override
  final String username;
  @override
  final bool isHost;
  @override
  final bool isConnected;
  @override
  final int score;
  @override
  final bool finishedQuiz;
  @override
  final DateTime? finishedAt;
  @override
  final DateTime? joinedAt;
  @override
  final String? selectedAnswer;
  @override
  final bool? isCorrect;
  @override
  final DateTime? answeredAt;
  @override
  final bool? isReady;

  @override
  String toString() {
    return 'RoomPlayerModel(id: $id, roomId: $roomId, userId: $userId, username: $username, isHost: $isHost, isConnected: $isConnected, score: $score, finishedQuiz: $finishedQuiz, finishedAt: $finishedAt, joinedAt: $joinedAt, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect, answeredAt: $answeredAt, isReady: $isReady)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomPlayerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.isHost, isHost) || other.isHost == isHost) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.finishedQuiz, finishedQuiz) ||
                other.finishedQuiz == finishedQuiz) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt) &&
            (identical(other.isReady, isReady) || other.isReady == isReady));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    roomId,
    userId,
    username,
    isHost,
    isConnected,
    score,
    finishedQuiz,
    finishedAt,
    joinedAt,
    selectedAnswer,
    isCorrect,
    answeredAt,
    isReady,
  );

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
}

abstract class _RoomPlayerModel implements RoomPlayerModel {
  const factory _RoomPlayerModel({
    required final String id,
    required final String roomId,
    required final String userId,
    required final String username,
    required final bool isHost,
    required final bool isConnected,
    required final int score,
    required final bool finishedQuiz,
    final DateTime? finishedAt,
    final DateTime? joinedAt,
    final String? selectedAnswer,
    final bool? isCorrect,
    final DateTime? answeredAt,
    final bool? isReady,
  }) = _$RoomPlayerModelImpl;

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get userId;
  @override
  String get username;
  @override
  bool get isHost;
  @override
  bool get isConnected;
  @override
  int get score;
  @override
  bool get finishedQuiz;
  @override
  DateTime? get finishedAt;
  @override
  DateTime? get joinedAt;
  @override
  String? get selectedAnswer;
  @override
  bool? get isCorrect;
  @override
  DateTime? get answeredAt;
  @override
  bool? get isReady;

  /// Create a copy of RoomPlayerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomPlayerModelImplCopyWith<_$RoomPlayerModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
