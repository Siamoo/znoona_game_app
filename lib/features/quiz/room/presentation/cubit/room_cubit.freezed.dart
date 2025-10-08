// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RoomState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomStateCopyWith<$Res> {
  factory $RoomStateCopyWith(RoomState value, $Res Function(RoomState) then) =
      _$RoomStateCopyWithImpl<$Res, RoomState>;
}

/// @nodoc
class _$RoomStateCopyWithImpl<$Res, $Val extends RoomState>
    implements $RoomStateCopyWith<$Res> {
  _$RoomStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'RoomState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RoomState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'RoomState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements RoomState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RoomState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements RoomState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomLoadedImplCopyWith<$Res> {
  factory _$$RoomLoadedImplCopyWith(
    _$RoomLoadedImpl value,
    $Res Function(_$RoomLoadedImpl) then,
  ) = __$$RoomLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Room room});

  $RoomCopyWith<$Res> get room;
}

/// @nodoc
class __$$RoomLoadedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomLoadedImpl>
    implements _$$RoomLoadedImplCopyWith<$Res> {
  __$$RoomLoadedImplCopyWithImpl(
    _$RoomLoadedImpl _value,
    $Res Function(_$RoomLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null}) {
    return _then(
      _$RoomLoadedImpl(
        null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as Room,
      ),
    );
  }

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res> get room {
    return $RoomCopyWith<$Res>(_value.room, (value) {
      return _then(_value.copyWith(room: value));
    });
  }
}

/// @nodoc

class _$RoomLoadedImpl implements _RoomLoaded {
  const _$RoomLoadedImpl(this.room);

  @override
  final Room room;

  @override
  String toString() {
    return 'RoomState.roomLoaded(room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomLoadedImpl &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(runtimeType, room);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomLoadedImplCopyWith<_$RoomLoadedImpl> get copyWith =>
      __$$RoomLoadedImplCopyWithImpl<_$RoomLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return roomLoaded(room);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return roomLoaded?.call(room);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (roomLoaded != null) {
      return roomLoaded(room);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return roomLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return roomLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (roomLoaded != null) {
      return roomLoaded(this);
    }
    return orElse();
  }
}

abstract class _RoomLoaded implements RoomState {
  const factory _RoomLoaded(final Room room) = _$RoomLoadedImpl;

  Room get room;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomLoadedImplCopyWith<_$RoomLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomsUpdatedImplCopyWith<$Res> {
  factory _$$RoomsUpdatedImplCopyWith(
    _$RoomsUpdatedImpl value,
    $Res Function(_$RoomsUpdatedImpl) then,
  ) = __$$RoomsUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Room> rooms});
}

/// @nodoc
class __$$RoomsUpdatedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomsUpdatedImpl>
    implements _$$RoomsUpdatedImplCopyWith<$Res> {
  __$$RoomsUpdatedImplCopyWithImpl(
    _$RoomsUpdatedImpl _value,
    $Res Function(_$RoomsUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? rooms = null}) {
    return _then(
      _$RoomsUpdatedImpl(
        null == rooms
            ? _value._rooms
            : rooms // ignore: cast_nullable_to_non_nullable
                  as List<Room>,
      ),
    );
  }
}

/// @nodoc

class _$RoomsUpdatedImpl implements _RoomsUpdated {
  const _$RoomsUpdatedImpl(final List<Room> rooms) : _rooms = rooms;

