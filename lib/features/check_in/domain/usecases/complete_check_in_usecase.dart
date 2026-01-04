import 'package:glowstate/features/check_in/domain/entities/check_in.dart';
import 'package:glowstate/features/check_in/domain/repositories/check_in_repository.dart';
import 'package:glowstate/features/streak/domain/repositories/streak_repository.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';
import 'package:glowstate/shared/domain/events/app_events.dart';
import 'package:glowstate/shared/domain/services/event_bus.dart';

/// Use case for completing a check-in
///
/// This orchestrates:
/// 1. Check-in creation and storage
/// 2. Streak update
/// 3. Points calculation
/// 4. Event emission
///
/// Juniors implement [CheckInRepository] and [StreakRepository] separately.
/// This use case ensures they work together correctly.
class CompleteCheckInUseCase {
  CompleteCheckInUseCase({
    required CheckInRepository checkInRepository,
    required StreakRepository streakRepository,
    required EventBus eventBus,
  }) : _checkInRepository = checkInRepository,
       _streakRepository = streakRepository,
       _eventBus = eventBus;

  final CheckInRepository _checkInRepository;
  final StreakRepository _streakRepository;
  final EventBus _eventBus;

  /// Completes a check-in with optional photo
  ///
  /// [checkInType] - Morning or night
  /// [photo] - Optional photo taken with this check-in
  /// Returns the created [CheckIn]
  Future<CheckIn> execute({
    required CheckInType checkInType,
    PhotoRecord? photo,
  }) async {
    // 1. Check if already completed today
    final alreadyCompleted = await _checkInRepository.hasCompletedCheckIn(
      DateTime.now(),
      checkInType,
    );

    if (alreadyCompleted) {
      throw CheckInAlreadyCompletedException(type: checkInType);
    }

    // 2. Create check-in
    final checkIn = await _checkInRepository.completeCheckIn(
      type: checkInType,
      photoId: photo?.id,
    );

    // 3. Update streak
    final streak = await _streakRepository.recordCheckIn();

    // 4. Emit events
    _eventBus.emit(CheckInCompletedEvent(checkIn: checkIn, photo: photo));
    _eventBus.emit(StreakUpdatedEvent(streak: streak));
    _eventBus.emit(
      PointsEarnedEvent(
        points: checkIn.pointsEarned,
        reason: '${checkInType.displayName} check-in completed',
      ),
    );

    return checkIn;
  }
}

/// Exception thrown when trying to complete an already-completed check-in
class CheckInAlreadyCompletedException implements Exception {
  const CheckInAlreadyCompletedException({required this.type});

  final CheckInType type;

  @override
  String toString() =>
      'CheckInAlreadyCompletedException: ${type.displayName} already completed today';
}
