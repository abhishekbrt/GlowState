// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhotoRecord _$PhotoRecordFromJson(Map<String, dynamic> json) {
  return _PhotoRecord.fromJson(json);
}

/// @nodoc
mixin _$PhotoRecord {
  /// Unique identifier (UUID v4)
  String get id => throw _privateConstructorUsedError;

  /// Absolute path to the photo file on device
  String get filePath => throw _privateConstructorUsedError;

  /// When the photo was captured
  DateTime get capturedAt => throw _privateConstructorUsedError;

  /// Which routine this photo belongs to (morning/night)
  CheckInType get checkInType => throw _privateConstructorUsedError;

  /// Whether photo is excluded from timelapse
  bool get isPrivate => throw _privateConstructorUsedError;

  /// Path to generated thumbnail (for gallery grid)
  String? get thumbnailPath => throw _privateConstructorUsedError;

  /// Day number in the current 30-day cycle (1-30)
  /// Null if not part of an active cycle
  int? get cycleDay => throw _privateConstructorUsedError;

  /// Optional notes or tags
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoRecordCopyWith<PhotoRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoRecordCopyWith<$Res> {
  factory $PhotoRecordCopyWith(
    PhotoRecord value,
    $Res Function(PhotoRecord) then,
  ) = _$PhotoRecordCopyWithImpl<$Res, PhotoRecord>;
  @useResult
  $Res call({
    String id,
    String filePath,
    DateTime capturedAt,
    CheckInType checkInType,
    bool isPrivate,
    String? thumbnailPath,
    int? cycleDay,
    String? notes,
  });
}

/// @nodoc
class _$PhotoRecordCopyWithImpl<$Res, $Val extends PhotoRecord>
    implements $PhotoRecordCopyWith<$Res> {
  _$PhotoRecordCopyWithImpl(this._value, this._then);

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
    Object? checkInType = null,
    Object? isPrivate = null,
    Object? thumbnailPath = freezed,
    Object? cycleDay = freezed,
    Object? notes = freezed,
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
            checkInType: null == checkInType
                ? _value.checkInType
                : checkInType // ignore: cast_nullable_to_non_nullable
                      as CheckInType,
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
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PhotoRecordImplCopyWith<$Res>
    implements $PhotoRecordCopyWith<$Res> {
  factory _$$PhotoRecordImplCopyWith(
    _$PhotoRecordImpl value,
    $Res Function(_$PhotoRecordImpl) then,
  ) = __$$PhotoRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String filePath,
    DateTime capturedAt,
    CheckInType checkInType,
    bool isPrivate,
    String? thumbnailPath,
    int? cycleDay,
    String? notes,
  });
}

/// @nodoc
class __$$PhotoRecordImplCopyWithImpl<$Res>
    extends _$PhotoRecordCopyWithImpl<$Res, _$PhotoRecordImpl>
    implements _$$PhotoRecordImplCopyWith<$Res> {
  __$$PhotoRecordImplCopyWithImpl(
    _$PhotoRecordImpl _value,
    $Res Function(_$PhotoRecordImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? filePath = null,
    Object? capturedAt = null,
    Object? checkInType = null,
    Object? isPrivate = null,
    Object? thumbnailPath = freezed,
    Object? cycleDay = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$PhotoRecordImpl(
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
        checkInType: null == checkInType
            ? _value.checkInType
            : checkInType // ignore: cast_nullable_to_non_nullable
                  as CheckInType,
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
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoRecordImpl extends _PhotoRecord {
  const _$PhotoRecordImpl({
    required this.id,
    required this.filePath,
    required this.capturedAt,
    required this.checkInType,
    this.isPrivate = false,
    this.thumbnailPath,
    this.cycleDay,
    this.notes,
  }) : super._();

  factory _$PhotoRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoRecordImplFromJson(json);

  /// Unique identifier (UUID v4)
  @override
  final String id;

  /// Absolute path to the photo file on device
  @override
  final String filePath;

  /// When the photo was captured
  @override
  final DateTime capturedAt;

  /// Which routine this photo belongs to (morning/night)
  @override
  final CheckInType checkInType;

  /// Whether photo is excluded from timelapse
  @override
  @JsonKey()
  final bool isPrivate;

  /// Path to generated thumbnail (for gallery grid)
  @override
  final String? thumbnailPath;

  /// Day number in the current 30-day cycle (1-30)
  /// Null if not part of an active cycle
  @override
  final int? cycleDay;

  /// Optional notes or tags
  @override
  final String? notes;

  @override
  String toString() {
    return 'PhotoRecord(id: $id, filePath: $filePath, capturedAt: $capturedAt, checkInType: $checkInType, isPrivate: $isPrivate, thumbnailPath: $thumbnailPath, cycleDay: $cycleDay, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
            (identical(other.checkInType, checkInType) ||
                other.checkInType == checkInType) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.thumbnailPath, thumbnailPath) ||
                other.thumbnailPath == thumbnailPath) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    filePath,
    capturedAt,
    checkInType,
    isPrivate,
    thumbnailPath,
    cycleDay,
    notes,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoRecordImplCopyWith<_$PhotoRecordImpl> get copyWith =>
      __$$PhotoRecordImplCopyWithImpl<_$PhotoRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoRecordImplToJson(this);
  }
}

abstract class _PhotoRecord extends PhotoRecord {
  const factory _PhotoRecord({
    required final String id,
    required final String filePath,
    required final DateTime capturedAt,
    required final CheckInType checkInType,
    final bool isPrivate,
    final String? thumbnailPath,
    final int? cycleDay,
    final String? notes,
  }) = _$PhotoRecordImpl;
  const _PhotoRecord._() : super._();

  factory _PhotoRecord.fromJson(Map<String, dynamic> json) =
      _$PhotoRecordImpl.fromJson;

  @override
  /// Unique identifier (UUID v4)
  String get id;
  @override
  /// Absolute path to the photo file on device
  String get filePath;
  @override
  /// When the photo was captured
  DateTime get capturedAt;
  @override
  /// Which routine this photo belongs to (morning/night)
  CheckInType get checkInType;
  @override
  /// Whether photo is excluded from timelapse
  bool get isPrivate;
  @override
  /// Path to generated thumbnail (for gallery grid)
  String? get thumbnailPath;
  @override
  /// Day number in the current 30-day cycle (1-30)
  /// Null if not part of an active cycle
  int? get cycleDay;
  @override
  /// Optional notes or tags
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$PhotoRecordImplCopyWith<_$PhotoRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
