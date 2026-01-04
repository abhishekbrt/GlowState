// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DailyProgress {
  /// The date this progress represents
  DateTime get date => throw _privateConstructorUsedError;

  /// Morning check-in if completed
  CheckIn? get morningCheckIn => throw _privateConstructorUsedError;

  /// Night check-in if completed
  CheckIn? get nightCheckIn => throw _privateConstructorUsedError;

  /// Current streak count (consecutive days)
  int get currentStreak => throw _privateConstructorUsedError;

  /// Day number in the 30-day cycle (1-30)
  /// 0 if no active cycle
  int get cycleDay => throw _privateConstructorUsedError;

  /// Photos taken on this day
  List<PhotoRecord> get photos => throw _privateConstructorUsedError;

  /// Total points earned today
  int get pointsEarned => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyProgressCopyWith<DailyProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyProgressCopyWith<$Res> {
  factory $DailyProgressCopyWith(
    DailyProgress value,
    $Res Function(DailyProgress) then,
  ) = _$DailyProgressCopyWithImpl<$Res, DailyProgress>;
  @useResult
  $Res call({
    DateTime date,
    CheckIn? morningCheckIn,
    CheckIn? nightCheckIn,
    int currentStreak,
    int cycleDay,
    List<PhotoRecord> photos,
    int pointsEarned,
  });

  $CheckInCopyWith<$Res>? get morningCheckIn;
  $CheckInCopyWith<$Res>? get nightCheckIn;
}

