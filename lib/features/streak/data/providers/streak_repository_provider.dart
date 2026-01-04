import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/streak_repository.dart';
import '../datasources/streak_local_source.dart';
import '../repositories/streak_repository_impl.dart';

/// Provider for [StreakLocalSource]
final streakLocalSourceProvider = Provider<StreakLocalSource>((ref) {
  return StreakLocalSourceImpl();
});

/// Provider for [StreakRepository]
final streakRepositoryProvider = Provider<StreakRepository>((ref) {
  final localSource = ref.watch(streakLocalSourceProvider);
  return StreakRepositoryImpl(localSource: localSource);
});
