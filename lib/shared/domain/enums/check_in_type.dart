/// Type of check-in representing the time of day
///
/// Used across multiple features:
/// - Camera: Determines overlay style
/// - Check-In: Records which routine was completed
/// - Photo Gallery: Filters photos by routine
/// - Notifications: Schedules appropriate reminders
enum CheckInType {
  /// Morning skincare routine (Sunlight in gamification)
  morning,

  /// Night skincare routine (Water in gamification)
  night,
}

extension CheckInTypeX on CheckInType {
  /// Display name for UI
  String get displayName => switch (this) {
    CheckInType.morning => 'Morning',
    CheckInType.night => 'Night',
  };

  /// Gamification element name
  String get elementName => switch (this) {
    CheckInType.morning => 'Sunlight',
    CheckInType.night => 'Water',
  };

  /// Icon name for UI
  String get iconName => switch (this) {
    CheckInType.morning => 'sun',
    CheckInType.night => 'moon',
  };

  /// Points earned for completing this check-in
  int get basePoints => 10;
}
