import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    @Default(false) bool isInitialized,
    @Default(false) bool isCapturing,
    @Default(false) bool isFrontCamera,
    @Default(1.0) double zoomLevel,
    @Default(false) bool isFlashOn,
    String? lastPhotoPath,
    String? errorMessage,
  }) = _CameraState;
}
