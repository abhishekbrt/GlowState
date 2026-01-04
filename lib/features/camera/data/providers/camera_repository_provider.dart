import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/camera/data/datasources/camera_local_source.dart';
import 'package:glowstate/features/camera/data/repositories/camera_repository_impl.dart';
import 'package:glowstate/features/camera/domain/repositories/camera_repository.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';

part 'camera_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CameraLocalSource cameraLocalSource(CameraLocalSourceRef ref) {
  return CameraLocalSourceImpl();
}

@Riverpod(keepAlive: true)
CameraRepository cameraRepository(CameraRepositoryRef ref) {
  return CameraRepositoryImpl(
    localSource: ref.watch(cameraLocalSourceProvider),
    photoRepository: ref.watch(photoRepositoryProvider),
  );
}
