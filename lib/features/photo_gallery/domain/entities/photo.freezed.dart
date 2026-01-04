// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Photo {
  String get id => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get capturedAt => throw _privateConstructorUsedError;
  bool get isMorning => throw _privateConstructorUsedError;
  bool get isPrivate => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;
  int? get cycleDay => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call(
      {String id,
      String filePath,
      DateTime capturedAt,
      bool isMorning,
      bool isPrivate,
      String? thumbnailPath,
      int? cycleDay});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

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
    Object? cycleDay = freezed,
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
      cycleDay: freezed == cycleDay
          ? _value.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoImplCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$PhotoImplCopyWith(
          _$PhotoImpl value, $Res Function(_$PhotoImpl) then) =
      __$$PhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String filePath,
      DateTime capturedAt,
      bool isMorning,
      bool isPrivate,
      String? thumbnailPath,
      int? cycleDay});
}

/// @nodoc
class __$$PhotoImplCopyWithImpl<$Res>
    extends _$PhotoCopyWithImpl<$Res, _$PhotoImpl>
    implements _$$PhotoImplCopyWith<$Res> {
  __$$PhotoImplCopyWithImpl(
      _$PhotoImpl _value, $Res Function(_$PhotoImpl) _then)
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
    Object? cycleDay = freezed,
  }) {
    return _then(_$PhotoImpl(
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
      cycleDay: freezed == cycleDay
          ? _value.cycleDay
          : cycleDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$PhotoImpl implements _Photo {
  const _$PhotoImpl(
      {required this.id,
      required this.filePath,
      required this.capturedAt,
      required this.isMorning,
      this.isPrivate = false,
      this.thumbnailPath,
      this.cycleDay});

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
  final int? cycleDay;

  @override
  String toString() {
    return 'Photo(id: $id, filePath: $filePath, capturedAt: $capturedAt, isMorning: $isMorning, isPrivate: $isPrivate, thumbnailPath: $thumbnailPath, cycleDay: $cycleDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoImpl &&
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
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, filePath, capturedAt,
      isMorning, isPrivate, thumbnailPath, cycleDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      __$$PhotoImplCopyWithImpl<_$PhotoImpl>(this, _$identity);
}

abstract class _Photo implements Photo {
  const factory _Photo(
      {required final String id,
      required final String filePath,
      required final DateTime capturedAt,
      required final bool isMorning,
      final bool isPrivate,
      final String? thumbnailPath,
      final int? cycleDay}) = _$PhotoImpl;

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
  int? get cycleDay;
  @override
  @JsonKey(ignore: true)
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
