import 'package:glowstate/features/check_in/domain/repositories/check_in_repository.dart';
import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';
import 'package:glowstate/features/streak/domain/repositories/streak_repository.dart';
import 'package:glowstate/shared/domain/entities/daily_progress.dart';

/// Use case for getting today's progress
///
/// This aggregates data from multiple features:
/// - Check-ins (morning/night completion)
/// - Photos taken today
/// - Current streak
///
/// Used by the Home Screen to show today's status.
class GetDailyProgressUseCase {
  GetDailyProgressUseCase({
    required CheckInRepository checkInRepository,
    required PhotoRepository photoRepository,
    required StreakRepository streakRepository,
  }) : _checkInRepository = checkInRepository,
       _photoRepository = photoRepository,
       _streakRepository = streakRepository;

  final CheckInRepository _checkInRepository;
  final PhotoRepository _photoRepository;
  final StreakRepository _streakRepository;

  /// Gets today's progress
  Future<DailyProgress> execute() async {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    // Fetch all data in parallel
    final results = await Future.wait([
      _checkInRepository.getTodayMorningCheckIn(),
      _checkInRepository.getTodayNightCheckIn(),
      _photoRepository.getPhotosByDate(todayDate),
      _streakRepository.getStreak(),
    ]);

    final morningCheckIn = results[0] as dynamic;
    final nightCheckIn = results[1] as dynamic;
    final photos = results[2] as dynamic;
    final streak = results[3] as dynamic;

    // Calculate points earned today
    final pointsEarned =
        (morningCheckIn?.pointsEarned ?? 0) + (nightCheckIn?.pointsEarned ?? 0);

    return DailyProgress(
      date: todayDate,
      morningCheckIn: morningCheckIn,
      nightCheckIn: nightCheckIn,
      currentStreak: streak.currentStreak,
      photos: photos,
      pointsEarned: pointsEarned,
      // TODO: Calculate cycle day from streak data
      cycleDay: (streak.totalCheckIns % 30) + 1,
    );
  }

  /// Gets progress for a specific date
  Future<DailyProgress> executeForDate(DateTime date) async {
    final targetDate = DateTime(date.year, date.month, date.day);

    final results = await Future.wait([
      _checkInRepository.getCheckInsForDate(targetDate),
      _photoRepository.getPhotosByDate(targetDate),
      _streakRepository.getStreak(),
    ]);

    final checkIns = results[0] as List;
    final photos = results[1] as dynamic;
    final streak = results[2] as dynamic;

    final morningCheckIn = checkIns
        .where((c) => c.type.name == 'morning')
        .firstOrNull;
    final nightCheckIn = checkIns
        .where((c) => c.type.name == 'night')
        .firstOrNull;

    return DailyProgress(
      date: targetDate,
      morningCheckIn: morningCheckIn,
      nightCheckIn: nightCheckIn,
      currentStreak: streak.currentStreak,
      photos: photos,
    );
  }
}