/// @nodoc
class _$DailyProgressCopyWithImpl<$Res, $Val extends DailyProgress>
    implements $DailyProgressCopyWith<$Res> {
  _$DailyProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? morningCheckIn = freezed,
    Object? nightCheckIn = freezed,
    Object? currentStreak = null,
    Object? cycleDay = null,
    Object? photos = null,
    Object? pointsEarned = null,
  }) {
    return _then(
      _value.copyWith(
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            morningCheckIn: freezed == morningCheckIn
                ? _value.morningCheckIn
                : morningCheckIn // ignore: cast_nullable_to_non_nullable
                      as CheckIn?,
            nightCheckIn: freezed == nightCheckIn
                ? _value.nightCheckIn
                : nightCheckIn // ignore: cast_nullable_to_non_nullable
                      as CheckIn?,
            currentStreak: null == currentStreak
                ? _value.currentStreak
                : currentStreak // ignore: cast_nullable_to_non_nullable
                      as int,
            cycleDay: null == cycleDay
                ? _value.cycleDay
                : cycleDay // ignore: cast_nullable_to_non_nullable
                      as int,
            photos: null == photos
                ? _value.photos
                : photos // ignore: cast_nullable_to_non_nullable
                      as List<PhotoRecord>,
            pointsEarned: null == pointsEarned
                ? _value.pointsEarned
                : pointsEarned // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  @override
  @pragma('vm:prefer-inline')
  $CheckInCopyWith<$Res>? get morningCheckIn {
    if (_value.morningCheckIn == null) {
      return null;
    }

    return $CheckInCopyWith<$Res>(_value.morningCheckIn!, (value) {
      return _then(_value.copyWith(morningCheckIn: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CheckInCopyWith<$Res>? get nightCheckIn {
    if (_value.nightCheckIn == null) {
      return null;
    }

    return $CheckInCopyWith<$Res>(_value.nightCheckIn!, (value) {
      return _then(_value.copyWith(nightCheckIn: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DailyProgressImplCopyWith<$Res>
    implements $DailyProgressCopyWith<$Res> {
  factory _$$DailyProgressImplCopyWith(
    _$DailyProgressImpl value,
    $Res Function(_$DailyProgressImpl) then,
  ) = __$$DailyProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    CheckIn? morningCheckIn,
    CheckIn? nightCheckIn,
    int currentStreak,
    int cycleDay,
    List<PhotoRecord> photos,
    int pointsEarned,
  });

  @override
  $CheckInCopyWith<$Res>? get morningCheckIn;
  @override
  $CheckInCopyWith<$Res>? get nightCheckIn;
}

/// @nodoc
class __$$DailyProgressImplCopyWithImpl<$Res>
    extends _$DailyProgressCopyWithImpl<$Res, _$DailyProgressImpl>
    implements _$$DailyProgressImplCopyWith<$Res> {
  __$$DailyProgressImplCopyWithImpl(
    _$DailyProgressImpl _value,
    $Res Function(_$DailyProgressImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? morningCheckIn = freezed,
    Object? nightCheckIn = freezed,
    Object? currentStreak = null,
    Object? cycleDay = null,
    Object? photos = null,
    Object? pointsEarned = null,
  }) {
    return _then(
      _$DailyProgressImpl(
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        morningCheckIn: freezed == morningCheckIn
            ? _value.morningCheckIn
            : morningCheckIn // ignore: cast_nullable_to_non_nullable
                  as CheckIn?,
        nightCheckIn: freezed == nightCheckIn
            ? _value.nightCheckIn
            : nightCheckIn // ignore: cast_nullable_to_non_nullable
                  as CheckIn?,
        currentStreak: null == currentStreak
            ? _value.currentStreak
            : currentStreak // ignore: cast_nullable_to_non_nullable
                  as int,
        cycleDay: null == cycleDay
            ? _value.cycleDay
            : cycleDay // ignore: cast_nullable_to_non_nullable
                  as int,
        photos: null == photos
            ? _value._photos
            : photos // ignore: cast_nullable_to_non_nullable
                  as List<PhotoRecord>,
        pointsEarned: null == pointsEarned
            ? _value.pointsEarned
            : pointsEarned // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DailyProgressImpl extends _DailyProgress {
  const _$DailyProgressImpl({
    required this.date,
    this.morningCheckIn,
    this.nightCheckIn,
    required this.currentStreak,
    this.cycleDay = 0,
    final List<PhotoRecord> photos = const [],
    this.pointsEarned = 0,
  }) : _photos = photos,
       super._();

  /// The date this progress represents
  @override
  final DateTime date;

  /// Morning check-in if completed
  @override
  final CheckIn? morningCheckIn;

  /// Night check-in if completed
  @override
  final CheckIn? nightCheckIn;

  /// Current streak count (consecutive days)
  @override
  final int currentStreak;

  /// Day number in the 30-day cycle (1-30)
  /// 0 if no active cycle
  @override
  @JsonKey()
  final int cycleDay;

  /// Photos taken on this day
  final List<PhotoRecord> _photos;

  /// Photos taken on this day
  @override
  @JsonKey()
  List<PhotoRecord> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  /// Total points earned today
  @override
  @JsonKey()
  final int pointsEarned;

  @override
  String toString() {
    return 'DailyProgress(date: $date, morningCheckIn: $morningCheckIn, nightCheckIn: $nightCheckIn, currentStreak: $currentStreak, cycleDay: $cycleDay, photos: $photos, pointsEarned: $pointsEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyProgressImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.morningCheckIn, morningCheckIn) ||
                other.morningCheckIn == morningCheckIn) &&
            (identical(other.nightCheckIn, nightCheckIn) ||
                other.nightCheckIn == nightCheckIn) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.cycleDay, cycleDay) ||
                other.cycleDay == cycleDay) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.pointsEarned, pointsEarned) ||
                other.pointsEarned == pointsEarned));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    morningCheckIn,
    nightCheckIn,
    currentStreak,
    cycleDay,
    const DeepCollectionEquality().hash(_photos),
    pointsEarned,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyProgressImplCopyWith<_$DailyProgressImpl> get copyWith =>
      __$$DailyProgressImplCopyWithImpl<_$DailyProgressImpl>(this, _$identity);
}

abstract class _DailyProgress extends DailyProgress {
  const factory _DailyProgress({
    required final DateTime date,
    final CheckIn? morningCheckIn,
    final CheckIn? nightCheckIn,
    required final int currentStreak,
    final int cycleDay,
    final List<PhotoRecord> photos,
    final int pointsEarned,
  }) = _$DailyProgressImpl;
  const _DailyProgress._() : super._();

  @override
  /// The date this progress represents
  DateTime get date;
  @override
  /// Morning check-in if completed
  CheckIn? get morningCheckIn;
  @override
  /// Night check-in if completed
  CheckIn? get nightCheckIn;
  @override
  /// Current streak count (consecutive days)
  int get currentStreak;
  @override
  /// Day number in the 30-day cycle (1-30)
  /// 0 if no active cycle
  int get cycleDay;
  @override
  /// Photos taken on this day
  List<PhotoRecord> get photos;
  @override
  /// Total points earned today
  int get pointsEarned;
  @override
  @JsonKey(ignore: true)
  _$$DailyProgressImplCopyWith<_$DailyProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
