// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timelapse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Timelapse {
  String get id => throw _privateConstructorUsedError;
  String get videoPath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get photoCount => throw _privateConstructorUsedError;
  int get durationSeconds => throw _privateConstructorUsedError;
  String? get thumbnailPath => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimelapseCopyWith<Timelapse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelapseCopyWith<$Res> {
  factory $TimelapseCopyWith(Timelapse value, $Res Function(Timelapse) then) =
      _$TimelapseCopyWithImpl<$Res, Timelapse>;
  @useResult
  $Res call(
      {String id,
      String videoPath,
      DateTime createdAt,
      DateTime startDate,
      DateTime endDate,
      int photoCount,
      int durationSeconds,
      String? thumbnailPath});
}

/// @nodoc
class _$TimelapseCopyWithImpl<$Res, $Val extends Timelapse>
    implements $TimelapseCopyWith<$Res> {
  _$TimelapseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoPath = null,
    Object? createdAt = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? photoCount = null,
    Object? durationSeconds = null,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      videoPath: null == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoCount: null == photoCount
          ? _value.photoCount
          : photoCount // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelapseImplCopyWith<$Res>
    implements $TimelapseCopyWith<$Res> {
  factory _$$TimelapseImplCopyWith(
          _$TimelapseImpl value, $Res Function(_$TimelapseImpl) then) =
      __$$TimelapseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String videoPath,
      DateTime createdAt,
      DateTime startDate,
      DateTime endDate,
      int photoCount,
      int durationSeconds,
      String? thumbnailPath});
}

/// @nodoc
class __$$TimelapseImplCopyWithImpl<$Res>
    extends _$TimelapseCopyWithImpl<$Res, _$TimelapseImpl>
    implements _$$TimelapseImplCopyWith<$Res> {
  __$$TimelapseImplCopyWithImpl(
      _$TimelapseImpl _value, $Res Function(_$TimelapseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? videoPath = null,
    Object? createdAt = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? photoCount = null,
    Object? durationSeconds = null,
    Object? thumbnailPath = freezed,
  }) {
    return _then(_$TimelapseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      videoPath: null == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoCount: null == photoCount
          ? _value.photoCount
          : photoCount // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnailPath: freezed == thumbnailPath
          ? _value.thumbnailPath
          : thumbnailPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TimelapseImpl implements _Timelapse {
  const _$TimelapseImpl(
      {required this.id,
      required this.videoPath,
      required this.createdAt,
      required this.startDate,
      required this.endDate,
      required this.photoCount,
      required this.durationSeconds,
      this.thumbnailPath});

  @override
  final String id;
  @override
  final String videoPath;
  @override
  final DateTime createdAt;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int photoCount;
  @override
  final int durationSeconds;
  @override
  final String? thumbnailPath;

  @override
  String toString() {
    return 'Timelapse(id: $id, videoPath: $videoPath, createdAt: $createdAt, startDate: $startDate, endDate: $endDate, photoCount: $photoCount, durationSeconds: $durationSeconds, thumbnailPath: $thumbnailPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelapseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, videoPath, createdAt,
      startDate, endDate, photoCount, durationSeconds, thumbnailPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelapseImplCopyWith<_$TimelapseImpl> get copyWith =>
      __$$TimelapseImplCopyWithImpl<_$TimelapseImpl>(this, _$identity);
}

abstract class _Timelapse implements Timelapse {
  const factory _Timelapse(
      {required final String id,
      required final String videoPath,
      required final DateTime createdAt,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int photoCount,
      required final int durationSeconds,
      final String? thumbnailPath}) = _$TimelapseImpl;

  @override
  String get id;
  @override
  String get videoPath;
  @override
  DateTime get createdAt;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get photoCount;
  @override
  int get durationSeconds;
  @override
  String? get thumbnailPath;
  @override
  @JsonKey(ignore: true)
  _$$TimelapseImplCopyWith<_$TimelapseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
