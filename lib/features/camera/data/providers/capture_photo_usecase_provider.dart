import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glowstate/features/camera/data/providers/camera_repository_provider.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/shared/data/providers/event_bus_provider.dart';

import 'package:glowstate/features/camera/domain/usecases/capture_photo_usecase.dart';

/// Provider for [CapturePhotoUseCase]
///
/// This use case orchestrates Camera + Photo Gallery features.
final capturePhotoUseCaseProvider = Provider<CapturePhotoUseCase>((ref) {
  return CapturePhotoUseCase(
    cameraRepository: ref.watch(cameraRepositoryProvider),
    photoRepository: ref.watch(photoRepositoryProvider),
    eventBus: ref.watch(eventBusProvider),
    // TODO: Get current cycle day from cycle provider
    currentCycleDay: null,
  );
});
