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
    // TODO: Implement - initialize camera hardware
    throw UnimplementedError('CameraRepositoryImpl.initialize');
  }

  @override
  Future<void> dispose() async {
    // TODO: Implement - release camera resources
    throw UnimplementedError('CameraRepositoryImpl.dispose');
  }

  @override
  Future<String> capturePhoto({required CheckInType checkInType}) async {
    // TODO: Implement - capture photo and return file path
    // The file path will be used by CapturePhotoUseCase to create PhotoRecord
    throw UnimplementedError('CameraRepositoryImpl.capturePhoto');
  }

  @override
  Future<String?> getLastPhotoPath() async {
    // TODO: Implement - for ghost overlay
    throw UnimplementedError('CameraRepositoryImpl.getLastPhotoPath');
  }

  @override
  Future<void> switchCamera() async {
    // TODO: Implement - toggle front/back
    throw UnimplementedError('CameraRepositoryImpl.switchCamera');
  }

  @override
  Future<void> setFlash({required bool enabled}) async {
    // TODO: Implement - control flash
    throw UnimplementedError('CameraRepositoryImpl.setFlash');
  }

  @override
  Future<void> setZoom(double level) async {
    // TODO: Implement - set zoom level
    throw UnimplementedError('CameraRepositoryImpl.setZoom');
  }

  @override
  bool get isInitialized => localSource.isInitialized;

  @override
  bool get isFrontCamera {
    // TODO: Implement - return current camera
    throw UnimplementedError('CameraRepositoryImpl.isFrontCamera');
  }
}
