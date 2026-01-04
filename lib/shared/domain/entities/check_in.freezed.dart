// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'check_in.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CheckIn {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  CheckInType get type => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  bool get hasPhoto => throw _privateConstructorUsedError;
  String? get photoId => throw _privateConstructorUsedError;
  int get pointsEarned => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CheckInCopyWith<CheckIn> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckInCopyWith<$Res> {
  factory $CheckInCopyWith(CheckIn value, $Res Function(CheckIn) then) =
      _$CheckInCopyWithImpl<$Res, CheckIn>;
  @useResult
  $Res call({
    String id,
    DateTime date,
    CheckInType type,
    DateTime completedAt,
    bool hasPhoto,
    String? photoId,
    int pointsEarned,
  });
}

/// @nodoc
class _$CheckInCopyWithImpl<$Res, $Val extends CheckIn>
    implements $CheckInCopyWith<$Res> {
  _$CheckInCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
    Object? completedAt = null,
    Object? hasPhoto = null,
    Object? photoId = freezed,
    Object? pointsEarned = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as CheckInType,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            hasPhoto: null == hasPhoto
                ? _value.hasPhoto
                : hasPhoto // ignore: cast_nullable_to_non_nullable
                      as bool,
            photoId: freezed == photoId
                ? _value.photoId
                : photoId // ignore: cast_nullable_to_non_nullable
                      as String?,
            pointsEarned: null == pointsEarned
                ? _value.pointsEarned
                : pointsEarned // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CheckInImplCopyWith<$Res> implements $CheckInCopyWith<$Res> {
  factory _$$CheckInImplCopyWith(
    _$CheckInImpl value,
    $Res Function(_$CheckInImpl) then,
  ) = __$$CheckInImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime date,
    CheckInType type,
    DateTime completedAt,
    bool hasPhoto,
    String? photoId,
    int pointsEarned,
  });
}

/// @nodoc
class __$$CheckInImplCopyWithImpl<$Res>
    extends _$CheckInCopyWithImpl<$Res, _$CheckInImpl>
    implements _$$CheckInImplCopyWith<$Res> {
  __$$CheckInImplCopyWithImpl(
    _$CheckInImpl _value,
    $Res Function(_$CheckInImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? type = null,
    Object? completedAt = null,
    Object? hasPhoto = null,
    Object? photoId = freezed,
    Object? pointsEarned = null,
  }) {
    return _then(
      _$CheckInImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as CheckInType,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        hasPhoto: null == hasPhoto
            ? _value.hasPhoto
            : hasPhoto // ignore: cast_nullable_to_non_nullable
                  as bool,
        photoId: freezed == photoId
            ? _value.photoId
            : photoId // ignore: cast_nullable_to_non_nullable
                  as String?,
        pointsEarned: null == pointsEarned
            ? _value.pointsEarned
            : pointsEarned // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$CheckInImpl implements _CheckIn {
  const _$CheckInImpl({
    required this.id,
    required this.date,
    required this.type,
    required this.completedAt,
    this.hasPhoto = false,
    this.photoId,
    this.pointsEarned = 10,
  });

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final CheckInType type;
  @override
  final DateTime completedAt;
  @override
  @JsonKey()
  final bool hasPhoto;
  @override
  final String? photoId;
  @override
  @JsonKey()
  final int pointsEarned;

  @override
  String toString() {
    return 'CheckIn(id: $id, date: $date, type: $type, completedAt: $completedAt, hasPhoto: $hasPhoto, photoId: $photoId, pointsEarned: $pointsEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckInImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.hasPhoto, hasPhoto) ||
                other.hasPhoto == hasPhoto) &&
            (identical(other.photoId, photoId) || other.photoId == photoId) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    type,
    completedAt,
    hasPhoto,
    photoId,
    pointsEarned,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckInImplCopyWith<_$CheckInImpl> get copyWith =>
      __$$CheckInImplCopyWithImpl<_$CheckInImpl>(this, _$identity);
}

abstract class _CheckIn implements CheckIn {
  const factory _CheckIn({
    required final String id,
    required final DateTime date,
    required final CheckInType type,
    required final DateTime completedAt,
    final bool hasPhoto,
    final String? photoId,
    final int pointsEarned,
  }) = _$CheckInImpl;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  CheckInType get type;
  @override
  DateTime get completedAt;
  @override
  bool get hasPhoto;
  @override
  String? get photoId;
  @override
  int get pointsEarned;
  @override
  @JsonKey(ignore: true)
  _$$CheckInImplCopyWith<_$CheckInImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
