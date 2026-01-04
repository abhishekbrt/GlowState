// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CapturedPhoto {
  String get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get capturedAt => throw _privateConstructorUsedError;
  bool get isMorning => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CapturedPhotoCopyWith<CapturedPhoto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapturedPhotoCopyWith<$Res> {
  factory $CapturedPhotoCopyWith(
          CapturedPhoto value, $Res Function(CapturedPhoto) then) =
      _$CapturedPhotoCopyWithImpl<$Res, CapturedPhoto>;
  @useResult
  $Res call(
      {String id,
      String filePath,
      DateTime capturedAt,
      bool isMorning,
      bool isPrivate,
      String? thumbnailPath});
}

/// @nodoc
class _$CapturedPhotoCopyWithImpl<$Res, $Val extends CapturedPhoto>
    implements $CapturedPhotoCopyWith<$Res> {
  _$CapturedPhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? capturedAt = null,
    Object? isMorning = null,
    Object? isPrivate = null,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      capturedAt: null == capturedAt
          ? _value.capturedAt
          : capturedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMorning: null == isMorning
          ? _value.isMorning
          : isMorning // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CapturedPhotoImplCopyWith<$Res>
    implements $CapturedPhotoCopyWith<$Res> {
  factory _$$CapturedPhotoImplCopyWith(
          _$CapturedPhotoImpl value, $Res Function(_$CapturedPhotoImpl) then) =
      __$$CapturedPhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String filePath,
      DateTime capturedAt,
      bool isMorning,
      bool isPrivate,
      String? thumbnailPath});
}

/// @nodoc
class __$$CapturedPhotoImplCopyWithImpl<$Res>
    extends _$CapturedPhotoCopyWithImpl<$Res, _$CapturedPhotoImpl>
    implements _$$CapturedPhotoImplCopyWith<$Res> {
  __$$CapturedPhotoImplCopyWithImpl(
      _$CapturedPhotoImpl _value, $Res Function(_$CapturedPhotoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? capturedAt = null,
    Object? isMorning = null,
    Object? isPrivate = null,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_$CapturedPhotoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      capturedAt: null == capturedAt
          ? _value.capturedAt
          : capturedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isMorning: null == isMorning
          ? _value.isMorning
          : isMorning // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CapturedPhotoImpl implements _CapturedPhoto {
  const _$CapturedPhotoImpl(
      {required this.id,
      required this.filePath,
      required this.capturedAt,
      required this.isMorning,
      this.isPrivate = false,
      this.thumbnailPath});

  @override
  final String id;
  @override
  final String filePath;
  @override
  final DateTime capturedAt;
  @override
  final bool isMorning;
  @override
  @JsonKey()
  final bool isPrivate;
  @override
  final String? thumbnailPath;

  @override
  String toString() {
    return 'CapturedPhoto(id: $id, filePath: $filePath, capturedAt: $capturedAt, isMorning: $isMorning, isPrivate: $isPrivate, thumbnailPath: $thumbnailPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapturedPhotoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
            (identical(other.isMorning, isMorning) ||
                other.isMorning == isMorning) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, filePath, capturedAt,
      isMorning, isPrivate, thumbnailPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CapturedPhotoImplCopyWith<_$CapturedPhotoImpl> get copyWith =>
      __$$CapturedPhotoImplCopyWithImpl<_$CapturedPhotoImpl>(this, _$identity);
}

abstract class _CapturedPhoto implements CapturedPhoto {
  const factory _CapturedPhoto(
      {required final String id,
      required final String filePath,
      required final DateTime capturedAt,
      required final bool isMorning,
      final bool isPrivate,
      final String? thumbnailPath}) = _$CapturedPhotoImpl;

  @override
  String get id;
  @override
  String get filePath;
  @override
  DateTime get capturedAt;
  @override
  bool get isMorning;
  @override
  bool get isPrivate;
  @override
  String? get thumbnailPath;
  @override
  @JsonKey(ignore: true)
  _$$CapturedPhotoImplCopyWith<_$CapturedPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
