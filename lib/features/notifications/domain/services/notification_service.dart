/// Service interface for local push notifications
///
/// Implementations should handle platform-specific notification APIs
abstract class NotificationService {
  /// Initializes the notification service
  Future<void> initialize();

  /// Shows an immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  });

  /// Schedules a notification for a specific time
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required bool repeatsDaily,
  });

  /// Cancels a specific scheduled notification
  Future<void> cancelNotification(int id);

  /// Cancels all scheduled notifications
  Future<void> cancelAllNotifications();

  /// Requests permission to show notifications
  Future<bool> requestPermission();

  /// Checks if permission is granted
  Future<bool> hasPermission();
}