  final List<Room> _rooms;
  @override
  List<Room> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'RoomState.roomsUpdated(rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomsUpdatedImpl &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomsUpdatedImplCopyWith<_$RoomsUpdatedImpl> get copyWith =>
      __$$RoomsUpdatedImplCopyWithImpl<_$RoomsUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return roomsUpdated(rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return roomsUpdated?.call(rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (roomsUpdated != null) {
      return roomsUpdated(rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return roomsUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return roomsUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (roomsUpdated != null) {
      return roomsUpdated(this);
    }
    return orElse();
  }
}

abstract class _RoomsUpdated implements RoomState {
  const factory _RoomsUpdated(final List<Room> rooms) = _$RoomsUpdatedImpl;

  List<Room> get rooms;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomsUpdatedImplCopyWith<_$RoomsUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlayersUpdatedImplCopyWith<$Res> {
  factory _$$PlayersUpdatedImplCopyWith(
    _$PlayersUpdatedImpl value,
    $Res Function(_$PlayersUpdatedImpl) then,
  ) = __$$PlayersUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RoomPlayer> players});
}

/// @nodoc
class __$$PlayersUpdatedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$PlayersUpdatedImpl>
    implements _$$PlayersUpdatedImplCopyWith<$Res> {
  __$$PlayersUpdatedImplCopyWithImpl(
    _$PlayersUpdatedImpl _value,
    $Res Function(_$PlayersUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? players = null}) {
    return _then(
      _$PlayersUpdatedImpl(
        null == players
            ? _value._players
            : players // ignore: cast_nullable_to_non_nullable
                  as List<RoomPlayer>,
      ),
    );
  }
}

/// @nodoc

class _$PlayersUpdatedImpl implements _PlayersUpdated {
  const _$PlayersUpdatedImpl(final List<RoomPlayer> players)
    : _players = players;

  final List<RoomPlayer> _players;
  @override
  List<RoomPlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'RoomState.playersUpdated(players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayersUpdatedImpl &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_players));

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayersUpdatedImplCopyWith<_$PlayersUpdatedImpl> get copyWith =>
      __$$PlayersUpdatedImplCopyWithImpl<_$PlayersUpdatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return playersUpdated(players);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return playersUpdated?.call(players);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (playersUpdated != null) {
      return playersUpdated(players);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return playersUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return playersUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (playersUpdated != null) {
      return playersUpdated(this);
    }
    return orElse();
  }
}

abstract class _PlayersUpdated implements RoomState {
  const factory _PlayersUpdated(final List<RoomPlayer> players) =
      _$PlayersUpdatedImpl;

  List<RoomPlayer> get players;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayersUpdatedImplCopyWith<_$PlayersUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RoomUpdatedImplCopyWith<$Res> {
  factory _$$RoomUpdatedImplCopyWith(
    _$RoomUpdatedImpl value,
    $Res Function(_$RoomUpdatedImpl) then,
  ) = __$$RoomUpdatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Room? room});

  $RoomCopyWith<$Res>? get room;
}

/// @nodoc
class __$$RoomUpdatedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$RoomUpdatedImpl>
    implements _$$RoomUpdatedImplCopyWith<$Res> {
  __$$RoomUpdatedImplCopyWithImpl(
    _$RoomUpdatedImpl _value,
    $Res Function(_$RoomUpdatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = freezed}) {
    return _then(
      _$RoomUpdatedImpl(
        freezed == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as Room?,
      ),
    );
  }

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res>? get room {
    if (_value.room == null) {
      return null;
    }

    return $RoomCopyWith<$Res>(_value.room!, (value) {
      return _then(_value.copyWith(room: value));
    });
  }
}

/// @nodoc

class _$RoomUpdatedImpl implements _RoomUpdated {
  const _$RoomUpdatedImpl(this.room);

  @override
  final Room? room;

  @override
  String toString() {
    return 'RoomState.roomUpdated(room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomUpdatedImpl &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(runtimeType, room);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomUpdatedImplCopyWith<_$RoomUpdatedImpl> get copyWith =>
      __$$RoomUpdatedImplCopyWithImpl<_$RoomUpdatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return roomUpdated(room);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return roomUpdated?.call(room);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (roomUpdated != null) {
      return roomUpdated(room);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return roomUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return roomUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (roomUpdated != null) {
      return roomUpdated(this);
    }
    return orElse();
  }
}

abstract class _RoomUpdated implements RoomState {
  const factory _RoomUpdated(final Room? room) = _$RoomUpdatedImpl;

