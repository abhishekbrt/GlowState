import '../entities/notification_settings.dart';

/// Repository interface for notification operations
abstract class NotificationRepository {
  /// Gets current notification settings
  Future<NotificationSettings> getSettings();

  /// Saves notification settings
  Future<void> saveSettings(NotificationSettings settings);

  /// Schedules all enabled notifications based on settings
  Future<void> scheduleNotifications(NotificationSettings settings);

  /// Cancels all scheduled notifications
  Future<void> cancelAllNotifications();

  /// Requests notification permission from user
  Future<bool> requestPermission();

  /// Checks if notification permission is granted
  Future<bool> hasPermission();
}
