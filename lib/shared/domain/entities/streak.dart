/// Streak entity representing user's consecutive check-in days
///
/// This is a shared entity used by multiple features:
/// - Streak: Manages streak calculations
/// - Home: Displays current streak
/// - Events: Passed in StreakUpdatedEvent
/// - Notifications: Streak-at-risk reminders
class Streak {
  const Streak({
    required this.currentStreak,
    required this.longestStreak,
    required this.lastCheckInDate,
    required this.totalCheckIns,
  });

  /// Current consecutive days streak
  final int currentStreak;

  /// Longest streak ever achieved
  final int longestStreak;

  /// Date of the last check-in (null if never checked in)
  final DateTime? lastCheckInDate;

  /// Total number of check-ins
  final int totalCheckIns;

  /// Returns true if streak is active (checked in today or yesterday)
  bool get isActive {
    if (lastCheckInDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastCheckIn = DateTime(
      lastCheckInDate!.year,
      lastCheckInDate!.month,
      lastCheckInDate!.day,
    );
    final difference = today.difference(lastCheckIn).inDays;
    return difference <= 1;
  }

  /// Returns true if user has checked in today
  bool get hasCheckedInToday {
    if (lastCheckInDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastCheckIn = DateTime(
      lastCheckInDate!.year,
      lastCheckInDate!.month,
      lastCheckInDate!.day,
    );
    return today.isAtSameMomentAs(lastCheckIn);
  }

  /// Creates an empty streak (new user)
  factory Streak.empty() => const Streak(
    currentStreak: 0,
    longestStreak: 0,
    lastCheckInDate: null,
    totalCheckIns: 0,
  );

  Streak copyWith({
    int? currentStreak,
    int? longestStreak,
    DateTime? lastCheckInDate,
    int? totalCheckIns,
  }) {
    return Streak(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastCheckInDate: lastCheckInDate ?? this.lastCheckInDate,
      totalCheckIns: totalCheckIns ?? this.totalCheckIns,
    );
  }
}
