import 'package:glowstate/shared/domain/enums/check_in_type.dart';

/// Repository interface for camera operations
///
/// Handles camera hardware interaction only.
/// Photo storage is handled by [PhotoRepository].
///
/// Implementations should:
/// - Manage camera lifecycle
/// - Handle permissions
/// - Capture photos and return file path
abstract class CameraRepository {
  /// Initialize camera hardware
  Future<void> initialize();

  /// Release camera resources
  Future<void> dispose();

  /// Capture a photo and return the file path
  ///
  /// [checkInType] - Morning or night, affects camera settings
  /// Returns the file path of the captured image
  Future<String> capturePhoto({required CheckInType checkInType});

  /// Switch between front and back camera
  Future<void> switchCamera();

  /// Toggle flash
  Future<void> setFlash({required bool enabled});

  /// Set zoom level (1.0 = no zoom)
  Future<void> setZoom(double level);

  /// Whether camera is ready
  bool get isInitialized;

  /// Whether using front camera
  bool get isFrontCamera;
}
