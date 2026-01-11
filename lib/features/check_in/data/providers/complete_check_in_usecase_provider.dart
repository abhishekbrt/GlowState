import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glowstate/features/check_in/data/providers/check_in_repository_provider.dart';
import 'package:glowstate/features/streak/data/providers/streak_repository_provider.dart';
import 'package:glowstate/shared/data/providers/event_bus_provider.dart';

import 'package:glowstate/features/check_in/domain/usecases/complete_check_in_usecase.dart';

/// Provider for [CompleteCheckInUseCase]
///
/// This use case orchestrates Check-In + Streak features.
final completeCheckInUseCaseProvider = Provider<CompleteCheckInUseCase>((ref) {
  return CompleteCheckInUseCase(
    checkInRepository: ref.watch(checkInRepositoryProvider),
    streakRepository: ref.watch(streakRepositoryProvider),
    eventBus: ref.watch(eventBusProvider),
  );
});
