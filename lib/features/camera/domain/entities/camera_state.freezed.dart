// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CameraState {
  bool get isInitialized => throw _privateConstructorUsedError;
  bool get isCapturing => throw _privateConstructorUsedError;
  bool get isFrontCamera => throw _privateConstructorUsedError;
  double get zoomLevel => throw _privateConstructorUsedError;
  bool get isFlashOn => throw _privateConstructorUsedError;
  String? get lastPhotoPath => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CameraStateCopyWith<CameraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraStateCopyWith<$Res> {
  factory $CameraStateCopyWith(
    CameraState value,
    $Res Function(CameraState) then,
  ) = _$CameraStateCopyWithImpl<$Res, CameraState>;
  @useResult
  $Res call({
    bool isInitialized,
    bool isCapturing,
    bool isFrontCamera,
    double zoomLevel,
    bool isFlashOn,
    String? lastPhotoPath,
    String? errorMessage,
  });
}

/// @nodoc
class _$CameraStateCopyWithImpl<$Res, $Val extends CameraState>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? isCapturing = null,
    Object? isFrontCamera = null,
    Object? zoomLevel = null,
    Object? isFlashOn = null,
    Object? lastPhotoPath = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            isInitialized: null == isInitialized
                ? _value.isInitialized
                : isInitialized // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCapturing: null == isCapturing
                ? _value.isCapturing
                : isCapturing // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFrontCamera: null == isFrontCamera
                ? _value.isFrontCamera
                : isFrontCamera // ignore: cast_nullable_to_non_nullable
                      as bool,
            zoomLevel: null == zoomLevel
                ? _value.zoomLevel
                : zoomLevel // ignore: cast_nullable_to_non_nullable
                      as double,
            isFlashOn: null == isFlashOn
                ? _value.isFlashOn
                : isFlashOn // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastPhotoPath: freezed == lastPhotoPath
                ? _value.lastPhotoPath
                : lastPhotoPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CameraStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraStateImplCopyWith(
    _$CameraStateImpl value,
    $Res Function(_$CameraStateImpl) then,
  ) = __$$CameraStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isInitialized,
    bool isCapturing,
    bool isFrontCamera,
    double zoomLevel,
    bool isFlashOn,
    String? lastPhotoPath,
    String? errorMessage,
  });
}

/// @nodoc
class __$$CameraStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraStateImpl>
    implements _$$CameraStateImplCopyWith<$Res> {
  __$$CameraStateImplCopyWithImpl(
    _$CameraStateImpl _value,
    $Res Function(_$CameraStateImpl) _then,
  ) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isInitialized = null,
    Object? isCapturing = null,
    Object? isFrontCamera = null,
    Object? zoomLevel = null,
    Object? isFlashOn = null,
    Object? lastPhotoPath = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CameraStateImpl(
        isInitialized: null == isInitialized
            ? _value.isInitialized
            : isInitialized // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCapturing: null == isCapturing
            ? _value.isCapturing
            : isCapturing // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFrontCamera: null == isFrontCamera
            ? _value.isFrontCamera
            : isFrontCamera // ignore: cast_nullable_to_non_nullable
                  as bool,
        zoomLevel: null == zoomLevel
            ? _value.zoomLevel
            : zoomLevel // ignore: cast_nullable_to_non_nullable
                  as double,
        isFlashOn: null == isFlashOn
            ? _value.isFlashOn
            : isFlashOn // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastPhotoPath: freezed == lastPhotoPath
            ? _value.lastPhotoPath
            : lastPhotoPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CameraStateImpl implements _CameraState {
  const _$CameraStateImpl({
    this.isInitialized = false,
    this.isCapturing = false,
    this.isFrontCamera = false,
    this.zoomLevel = 1.0,
    this.isFlashOn = false,
    this.lastPhotoPath,
    this.errorMessage,
  });

  @override
  @JsonKey()
  final bool isInitialized;
  @override
  @JsonKey()
  final bool isCapturing;
  @override
  @JsonKey()
  final bool isFrontCamera;
  @override
  @JsonKey()
  final double zoomLevel;
  @override
  @JsonKey()
  final bool isFlashOn;
  @override
  final String? lastPhotoPath;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CameraState(isInitialized: $isInitialized, isCapturing: $isCapturing, isFrontCamera: $isFrontCamera, zoomLevel: $zoomLevel, isFlashOn: $isFlashOn, lastPhotoPath: $lastPhotoPath, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStateImpl &&
            (identical(other.isInitialized, isInitialized) ||
                other.isInitialized == isInitialized) &&
            (identical(other.isCapturing, isCapturing) ||
                other.isCapturing == isCapturing) &&
            (identical(other.isFrontCamera, isFrontCamera) ||
                other.isFrontCamera == isFrontCamera) &&
            (identical(other.zoomLevel, zoomLevel) ||
                other.zoomLevel == zoomLevel) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.lastPhotoPath, lastPhotoPath) ||
                other.lastPhotoPath == lastPhotoPath) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isInitialized,
    isCapturing,
    isFrontCamera,
    zoomLevel,
    isFlashOn,
    lastPhotoPath,
    errorMessage,
  );

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      __$$CameraStateImplCopyWithImpl<_$CameraStateImpl>(this, _$identity);
}

abstract class _CameraState implements CameraState {
  const factory _CameraState({
    final bool isInitialized,
    final bool isCapturing,
    final bool isFrontCamera,
    final double zoomLevel,
    final bool isFlashOn,
    final String? lastPhotoPath,
    final String? errorMessage,
  }) = _$CameraStateImpl;

  @override
  bool get isInitialized;
  @override
  bool get isCapturing;
  @override
  bool get isFrontCamera;
  @override
  double get zoomLevel;
  @override
  bool get isFlashOn;
  @override
  String? get lastPhotoPath;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
