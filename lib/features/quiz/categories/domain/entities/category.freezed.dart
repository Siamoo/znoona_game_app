// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Category {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get arabicName => throw _privateConstructorUsedError;
  String get discription => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  int get totalQuestionsCount =>
      throw _privateConstructorUsedError; // Add this field
  bool get show => throw _privateConstructorUsedError;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call({
    String id,
    String name,
    String arabicName,
    String discription,
    String image,
    DateTime? createdAt,
    String? type,
    String? parentId,
    int totalQuestionsCount,
    bool show,
  });
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? arabicName = null,
    Object? discription = null,
    Object? image = null,
    Object? createdAt = freezed,
    Object? type = freezed,
    Object? parentId = freezed,
    Object? totalQuestionsCount = null,
    Object? show = null,
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
            arabicName: null == arabicName
                ? _value.arabicName
                : arabicName // ignore: cast_nullable_to_non_nullable
                      as String,
            discription: null == discription
                ? _value.discription
                : discription // ignore: cast_nullable_to_non_nullable
                      as String,
            image: null == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            totalQuestionsCount: null == totalQuestionsCount
                ? _value.totalQuestionsCount
                : totalQuestionsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            show: null == show
                ? _value.show
                : show // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
    _$CategoryImpl value,
    $Res Function(_$CategoryImpl) then,
  ) = __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String arabicName,
    String discription,
    String image,
    DateTime? createdAt,
    String? type,
    String? parentId,
    int totalQuestionsCount,
    bool show,
  });
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
    _$CategoryImpl _value,
    $Res Function(_$CategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? arabicName = null,
    Object? discription = null,
    Object? image = null,
    Object? createdAt = freezed,
    Object? type = freezed,
    Object? parentId = freezed,
    Object? totalQuestionsCount = null,
    Object? show = null,
  }) {
    return _then(
      _$CategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        arabicName: null == arabicName
            ? _value.arabicName
            : arabicName // ignore: cast_nullable_to_non_nullable
                  as String,
        discription: null == discription
            ? _value.discription
            : discription // ignore: cast_nullable_to_non_nullable
                  as String,
        image: null == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        totalQuestionsCount: null == totalQuestionsCount
            ? _value.totalQuestionsCount
            : totalQuestionsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        show: null == show
            ? _value.show
            : show // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$CategoryImpl implements _Category {
  const _$CategoryImpl({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.discription,
    required this.image,
    this.createdAt,
    this.type,
    this.parentId,
    this.totalQuestionsCount = 0,
    this.show = true,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String arabicName;
  @override
  final String discription;
  @override
  final String image;
  @override
  final DateTime? createdAt;
  @override
  final String? type;
  @override
  final String? parentId;
  @override
  @JsonKey()
  final int totalQuestionsCount;
  // Add this field
  @override
  @JsonKey()
  final bool show;

  @override
  String toString() {
    return 'Category(id: $id, name: $name, arabicName: $arabicName, discription: $discription, image: $image, createdAt: $createdAt, type: $type, parentId: $parentId, totalQuestionsCount: $totalQuestionsCount, show: $show)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabicName, arabicName) ||
                other.arabicName == arabicName) &&
            (identical(other.discription, discription) ||
                other.discription == discription) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.totalQuestionsCount, totalQuestionsCount) ||
                other.totalQuestionsCount == totalQuestionsCount) &&
            (identical(other.show, show) || other.show == show));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    arabicName,
    discription,
    image,
    createdAt,
    type,
    parentId,
    totalQuestionsCount,
    show,
  );

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);
}

abstract class _Category implements Category {
  const factory _Category({
    required final String id,
    required final String name,
    required final String arabicName,
    required final String discription,
    required final String image,
    final DateTime? createdAt,
    final String? type,
    final String? parentId,
    final int totalQuestionsCount,
    final bool show,
  }) = _$CategoryImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String get arabicName;
  @override
  String get discription;
  @override
  String get image;
  @override
  DateTime? get createdAt;
  @override
  String? get type;
  @override
  String? get parentId;
  @override
  int get totalQuestionsCount; // Add this field
  @override
  bool get show;

  /// Create a copy of Category
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