  Room? get room;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomUpdatedImplCopyWith<_$RoomUpdatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuestionsLoadedImplCopyWith<$Res> {
  factory _$$QuestionsLoadedImplCopyWith(
    _$QuestionsLoadedImpl value,
    $Res Function(_$QuestionsLoadedImpl) then,
  ) = __$$QuestionsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RoomQuestion> questions});
}

/// @nodoc
class __$$QuestionsLoadedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$QuestionsLoadedImpl>
    implements _$$QuestionsLoadedImplCopyWith<$Res> {
  __$$QuestionsLoadedImplCopyWithImpl(
    _$QuestionsLoadedImpl _value,
    $Res Function(_$QuestionsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? questions = null}) {
    return _then(
      _$QuestionsLoadedImpl(
        null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<RoomQuestion>,
      ),
    );
  }
}

/// @nodoc

class _$QuestionsLoadedImpl implements _QuestionsLoaded {
  const _$QuestionsLoadedImpl(final List<RoomQuestion> questions)
    : _questions = questions;

  final List<RoomQuestion> _questions;
  @override
  List<RoomQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'RoomState.questionsLoaded(questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuestionsLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_questions));

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuestionsLoadedImplCopyWith<_$QuestionsLoadedImpl> get copyWith =>
      __$$QuestionsLoadedImplCopyWithImpl<_$QuestionsLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return questionsLoaded(questions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return questionsLoaded?.call(questions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (questionsLoaded != null) {
      return questionsLoaded(questions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return questionsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return questionsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (questionsLoaded != null) {
      return questionsLoaded(this);
    }
    return orElse();
  }
}

abstract class _QuestionsLoaded implements RoomState {
  const factory _QuestionsLoaded(final List<RoomQuestion> questions) =
      _$QuestionsLoadedImpl;

  List<RoomQuestion> get questions;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuestionsLoadedImplCopyWith<_$QuestionsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JoinedImplCopyWith<$Res> {
  factory _$$JoinedImplCopyWith(
    _$JoinedImpl value,
    $Res Function(_$JoinedImpl) then,
  ) = __$$JoinedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Room room});

  $RoomCopyWith<$Res> get room;
}

/// @nodoc
class __$$JoinedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$JoinedImpl>
    implements _$$JoinedImplCopyWith<$Res> {
  __$$JoinedImplCopyWithImpl(
    _$JoinedImpl _value,
    $Res Function(_$JoinedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? room = null}) {
    return _then(
      _$JoinedImpl(
        null == room
            ? _value.room
            : room // ignore: cast_nullable_to_non_nullable
                  as Room,
      ),
    );
  }

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RoomCopyWith<$Res> get room {
    return $RoomCopyWith<$Res>(_value.room, (value) {
      return _then(_value.copyWith(room: value));
    });
  }
}

/// @nodoc

class _$JoinedImpl implements _Joined {
  const _$JoinedImpl(this.room);

  @override
  final Room room;

  @override
  String toString() {
    return 'RoomState.joined(room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinedImpl &&
            (identical(other.room, room) || other.room == room));
  }

  @override
  int get hashCode => Object.hash(runtimeType, room);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinedImplCopyWith<_$JoinedImpl> get copyWith =>
      __$$JoinedImplCopyWithImpl<_$JoinedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return joined(room);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return joined?.call(room);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (joined != null) {
      return joined(room);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return joined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return joined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (joined != null) {
      return joined(this);
    }
    return orElse();
  }
}

abstract class _Joined implements RoomState {
  const factory _Joined(final Room room) = _$JoinedImpl;

