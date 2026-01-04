import '../../domain/entities/streak.dart';

/// Local data source for streak persistence
///
/// Uses Hive for local storage
abstract class StreakLocalSource {
  /// Gets streak data from local storage
  Future<Streak?> getStreak();

  /// Saves streak data to local storage
  Future<void> saveStreak(Streak streak);

  /// Clears streak data from local storage
  Future<void> clearStreak();

  /// Stream of streak changes
  Stream<Streak?> watchStreak();
}

/// Implementation of [StreakLocalSource] using Hive
class StreakLocalSourceImpl implements StreakLocalSource {
  @override
  Future<Streak?> getStreak() {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }

  @override
  Future<void> saveStreak(Streak streak) {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }

  @override
  Future<void> clearStreak() {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }

  @override
  Stream<Streak?> watchStreak() {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }
}
