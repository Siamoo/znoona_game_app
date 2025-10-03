// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_questions_by_category_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$GetQuestionsByCategoryParams {
  String get categoryId => throw _privateConstructorUsedError;

  /// Create a copy of GetQuestionsByCategoryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetQuestionsByCategoryParamsCopyWith<GetQuestionsByCategoryParams>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetQuestionsByCategoryParamsCopyWith<$Res> {
  factory $GetQuestionsByCategoryParamsCopyWith(
    GetQuestionsByCategoryParams value,
    $Res Function(GetQuestionsByCategoryParams) then,
  ) =
      _$GetQuestionsByCategoryParamsCopyWithImpl<
        $Res,
        GetQuestionsByCategoryParams
      >;
  @useResult
  $Res call({String categoryId});
}

/// @nodoc
class _$GetQuestionsByCategoryParamsCopyWithImpl<
  $Res,
  $Val extends GetQuestionsByCategoryParams
>
    implements $GetQuestionsByCategoryParamsCopyWith<$Res> {
  _$GetQuestionsByCategoryParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetQuestionsByCategoryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryId = null}) {
    return _then(
      _value.copyWith(
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GetQuestionsByCategoryParamsImplCopyWith<$Res>
    implements $GetQuestionsByCategoryParamsCopyWith<$Res> {
  factory _$$GetQuestionsByCategoryParamsImplCopyWith(
    _$GetQuestionsByCategoryParamsImpl value,
    $Res Function(_$GetQuestionsByCategoryParamsImpl) then,
  ) = __$$GetQuestionsByCategoryParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String categoryId});
}

/// @nodoc
class __$$GetQuestionsByCategoryParamsImplCopyWithImpl<$Res>
    extends
        _$GetQuestionsByCategoryParamsCopyWithImpl<
          $Res,
          _$GetQuestionsByCategoryParamsImpl
        >
    implements _$$GetQuestionsByCategoryParamsImplCopyWith<$Res> {
  __$$GetQuestionsByCategoryParamsImplCopyWithImpl(
    _$GetQuestionsByCategoryParamsImpl _value,
    $Res Function(_$GetQuestionsByCategoryParamsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GetQuestionsByCategoryParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryId = null}) {
    return _then(
      _$GetQuestionsByCategoryParamsImpl(
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetQuestionsByCategoryParamsImpl
    implements _GetQuestionsByCategoryParams {
  const _$GetQuestionsByCategoryParamsImpl({required this.categoryId});

  @override
  final String categoryId;

  @override
  String toString() {
    return 'GetQuestionsByCategoryParams(categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetQuestionsByCategoryParamsImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoryId);

  /// Create a copy of GetQuestionsByCategoryParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetQuestionsByCategoryParamsImplCopyWith<
    _$GetQuestionsByCategoryParamsImpl
  >
  get copyWith =>
      __$$GetQuestionsByCategoryParamsImplCopyWithImpl<
        _$GetQuestionsByCategoryParamsImpl
      >(this, _$identity);
}

abstract class _GetQuestionsByCategoryParams
    implements GetQuestionsByCategoryParams {
  const factory _GetQuestionsByCategoryParams({
    required final String categoryId,
  }) = _$GetQuestionsByCategoryParamsImpl;

  @override
  String get categoryId;

  /// Create a copy of GetQuestionsByCategoryParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetQuestionsByCategoryParamsImplCopyWith<
    _$GetQuestionsByCategoryParamsImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
