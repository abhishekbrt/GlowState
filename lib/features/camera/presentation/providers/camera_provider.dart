import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/camera/data/providers/camera_repository_provider.dart';
import 'package:glowstate/features/camera/domain/entities/camera_state.dart';
import 'package:glowstate/features/camera/domain/entities/captured_photo.dart';

part 'camera_provider.g.dart';

@riverpod
class Camera extends _$Camera {
  @override
  CameraState build() {
    return const CameraState();
  }

  Future<void> initialize() async {
    throw UnimplementedError('CameraProvider.initialize');
  }

  Future<void> dispose() async {
    throw UnimplementedError('CameraProvider.dispose');
  }

  Future<CapturedPhoto?> capturePhoto({required bool isMorning}) async {
    throw UnimplementedError('CameraProvider.capturePhoto');
  }

  Future<void> switchCamera() async {
    throw UnimplementedError('CameraProvider.switchCamera');
  }

  Future<void> toggleFlash() async {
    throw UnimplementedError('CameraProvider.toggleFlash');
  }

  Future<void> setZoom(double level) async {
    throw UnimplementedError('CameraProvider.setZoom');
  }
}

@riverpod
Future<String?> ghostOverlayPath(GhostOverlayPathRef ref) async {
  final repository = ref.watch(cameraRepositoryProvider);
  return repository.getLastPhotoPath();
}
