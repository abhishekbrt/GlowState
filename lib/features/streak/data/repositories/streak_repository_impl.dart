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
  Future<Streak> getStreak() {
    // TODO: Implement - get from local source or return empty
    throw UnimplementedError();
  }

  @override
  Future<Streak> recordCheckIn() {
    // TODO: Implement streak logic:
    // 1. Get current streak
    // 2. If already checked in today, return current
    // 3. If checked in yesterday, increment streak
    // 4. If missed a day, reset to 1
    // 5. Update longest streak if needed
    // 6. Save and return
    throw UnimplementedError();
  }

  @override
  Future<Streak> validateStreak() {
    // TODO: Implement - check if streak should be reset due to missed day
    throw UnimplementedError();
  }

  @override
  Future<void> resetStreak() {
    // TODO: Implement - clear streak data
    throw UnimplementedError();
  }

  @override
  Stream<Streak> watchStreak() {
    // TODO: Implement - return stream from local source
    throw UnimplementedError();
  }
}
