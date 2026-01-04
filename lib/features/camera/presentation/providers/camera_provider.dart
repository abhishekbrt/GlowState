import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:glowstate/shared/domain/enums/check_in_type.dart';
import '../../data/providers/camera_repository_provider.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../domain/entities/camera_state.dart';

part 'camera_provider.g.dart';

@riverpod
class Camera extends _$Camera {
  @override
  CameraState build() {
    ref.onDispose(() {
      final repository = ref.read(cameraRepositoryProvider);
      if (repository is CameraRepositoryImpl) {
        repository.dispose();
      }
    });
    return const CameraState();
  }

  Future<void> initialize() async {
    try {
      state = state.copyWith(clearError: true);

      final repository = ref.read(cameraRepositoryProvider);
      await repository.initialize();

      CameraRepositoryImpl? repoImpl;
      if (repository is CameraRepositoryImpl) {
        repoImpl = repository;
      }

      state = state.copyWith(
        isInitialized: true,
        isFrontCamera: repository.isFrontCamera,
        controller: repoImpl?.controller,
      );
    } catch (e) {
      state = state.copyWith(isInitialized: false, error: e.toString());
    }
  }

  Future<void> dispose() async {
    try {
      final repository = ref.read(cameraRepositoryProvider);
      await repository.dispose();
      state = const CameraState();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<String?> capturePhoto() async {
    if (state.isCapturing) return null;

    try {
      state = state.copyWith(isCapturing: true, clearError: true);

      final repository = ref.read(cameraRepositoryProvider);
      final imagePath = await repository.capturePhoto(
        checkInType: _getCurrentCheckInType(),
      );

      state = state.copyWith(isCapturing: false, lastPhotoPath: imagePath);

      return imagePath;
    } catch (e) {
      state = state.copyWith(isCapturing: false, error: e.toString());
      return null;
    }
  }

  Future<void> switchCamera() async {
    try {
      final repository = ref.read(cameraRepositoryProvider);
      await repository.switchCamera();

      CameraRepositoryImpl? repoImpl;
      if (repository is CameraRepositoryImpl) {
        repoImpl = repository;
      }

      state = state.copyWith(
        isFrontCamera: repository.isFrontCamera,
        controller: repoImpl?.controller,
        isFlashOn: repository.isFrontCamera ? false : state.isFlashOn,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> toggleFlash() async {
    try {
      final newFlashState = !state.isFlashOn;
      final repository = ref.read(cameraRepositoryProvider);
      await repository.setFlash(enabled: newFlashState);
      state = state.copyWith(isFlashOn: newFlashState);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> setZoom(double level) async {
    try {
      final repository = ref.read(cameraRepositoryProvider);
      await repository.setZoom(level);
      state = state.copyWith(zoomLevel: level);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  CheckInType _getCurrentCheckInType() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return CheckInType.morning;
    }
    return CheckInType.night;
  }
}
