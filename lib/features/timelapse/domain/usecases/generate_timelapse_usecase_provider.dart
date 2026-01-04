import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/features/timelapse/data/providers/timelapse_repository_provider.dart';
import 'package:glowstate/shared/domain/services/event_bus_provider.dart';

import '../usecases/generate_timelapse_usecase.dart';

/// Provider for [GenerateTimelapseUseCase]
///
/// This use case orchestrates Photo Gallery + Timelapse features.
final generateTimelapseUseCaseProvider = Provider<GenerateTimelapseUseCase>((
  ref,
) {
  return GenerateTimelapseUseCase(
    photoRepository: ref.watch(photoRepositoryProvider),
    timelapseRepository: ref.watch(timelapseRepositoryProvider),
    eventBus: ref.watch(eventBusProvider),
  );
});
