import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glowstate/features/check_in/data/providers/check_in_repository_provider.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/features/streak/data/providers/streak_repository_provider.dart';

import 'package:glowstate/features/home/domain/usecases/get_daily_progress_usecase.dart';

/// Provider for [GetDailyProgressUseCase]
///
/// This use case aggregates data from Check-In, Photo Gallery, and Streak.
final getDailyProgressUseCaseProvider = Provider<GetDailyProgressUseCase>((
  ref,
) {
  return GetDailyProgressUseCase(
    checkInRepository: ref.watch(checkInRepositoryProvider),
    photoRepository: ref.watch(photoRepositoryProvider),
    streakRepository: ref.watch(streakRepositoryProvider),
  );
});
