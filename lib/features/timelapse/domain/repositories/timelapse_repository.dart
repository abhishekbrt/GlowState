import 'package:glowstate/shared/domain/entities/photo_record.dart';

import '../entities/timelapse.dart';

/// Repository interface for timelapse generation
///
/// Uses [PhotoRecord] from shared domain for input photos.
///
/// Implementations should:
/// - Use FFmpeg for video generation
/// - Handle progress reporting
/// - Store generated videos
abstract class TimelapseRepository {
  /// Generate a timelapse video from photos
  ///
  /// [photos] - List of photos to include (uses shared PhotoRecord)
  /// Returns the generated timelapse metadata
  Future<Timelapse> generate({required List<PhotoRecord> photos, int fps = 10});

  /// Generate timelapse with progress callback
  Stream<TimelapseProgress> generateWithProgress({
    required List<PhotoRecord> photos,
    int fps = 10,
  });

  /// Get all generated timelapses
  Future<List<Timelapse>> getAllTimelapses();

  /// Get a specific timelapse by ID
  Future<Timelapse?> getTimelapseById(String id);

  /// Delete a timelapse
  Future<void> deleteTimelapse(String id);

  /// Check if timelapse generation is supported
  Future<bool> isSupported();
}

/// Progress update during timelapse generation
class TimelapseProgress {
  const TimelapseProgress({
    required this.currentFrame,
    required this.totalFrames,
    required this.percentage,
    this.message,
  });

  final int currentFrame;
  final int totalFrames;
  final double percentage;
  final String? message;

  bool get isComplete => currentFrame >= totalFrames;
}
