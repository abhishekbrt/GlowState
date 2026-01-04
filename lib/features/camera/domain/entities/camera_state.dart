import 'package:camera/camera.dart';

/// Camera state for the camera provider
///
/// Note: Not using freezed due to CameraController being non-serializable
class CameraState {
  final bool isInitialized;
  final bool isCapturing;
  final bool isFrontCamera;
  final double zoomLevel;
  final bool isFlashOn;
  final String? lastPhotoPath;
  final String? error;
  final CameraController? controller;

  const CameraState({
    this.isInitialized = false,
    this.isCapturing = false,
    this.isFrontCamera = true,
    this.zoomLevel = 1.0,
    this.isFlashOn = false,
    this.lastPhotoPath,
    this.error,
    this.controller,
  });

  CameraState copyWith({
    bool? isInitialized,
    bool? isCapturing,
    bool? isFrontCamera,
    double? zoomLevel,
    bool? isFlashOn,
    String? lastPhotoPath,
    String? error,
    CameraController? controller,
    bool clearError = false,
    bool clearController = false,
  }) {
    return CameraState(
      isInitialized: isInitialized ?? this.isInitialized,
      isCapturing: isCapturing ?? this.isCapturing,
      isFrontCamera: isFrontCamera ?? this.isFrontCamera,
      zoomLevel: zoomLevel ?? this.zoomLevel,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      lastPhotoPath: lastPhotoPath ?? this.lastPhotoPath,
      error: clearError ? null : (error ?? this.error),
      controller: clearController ? null : (controller ?? this.controller),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CameraState &&
        other.isInitialized == isInitialized &&
        other.isCapturing == isCapturing &&
        other.isFrontCamera == isFrontCamera &&
        other.zoomLevel == zoomLevel &&
        other.isFlashOn == isFlashOn &&
        other.lastPhotoPath == lastPhotoPath &&
        other.error == error &&
        other.controller == controller;
  }

  @override
  int get hashCode {
    return Object.hash(
      isInitialized,
      isCapturing,
      isFrontCamera,
      zoomLevel,
      isFlashOn,
      lastPhotoPath,
      error,
      controller,
    );
  }
}
