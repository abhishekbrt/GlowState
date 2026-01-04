import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/check_in_type.dart';

part 'check_in.freezed.dart';

/// Represents a completed check-in (morning or night routine)
///
/// This is a shared entity used by multiple features:
/// - Check-In: Creates and manages check-ins
/// - Home: Displays today's check-in status
/// - Streak: Calculates consecutive day streaks
/// - Events: Passed in CheckInCompletedEvent
@freezed
class CheckIn with _$CheckIn {
  const factory CheckIn({
    required String id,
    required DateTime date,
    required CheckInType type,
    required DateTime completedAt,
    @Default(false) bool hasPhoto,
    String? photoId,
    @Default(10) int pointsEarned,
  }) = _CheckIn;
}
