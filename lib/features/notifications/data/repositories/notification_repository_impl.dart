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
    final settings = await localSource.getSettings();
    return settings ?? NotificationSettings.defaults();
  }

  @override
  Future<void> saveSettings(NotificationSettings settings) async {
    await localSource.saveSettings(settings);
    await scheduleNotifications(settings);
  }

  @override
  Future<void> scheduleNotifications(NotificationSettings settings) async {
    // Cancel existing first to avoid duplicates
    await cancelAllNotifications();

    if (settings.morningReminderEnabled) {
      await notificationService.scheduleNotification(
        id: NotificationIds.morningReminder,
        title: 'Good Morning!',
        body: "Time for your morning skincare routine. Let's glow!",
        scheduledTime: settings.morningReminderTime,
        repeatsDaily: true,
      );
    }

    if (settings.eveningReminderEnabled) {
      await notificationService.scheduleNotification(
        id: NotificationIds.eveningReminder,
        title: 'Evening Routine',
        body: 'Don\'t forget your night check-in. Your skin will thank you!',
        scheduledTime: settings.eveningReminderTime,
        repeatsDaily: true,
      );
    }

    // Streak reminder could be complex, for now we just schedule it
    // but in a real app we might want to only show it if they haven't checked in by a certain time
    if (settings.streakReminderEnabled) {
      // Logic for streak reminder (e.g., 2 hours before evening routine if not done)
      // For shell, we just schedule it at a fixed late hour
      final lateHour = DateTime(
        settings.eveningReminderTime.year,
        settings.eveningReminderTime.month,
        settings.eveningReminderTime.day,
        22,
        30,
      );
      await notificationService.scheduleNotification(
        id: NotificationIds.streakReminder,
        title: 'Streak at Risk!',
        body: 'Quick! Complete your check-in now to save your streak.',
        scheduledTime: lateHour,
        repeatsDaily: true,
      );
    }
  }

  @override
  Future<void> cancelAllNotifications() async {
    await notificationService.cancelAllNotifications();
  }

  @override
  Future<bool> requestPermission() async {
    return await notificationService.requestPermission();
  }

  @override
  Future<bool> hasPermission() async {
    return await notificationService.hasPermission();
  }
}
