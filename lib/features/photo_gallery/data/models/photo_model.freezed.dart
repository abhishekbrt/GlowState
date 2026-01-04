// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) {
  return _PhotoModel.fromJson(json);
}

/// @nodoc
mixin _$PhotoModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get filePath => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get capturedAt => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get isMorning => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get isPrivate => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get thumbnailPath => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get cycleDay => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhotoModelCopyWith<PhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoModelCopyWith<$Res> {
  factory $PhotoModelCopyWith(
    PhotoModel value,
    $Res Function(PhotoModel) then,
  ) = _$PhotoModelCopyWithImpl<$Res, PhotoModel>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String filePath,
    @HiveField(2) DateTime capturedAt,
    @HiveField(3) bool isMorning,
    @HiveField(4) bool isPrivate,
    @HiveField(5) String? thumbnailPath,
    @HiveField(6) int? cycleDay,
    @HiveField(7) String? notes,
  });
}

/// @nodoc
class _$PhotoModelCopyWithImpl<$Res, $Val extends PhotoModel>
    implements $PhotoModelCopyWith<$Res> {
  _$PhotoModelCopyWithImpl(this._value, this._then);

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
abstract class _$$PhotoModelImplCopyWith<$Res>
    implements $PhotoModelCopyWith<$Res> {
  factory _$$PhotoModelImplCopyWith(
    _$PhotoModelImpl value,
    $Res Function(_$PhotoModelImpl) then,
  ) = __$$PhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String filePath,
    @HiveField(2) DateTime capturedAt,
    @HiveField(3) bool isMorning,
    @HiveField(4) bool isPrivate,
    @HiveField(5) String? thumbnailPath,
    @HiveField(6) int? cycleDay,
    @HiveField(7) String? notes,
  });
}

/// @nodoc
class __$$PhotoModelImplCopyWithImpl<$Res>
    extends _$PhotoModelCopyWithImpl<$Res, _$PhotoModelImpl>
    implements _$$PhotoModelImplCopyWith<$Res> {
  __$$PhotoModelImplCopyWithImpl(
    _$PhotoModelImpl _value,
    $Res Function(_$PhotoModelImpl) _then,
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
    Object? cycleDay = freezed,
    Object? notes = freezed,
  }) {
    return _then(
      _$PhotoModelImpl(
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
class _$PhotoModelImpl extends _PhotoModel {
  const _$PhotoModelImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.filePath,
    @HiveField(2) required this.capturedAt,
    @HiveField(3) required this.isMorning,
    @HiveField(4) this.isPrivate = false,
    @HiveField(5) this.thumbnailPath,
    @HiveField(6) this.cycleDay,
    @HiveField(7) this.notes,
  }) : super._();

  factory _$PhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String filePath;
  @override
  @HiveField(2)
  final DateTime capturedAt;
  @override
  @HiveField(3)
  final bool isMorning;
  @override
  @JsonKey()
  @HiveField(4)
  final bool isPrivate;
  @override
  @HiveField(5)
  final String? thumbnailPath;
  @override
  @HiveField(6)
  final int? cycleDay;
  @override
  @HiveField(7)
  final String? notes;

  @override
  String toString() {
    return 'PhotoModel(id: $id, filePath: $filePath, capturedAt: $capturedAt, isMorning: $isMorning, isPrivate: $isPrivate, thumbnailPath: $thumbnailPath, cycleDay: $cycleDay, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoModelImpl &&
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
    isMorning,
    isPrivate,
    thumbnailPath,
    cycleDay,
    notes,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoModelImplCopyWith<_$PhotoModelImpl> get copyWith =>
      __$$PhotoModelImplCopyWithImpl<_$PhotoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoModelImplToJson(this);
  }
}

abstract class _PhotoModel extends PhotoModel {
  const factory _PhotoModel({
    @HiveField(0) required final String id,
    @HiveField(1) required final String filePath,
    @HiveField(2) required final DateTime capturedAt,
    @HiveField(3) required final bool isMorning,
    @HiveField(4) final bool isPrivate,
    @HiveField(5) final String? thumbnailPath,
    @HiveField(6) final int? cycleDay,
    @HiveField(7) final String? notes,
  }) = _$PhotoModelImpl;
  const _PhotoModel._() : super._();

  factory _PhotoModel.fromJson(Map<String, dynamic> json) =
      _$PhotoModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get filePath;
  @override
  @HiveField(2)
  DateTime get capturedAt;
  @override
  @HiveField(3)
  bool get isMorning;
  @override
  @HiveField(4)
  bool get isPrivate;
  @override
  @HiveField(5)
  String? get thumbnailPath;
  @override
  @HiveField(6)
  int? get cycleDay;
  @override
  @HiveField(7)
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$PhotoModelImplCopyWith<_$PhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
