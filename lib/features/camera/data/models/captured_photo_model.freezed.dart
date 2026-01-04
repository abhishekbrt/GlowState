// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'captured_photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CapturedPhotoModel _$CapturedPhotoModelFromJson(Map<String, dynamic> json) {
  return _CapturedPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$CapturedPhotoModel {
  String get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get capturedAt => throw _privateConstructorUsedError;
  bool get isMorning => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapturedPhotoModelCopyWith<CapturedPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapturedPhotoModelCopyWith<$Res> {
  factory $CapturedPhotoModelCopyWith(
    CapturedPhotoModel value,
    $Res Function(CapturedPhotoModel) then,
  ) = _$CapturedPhotoModelCopyWithImpl<$Res, CapturedPhotoModel>;
  @useResult
  $Res call({
    String id,
    String filePath,
    DateTime capturedAt,
    bool isMorning,
    bool isPrivate,
    String? thumbnailPath,
  });
}

/// @nodoc
class _$CapturedPhotoModelCopyWithImpl<$Res, $Val extends CapturedPhotoModel>
    implements $CapturedPhotoModelCopyWith<$Res> {
  _$CapturedPhotoModelCopyWithImpl(this._value, this._then);

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
    return _then(
      _value.copyWith(
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CapturedPhotoModelImplCopyWith<$Res>
    implements $CapturedPhotoModelCopyWith<$Res> {
  factory _$$CapturedPhotoModelImplCopyWith(
    _$CapturedPhotoModelImpl value,
    $Res Function(_$CapturedPhotoModelImpl) then,
  ) = __$$CapturedPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String filePath,
    DateTime capturedAt,
    bool isMorning,
    bool isPrivate,
    String? thumbnailPath,
  });
}

/// @nodoc
class __$$CapturedPhotoModelImplCopyWithImpl<$Res>
    extends _$CapturedPhotoModelCopyWithImpl<$Res, _$CapturedPhotoModelImpl>
    implements _$$CapturedPhotoModelImplCopyWith<$Res> {
  __$$CapturedPhotoModelImplCopyWithImpl(
    _$CapturedPhotoModelImpl _value,
    $Res Function(_$CapturedPhotoModelImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$CapturedPhotoModelImpl(
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CapturedPhotoModelImpl extends _CapturedPhotoModel {
  const _$CapturedPhotoModelImpl({
    required this.id,
    required this.filePath,
    required this.capturedAt,
    required this.isMorning,
    this.isPrivate = false,
    this.thumbnailPath,
  }) : super._();

  factory _$CapturedPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CapturedPhotoModelImplFromJson(json);

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
    return 'CapturedPhotoModel(id: $id, filePath: $filePath, capturedAt: $capturedAt, isMorning: $isMorning, isPrivate: $isPrivate, thumbnailPath: $thumbnailPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CapturedPhotoModelImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    filePath,
    capturedAt,
    isMorning,
    isPrivate,
    thumbnailPath,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CapturedPhotoModelImplCopyWith<_$CapturedPhotoModelImpl> get copyWith =>
      __$$CapturedPhotoModelImplCopyWithImpl<_$CapturedPhotoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CapturedPhotoModelImplToJson(this);
  }
}

abstract class _CapturedPhotoModel extends CapturedPhotoModel {
  const factory _CapturedPhotoModel({
    required final String id,
    required final String filePath,
    required final DateTime capturedAt,
    required final bool isMorning,
    final bool isPrivate,
    final String? thumbnailPath,
  }) = _$CapturedPhotoModelImpl;
  const _CapturedPhotoModel._() : super._();

  factory _CapturedPhotoModel.fromJson(Map<String, dynamic> json) =
      _$CapturedPhotoModelImpl.fromJson;

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
  _$$CapturedPhotoModelImplCopyWith<_$CapturedPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
