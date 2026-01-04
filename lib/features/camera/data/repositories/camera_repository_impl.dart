import 'package:camera/camera.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';

import '../../domain/repositories/camera_repository.dart';
import '../datasources/camera_local_source.dart';

/// Implementation of [CameraRepository]
///
/// Handles camera hardware interaction. Photo storage is delegated
/// to PhotoRepository via use cases.
class CameraRepositoryImpl implements CameraRepository {
  final CameraLocalSource localSource;

  CameraRepositoryImpl({required this.localSource});

  @override
  Future<void> initialize() async {
    await localSource.initializeCamera();
  }

  @override
  Future<void> dispose() async {
    await localSource.disposeCamera();
  }

  @override
  Future<String> capturePhoto({required CheckInType checkInType}) async {
    // Capture the image and return the temp file path
    // The UseCase will handle creating PhotoRecord and saving to Gallery
    return await localSource.captureImage();
  }

  @override
  Future<String?> getLastPhotoPath() async {
    // TODO: Integrate with PhotoRepository when Gallery is implemented
    // For now, return null (no ghost overlay)
    return null;
  }

  @override
  Future<void> switchCamera() async {
    await localSource.switchCamera();
  }

  @override
  Future<void> setFlash({required bool enabled}) async {
    await localSource.setFlash(enabled: enabled);
  }

  @override
  Future<void> setZoom(double level) async {
    await localSource.setZoom(level);
  }

  @override
  bool get isInitialized => localSource.isInitialized;

  @override
  bool get isFrontCamera => localSource.isFrontCamera;

  /// Get the camera controller for preview widget
  CameraController? get controller => localSource.controller;
}