  Room get room;

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinedImplCopyWith<_$JoinedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LeftImplCopyWith<$Res> {
  factory _$$LeftImplCopyWith(
    _$LeftImpl value,
    $Res Function(_$LeftImpl) then,
  ) = __$$LeftImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LeftImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$LeftImpl>
    implements _$$LeftImplCopyWith<$Res> {
  __$$LeftImplCopyWithImpl(_$LeftImpl _value, $Res Function(_$LeftImpl) _then)
    : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LeftImpl implements _Left {
  const _$LeftImpl();

  @override
  String toString() {
    return 'RoomState.left()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LeftImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return left();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return left?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (left != null) {
      return left();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return left(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return left?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (left != null) {
      return left(this);
    }
    return orElse();
  }
}

abstract class _Left implements RoomState {
  const factory _Left() = _$LeftImpl;
}

/// @nodoc
abstract class _$$GameStartedImplCopyWith<$Res> {
  factory _$$GameStartedImplCopyWith(
    _$GameStartedImpl value,
    $Res Function(_$GameStartedImpl) then,
  ) = __$$GameStartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GameStartedImplCopyWithImpl<$Res>
    extends _$RoomStateCopyWithImpl<$Res, _$GameStartedImpl>
    implements _$$GameStartedImplCopyWith<$Res> {
  __$$GameStartedImplCopyWithImpl(
    _$GameStartedImpl _value,
    $Res Function(_$GameStartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoomState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GameStartedImpl implements _GameStarted {
  const _$GameStartedImpl();

  @override
  String toString() {
    return 'RoomState.gameStarted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GameStartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(Room room) roomLoaded,
    required TResult Function(List<Room> rooms) roomsUpdated,
    required TResult Function(List<RoomPlayer> players) playersUpdated,
    required TResult Function(Room? room) roomUpdated,
    required TResult Function(List<RoomQuestion> questions) questionsLoaded,
    required TResult Function(Room room) joined,
    required TResult Function() left,
    required TResult Function() gameStarted,
  }) {
    return gameStarted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(Room room)? roomLoaded,
    TResult? Function(List<Room> rooms)? roomsUpdated,
    TResult? Function(List<RoomPlayer> players)? playersUpdated,
    TResult? Function(Room? room)? roomUpdated,
    TResult? Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult? Function(Room room)? joined,
    TResult? Function()? left,
    TResult? Function()? gameStarted,
  }) {
    return gameStarted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(Room room)? roomLoaded,
    TResult Function(List<Room> rooms)? roomsUpdated,
    TResult Function(List<RoomPlayer> players)? playersUpdated,
    TResult Function(Room? room)? roomUpdated,
    TResult Function(List<RoomQuestion> questions)? questionsLoaded,
    TResult Function(Room room)? joined,
    TResult Function()? left,
    TResult Function()? gameStarted,
    required TResult orElse(),
  }) {
    if (gameStarted != null) {
      return gameStarted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_RoomLoaded value) roomLoaded,
    required TResult Function(_RoomsUpdated value) roomsUpdated,
    required TResult Function(_PlayersUpdated value) playersUpdated,
    required TResult Function(_RoomUpdated value) roomUpdated,
    required TResult Function(_QuestionsLoaded value) questionsLoaded,
    required TResult Function(_Joined value) joined,
    required TResult Function(_Left value) left,
    required TResult Function(_GameStarted value) gameStarted,
  }) {
    return gameStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_RoomLoaded value)? roomLoaded,
    TResult? Function(_RoomsUpdated value)? roomsUpdated,
    TResult? Function(_PlayersUpdated value)? playersUpdated,
    TResult? Function(_RoomUpdated value)? roomUpdated,
    TResult? Function(_QuestionsLoaded value)? questionsLoaded,
    TResult? Function(_Joined value)? joined,
    TResult? Function(_Left value)? left,
    TResult? Function(_GameStarted value)? gameStarted,
  }) {
    return gameStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_RoomLoaded value)? roomLoaded,
    TResult Function(_RoomsUpdated value)? roomsUpdated,
    TResult Function(_PlayersUpdated value)? playersUpdated,
    TResult Function(_RoomUpdated value)? roomUpdated,
    TResult Function(_QuestionsLoaded value)? questionsLoaded,
    TResult Function(_Joined value)? joined,
    TResult Function(_Left value)? left,
    TResult Function(_GameStarted value)? gameStarted,
    required TResult orElse(),
  }) {
    if (gameStarted != null) {
      return gameStarted(this);
    }
    return orElse();
  }
}

abstract class _GameStarted implements RoomState {
  const factory _GameStarted() = _$GameStartedImpl;
}
