import 'package:glowstate/shared/domain/entities/photo_record.dart';

/// Repository interface for photo storage and retrieval
///
/// This repository uses [PhotoRecord] from shared domain.
/// All features should use this single photo type.
///
/// Implementations should handle:
/// - Local file storage
/// - Thumbnail generation
/// - Metadata persistence (Hive)
abstract class PhotoRepository {
  /// Gets all photos for a specific date
  Future<List<PhotoRecord>> getPhotosByDate(DateTime date);

  /// Gets photos within a date range
  Future<List<PhotoRecord>> getPhotosByDateRange(DateTime start, DateTime end);

  /// Gets all photos for a calendar month
  Future<List<PhotoRecord>> getPhotosForMonth(int year, int month);

  /// Gets photos suitable for timelapse generation
  ///
  /// [includePrivate] - If false, excludes photos marked as private
  Future<List<PhotoRecord>> getPhotosForTimelapse({bool includePrivate = true});

  /// Saves a new photo record
  Future<PhotoRecord> savePhoto(PhotoRecord photo);

  /// Deletes a photo by ID
  Future<void> deletePhoto(String id);

  /// Updates photo privacy setting
  Future<void> updatePhotoPrivacy(String id, {required bool isPrivate});

  /// Gets the most recent photo (for ghost overlay)
  Future<PhotoRecord?> getLatestPhoto();

  /// Gets the latest photo of a specific type (morning/night)
  Future<PhotoRecord?> getLatestPhotoByType(
    /// Use CheckInType from shared domain
    dynamic checkInType,
  );

  /// Gets total photo count
  Future<int> getPhotoCount();

  /// Gets photos for a specific cycle day
  Future<List<PhotoRecord>> getPhotosByCycleDay(int cycleDay);
}
