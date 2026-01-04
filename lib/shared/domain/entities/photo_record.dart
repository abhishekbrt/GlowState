import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/check_in_type.dart';

part 'photo_record.freezed.dart';
part 'photo_record.g.dart';

/// Unified photo entity used across all features
///
/// This is the SINGLE SOURCE OF TRUTH for photo data.
/// All features must use this entity for photo operations.
///
/// Used by:
/// - Camera: Creates new PhotoRecord after capture
/// - Photo Gallery: Stores and retrieves photos
/// - Timelapse: Uses photos to generate video
/// - Check-In: Links photo to check-in record
@freezed
class PhotoRecord with _$PhotoRecord {
  const PhotoRecord._();

  const factory PhotoRecord({
    /// Unique identifier (UUID v4)
    required String id,

    /// Absolute path to the photo file on device
    required String filePath,

    /// When the photo was captured
    required DateTime capturedAt,

    /// Which routine this photo belongs to (morning/night)
    required CheckInType checkInType,

    /// Whether photo is excluded from timelapse
    @Default(false) bool isPrivate,

    /// Path to generated thumbnail (for gallery grid)
    String? thumbnailPath,

    /// Day number in the current 30-day cycle (1-30)
    /// Null if not part of an active cycle
    int? cycleDay,

    /// Optional notes or tags
    String? notes,
  }) = _PhotoRecord;

  factory PhotoRecord.fromJson(Map<String, dynamic> json) =>
      _$PhotoRecordFromJson(json);

  /// Creates a new photo for morning routine
  factory PhotoRecord.morning({
    required String id,
    required String filePath,
    int? cycleDay,
  }) => PhotoRecord(
    id: id,
    filePath: filePath,
    capturedAt: DateTime.now(),
    checkInType: CheckInType.morning,
    cycleDay: cycleDay,
  );

  /// Creates a new photo for night routine
  factory PhotoRecord.night({
    required String id,
    required String filePath,
    int? cycleDay,
  }) => PhotoRecord(
    id: id,
    filePath: filePath,
    capturedAt: DateTime.now(),
    checkInType: CheckInType.night,
    cycleDay: cycleDay,
  );

  /// Date only (without time) for grouping
  DateTime get date =>
      DateTime(capturedAt.year, capturedAt.month, capturedAt.day);

  /// Whether this is a morning photo
  bool get isMorning => checkInType == CheckInType.morning;

  /// Whether this is a night photo
  bool get isNight => checkInType == CheckInType.night;
}
