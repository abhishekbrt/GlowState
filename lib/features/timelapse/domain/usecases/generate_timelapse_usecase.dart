import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';
import 'package:glowstate/features/timelapse/domain/entities/timelapse.dart';
import 'package:glowstate/features/timelapse/domain/repositories/timelapse_repository.dart';
import 'package:glowstate/shared/domain/events/app_events.dart';
import 'package:glowstate/shared/domain/services/event_bus.dart';

/// Use case for generating a timelapse video
///
/// This orchestrates:
/// 1. Fetching photos from gallery
/// 2. Video generation
/// 3. Event emission
///
/// Juniors implement [PhotoRepository] and [TimelapseRepository] separately.
/// This use case ensures they work together correctly.
class GenerateTimelapseUseCase {
  GenerateTimelapseUseCase({
    required PhotoRepository photoRepository,
    required TimelapseRepository timelapseRepository,
    required EventBus eventBus,
  }) : _photoRepository = photoRepository,
       _timelapseRepository = timelapseRepository,
       _eventBus = eventBus;

  final PhotoRepository _photoRepository;
  final TimelapseRepository _timelapseRepository;
  final EventBus _eventBus;

  /// Generates a timelapse from photos
  ///
  /// [includePrivate] - Whether to include private photos
  /// [fps] - Frames per second for the video
  /// Returns the generated [Timelapse]
  Future<Timelapse> execute({bool includePrivate = false, int fps = 10}) async {
    // 1. Get photos from gallery
    final photos = await _photoRepository.getPhotosForTimelapse(
      includePrivate: includePrivate,
    );

    if (photos.isEmpty) {
      throw NoPhotosForTimelapseException();
    }

    if (photos.length < 3) {
      throw InsufficientPhotosException(count: photos.length);
    }

    // 2. Check if generation is supported
    final isSupported = await _timelapseRepository.isSupported();
    if (!isSupported) {
      throw TimelapseNotSupportedException();
    }

    // 3. Generate timelapse
    final timelapse = await _timelapseRepository.generate(
      photos: photos,
      fps: fps,
    );

    // 4. Emit event
    _eventBus.emit(
      TimelapseGeneratedEvent(
        videoPath: timelapse.videoPath,
        photoCount: photos.length,
      ),
    );

    return timelapse;
  }

  /// Generate with progress updates
  Stream<TimelapseProgress> executeWithProgress({
    bool includePrivate = false,
    int fps = 10,
  }) async* {
    final photos = await _photoRepository.getPhotosForTimelapse(
      includePrivate: includePrivate,
    );

    if (photos.isEmpty) {
      throw NoPhotosForTimelapseException();
    }

    yield* _timelapseRepository.generateWithProgress(photos: photos, fps: fps);
  }
}

/// Exception when no photos are available for timelapse
class NoPhotosForTimelapseException implements Exception {
  @override
  String toString() => 'NoPhotosForTimelapseException: No photos available';
}

/// Exception when not enough photos for timelapse
class InsufficientPhotosException implements Exception {
  const InsufficientPhotosException({required this.count});
  final int count;

  @override
  String toString() =>
      'InsufficientPhotosException: Need at least 3 photos, have $count';
}

/// Exception when timelapse generation is not supported
class TimelapseNotSupportedException implements Exception {
  @override
  String toString() =>
      'TimelapseNotSupportedException: FFmpeg not available on this device';
}
