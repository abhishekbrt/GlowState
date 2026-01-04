import '../../domain/entities/streak.dart';
import '../../domain/repositories/streak_repository.dart';
import '../datasources/streak_local_source.dart';

/// Implementation of [StreakRepository]
///
/// Handles streak calculation logic and delegates persistence to local source
class StreakRepositoryImpl implements StreakRepository {
  StreakRepositoryImpl({required this.localSource});

  final StreakLocalSource localSource;

  @override
  Future<Streak> getStreak() async {
    final streak = await localSource.getStreak();
    return streak ?? Streak.empty();
  }

  @override
  Future<Streak> recordCheckIn() async {
    final current = await getStreak();

    if (current.hasCheckedInToday) {
      return current;
    }

    int newStreak;
    if (current.isActive) {
      // Checked in yesterday, increment streak
      newStreak = current.currentStreak + 1;
    } else {
      // Missed a day (or first time), reset to 1
      newStreak = 1;
    }

    final updated = current.copyWith(
      currentStreak: newStreak,
      longestStreak: newStreak > current.longestStreak
          ? newStreak
          : current.longestStreak,
      lastCheckInDate: DateTime.now(),
      totalCheckIns: current.totalCheckIns + 1,
    );

    await localSource.saveStreak(updated);
    return updated;
  }

  @override
  Future<Streak> validateStreak() async {
    final current = await getStreak();

    // If streak is not active, reset currentStreak to 0 (but keep longest and total)
    if (current.lastCheckInDate != null && !current.isActive) {
      final reset = current.copyWith(currentStreak: 0);
      await localSource.saveStreak(reset);
      return reset;
    }

    return current;
  }

  @override
  Future<void> resetStreak() async {
    await localSource.clearStreak();
  }

  @override
  Stream<Streak> watchStreak() {
    return localSource.watchStreak().map((s) => s ?? Streak.empty());
  }
}
