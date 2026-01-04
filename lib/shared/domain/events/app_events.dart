import '../entities/check_in.dart';
import '../entities/photo_record.dart';
import '../entities/streak.dart';
import '../enums/check_in_type.dart';

/// Base class for all application events
///
/// Events enable loose coupling between features.
/// Features emit events when something important happens,
/// and other features can listen and react.
sealed class AppEvent {
  const AppEvent();

  /// When the event was created
  DateTime get timestamp => DateTime.now();
}

/// Emitted when a photo is captured and saved
///
/// Listeners:
/// - Photo Gallery: Adds to local storage
/// - Check-In: Can link photo to check-in
class PhotoCapturedEvent extends AppEvent {
  const PhotoCapturedEvent({required this.photo});

  /// The captured photo
  final PhotoRecord photo;

  @override
  String toString() => 'PhotoCapturedEvent(photo: ${photo.id})';
}

/// Emitted when a check-in is completed
///
/// Listeners:
/// - Streak: Updates streak count
/// - Notifications: Reschedules reminders
/// - Home: Refreshes UI
class CheckInCompletedEvent extends AppEvent {
  const CheckInCompletedEvent({required this.checkIn, this.photo});

  /// The completed check-in
  final CheckIn checkIn;

  /// Photo taken with the check-in (if any)
  final PhotoRecord? photo;

  /// Whether this was a morning check-in
  bool get isMorning => checkIn.type == CheckInType.morning;

  @override
  String toString() => 'CheckInCompletedEvent(type: ${checkIn.type})';
}

/// Emitted when streak is updated
///
/// Listeners:
/// - Home: Updates streak display
/// - Notifications: Adjusts streak-at-risk reminders
class StreakUpdatedEvent extends AppEvent {
  const StreakUpdatedEvent({required this.streak});

  /// Updated streak data
  final Streak streak;

  /// Whether streak increased
  bool get increased => streak.currentStreak > 0;

  /// Whether streak was broken (reset to 0)
  bool get broken => streak.currentStreak == 0;

  @override
  String toString() => 'StreakUpdatedEvent(streak: ${streak.currentStreak})';
}

/// Emitted when a 30-day cycle is completed
///
/// Listeners:
/// - Timelapse: Auto-generates "Glow Up" video
/// - Notifications: Sends celebration notification
class CycleCompletedEvent extends AppEvent {
  const CycleCompletedEvent({required this.cycleNumber, required this.photos});

  /// Which cycle was completed (1, 2, 3, ...)
  final int cycleNumber;

  /// All photos from the completed cycle
  final List<PhotoRecord> photos;

  /// Number of photos in the cycle
  int get photoCount => photos.length;

  @override
  String toString() => 'CycleCompletedEvent(cycle: $cycleNumber)';
}

/// Emitted when user earns points
///
/// Listeners:
/// - Home: Shows points animation
/// - Gamification: Updates total points
class PointsEarnedEvent extends AppEvent {
  const PointsEarnedEvent({required this.points, required this.reason});

  /// Points earned
  final int points;

  /// Why points were earned
  final String reason;

  @override
  String toString() => 'PointsEarnedEvent(points: $points)';
}

/// Emitted when timelapse generation completes
///
/// Listeners:
/// - Gallery: Adds timelapse to collection
/// - Notifications: Notifies user
class TimelapseGeneratedEvent extends AppEvent {
  const TimelapseGeneratedEvent({
    required this.videoPath,
    required this.photoCount,
  });

  /// Path to generated video
  final String videoPath;

  /// Number of photos used
  final int photoCount;

  @override
  String toString() => 'TimelapseGeneratedEvent(photos: $photoCount)';
}
