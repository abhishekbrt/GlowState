import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/services/notification_service.dart';
import '../datasources/notification_local_source.dart';

/// Notification ID constants
class NotificationIds {
  static const int morningReminder = 1;
  static const int eveningReminder = 2;
  static const int streakReminder = 3;
}

/// Implementation of [NotificationRepository]
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this.localSource,
    required this.notificationService,
  });

  final NotificationLocalSource localSource;
  final NotificationService notificationService;

  @override
  Future<NotificationSettings> getSettings() async {
    // TODO: Implement - get from local source or return defaults
    throw UnimplementedError();
  }

  @override
  Future<void> saveSettings(NotificationSettings settings) async {
    // TODO: Implement - save to local source and reschedule notifications
    throw UnimplementedError();
  }

  @override
  Future<void> scheduleNotifications(NotificationSettings settings) async {
    // TODO: Implement - schedule based on settings
    // Morning reminder at morningReminderTime
    // Evening reminder at eveningReminderTime
    // Streak reminder in evening if haven't checked in
    throw UnimplementedError();
  }

  @override
  Future<void> cancelAllNotifications() async {
    // TODO: Implement
    throw UnimplementedError();
  }

  @override
  Future<bool> requestPermission() async {
    // TODO: Implement
    throw UnimplementedError();
  }

  @override
  Future<bool> hasPermission() async {
    // TODO: Implement
    throw UnimplementedError();
  }
}
