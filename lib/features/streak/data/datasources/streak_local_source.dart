import 'package:hive_flutter/hive_flutter.dart';
import 'package:glowstate/core/constants/hive_constants.dart';
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
  static const String _streakKey = 'current_streak';

  Future<Box> _getBox() async {
    return await Hive.openBox(HiveConstants.streakBox);
  }

  @override
  Future<Streak?> getStreak() async {
    final box = await _getBox();
    final data = box.get(_streakKey);
    if (data == null) return null;

    final map = Map<String, dynamic>.from(data);
    return Streak(
      currentStreak: map['currentStreak'] as int,
      longestStreak: map['longestStreak'] as int,
      lastCheckInDate: map['lastCheckInDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastCheckInDate'] as int)
          : null,
      totalCheckIns: map['totalCheckIns'] as int,
    );
  }

  @override
  Future<void> saveStreak(Streak streak) async {
    final box = await _getBox();
    await box.put(_streakKey, {
      'currentStreak': streak.currentStreak,
      'longestStreak': streak.longestStreak,
      'lastCheckInDate': streak.lastCheckInDate?.millisecondsSinceEpoch,
      'totalCheckIns': streak.totalCheckIns,
    });
  }

  @override
  Future<void> clearStreak() async {
    final box = await _getBox();
    await box.delete(_streakKey);
  }

  @override
  Stream<Streak?> watchStreak() async* {
    final box = await _getBox();
    yield* box.watch(key: _streakKey).map((event) {
      final data = event.value;
      if (data == null) return null;

      final map = Map<String, dynamic>.from(data);
      return Streak(
        currentStreak: map['currentStreak'] as int,
        longestStreak: map['longestStreak'] as int,
        lastCheckInDate: map['lastCheckInDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(map['lastCheckInDate'] as int)
            : null,
        totalCheckIns: map['totalCheckIns'] as int,
      );
    });
  }
}
