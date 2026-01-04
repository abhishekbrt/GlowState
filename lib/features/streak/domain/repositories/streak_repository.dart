import '../entities/streak.dart';

/// Repository interface for streak operations
///
/// Implementations should handle:
/// - Persisting streak data locally
/// - Calculating streak based on check-in history
/// - Resetting streak when a day is missed
abstract class StreakRepository {
  /// Gets the current streak data for the user
  Future<Streak> getStreak();

  /// Records a check-in and updates streak accordingly
  ///
  /// Returns the updated streak after recording the check-in
  Future<Streak> recordCheckIn();

  /// Validates and potentially resets streak if a day was missed
  ///
  /// Should be called on app launch to ensure streak accuracy
  Future<Streak> validateStreak();

  /// Resets all streak data (for testing or user request)
  Future<void> resetStreak();

  /// Stream of streak updates for real-time UI updates
  Stream<Streak> watchStreak();
}
