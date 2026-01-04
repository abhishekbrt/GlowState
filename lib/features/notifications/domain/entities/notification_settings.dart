/// Notification settings entity
class NotificationSettings {
  const NotificationSettings({
    required this.morningReminderEnabled,
    required this.eveningReminderEnabled,
    required this.morningReminderTime,
    required this.eveningReminderTime,
    required this.streakReminderEnabled,
  });

  /// Whether morning skincare reminder is enabled
  final bool morningReminderEnabled;

  /// Whether evening skincare reminder is enabled
  final bool eveningReminderEnabled;

  /// Time for morning reminder (hour and minute)
  final DateTime morningReminderTime;

  /// Time for evening reminder (hour and minute)
  final DateTime eveningReminderTime;

  /// Whether to send reminder when streak is at risk
  final bool streakReminderEnabled;

  /// Default notification settings
  factory NotificationSettings.defaults() {
    final now = DateTime.now();
    return NotificationSettings(
      morningReminderEnabled: true,
      eveningReminderEnabled: true,
      morningReminderTime: DateTime(now.year, now.month, now.day, 8, 0), // 8 AM
      eveningReminderTime: DateTime(
        now.year,
        now.month,
        now.day,
        21,
        0,
      ), // 9 PM
      streakReminderEnabled: true,
    );
  }

  NotificationSettings copyWith({
    bool? morningReminderEnabled,
    bool? eveningReminderEnabled,
    DateTime? morningReminderTime,
    DateTime? eveningReminderTime,
    bool? streakReminderEnabled,
  }) {
    return NotificationSettings(
      morningReminderEnabled:
          morningReminderEnabled ?? this.morningReminderEnabled,
      eveningReminderEnabled:
          eveningReminderEnabled ?? this.eveningReminderEnabled,
      morningReminderTime: morningReminderTime ?? this.morningReminderTime,
      eveningReminderTime: eveningReminderTime ?? this.eveningReminderTime,
      streakReminderEnabled:
          streakReminderEnabled ?? this.streakReminderEnabled,
    );
  }
}
