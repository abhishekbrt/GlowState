import 'package:freezed_annotation/freezed_annotation.dart';

import 'check_in.dart';
import 'photo_record.dart';

part 'daily_progress.freezed.dart';

/// Represents the user's progress for a single day
///
/// This entity aggregates data from multiple features:
/// - Check-ins (morning and night)
/// - Photos taken
/// - Current streak status
/// - Cycle day information
///
/// Used by:
/// - Home Screen: Shows today's status
/// - Check-In Feature: Updates progress
/// - Streak Feature: Calculates streaks
@freezed
class DailyProgress with _$DailyProgress {
  const DailyProgress._();

  const factory DailyProgress({
    /// The date this progress represents
    required DateTime date,

    /// Morning check-in if completed
    CheckIn? morningCheckIn,

    /// Night check-in if completed
    CheckIn? nightCheckIn,

    /// Current streak count (consecutive days)
    required int currentStreak,

    /// Day number in the 30-day cycle (1-30)
    /// 0 if no active cycle
    @Default(0) int cycleDay,

    /// Photos taken on this day
    @Default([]) List<PhotoRecord> photos,

    /// Total points earned today
    @Default(0) int pointsEarned,
  }) = _DailyProgress;

  /// Whether morning routine is complete
  bool get isMorningComplete => morningCheckIn != null;

  /// Whether night routine is complete
  bool get isNightComplete => nightCheckIn != null;

  /// Whether both routines are complete
  bool get isDayComplete => isMorningComplete && isNightComplete;

  /// Number of completed check-ins (0, 1, or 2)
  int get completedCheckIns =>
      (isMorningComplete ? 1 : 0) + (isNightComplete ? 1 : 0);

  /// Morning photo if exists
  PhotoRecord? get morningPhoto => photos.where((p) => p.isMorning).firstOrNull;

  /// Night photo if exists
  PhotoRecord? get nightPhoto => photos.where((p) => p.isNight).firstOrNull;

  /// Empty progress for a new day
  factory DailyProgress.empty(DateTime date) => DailyProgress(
    date: DateTime(date.year, date.month, date.day),
    currentStreak: 0,
  );

  /// Creates progress for today
  factory DailyProgress.today() => DailyProgress.empty(DateTime.now());
}
