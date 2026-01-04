import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/streak_repository_provider.dart';
import '../../domain/entities/streak.dart';

/// Provider for current streak data
///
/// Automatically validates streak on first access
final streakProvider = FutureProvider<Streak>((ref) async {
  final repository = ref.watch(streakRepositoryProvider);
  return repository.validateStreak();
});

/// Provider for recording a check-in
///
/// Usage: ref.read(recordCheckInProvider.future)
final recordCheckInProvider = FutureProvider<Streak>((ref) async {
  final repository = ref.read(streakRepositoryProvider);
  return repository.recordCheckIn();
});

/// Stream provider for real-time streak updates
final streakStreamProvider = StreamProvider<Streak>((ref) {
  final repository = ref.watch(streakRepositoryProvider);
  return repository.watchStreak();
});

/// Provider for streak display string (e.g., "7 days")
final streakDisplayProvider = Provider<String>((ref) {
  final streakAsync = ref.watch(streakProvider);
  return streakAsync.when(
    data: (streak) {
      if (streak.currentStreak == 0) return 'Start your streak!';
      if (streak.currentStreak == 1) return '1 day';
      return '${streak.currentStreak} days';
    },
    loading: () => '...',
    error: (e, s) => '0 days',
  );
});
