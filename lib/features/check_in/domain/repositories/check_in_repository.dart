import 'package:glowstate/shared/domain/enums/check_in_type.dart';

import '../entities/check_in.dart';

/// Repository interface for check-in operations
///
/// Uses [CheckInType] from shared domain.
///
/// Implementations should:
/// - Persist check-ins locally (Hive)
/// - Calculate points
/// - Track completion status
abstract class CheckInRepository {
  /// Complete a check-in
  ///
  /// [type] - Morning or night (from shared domain)
  /// [photoId] - Optional linked photo ID
  Future<CheckIn> completeCheckIn({required CheckInType type, String? photoId});

  /// Get all check-ins for a specific date
  Future<List<CheckIn>> getCheckInsForDate(DateTime date);

  /// Get check-ins within a date range
  Future<List<CheckIn>> getCheckInsForDateRange(DateTime start, DateTime end);

  /// Check if a specific check-in type is completed for a date
  Future<bool> hasCompletedCheckIn(DateTime date, CheckInType type);

  /// Get today's morning check-in (if exists)
  Future<CheckIn?> getTodayMorningCheckIn();

  /// Get today's night check-in (if exists)
  Future<CheckIn?> getTodayNightCheckIn();

  /// Get total points earned across all check-ins
  Future<int> getTotalPoints();

  /// Get check-in history for the current cycle (last 30 days)
  Future<List<CheckIn>> getCurrentCycleCheckIns();
}
