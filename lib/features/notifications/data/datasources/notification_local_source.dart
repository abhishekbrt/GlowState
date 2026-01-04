import '../../domain/entities/notification_settings.dart';

/// Local data source for notification settings persistence
abstract class NotificationLocalSource {
  /// Gets notification settings from local storage
  Future<NotificationSettings?> getSettings();

  /// Saves notification settings to local storage
  Future<void> saveSettings(NotificationSettings settings);

  /// Clears notification settings
  Future<void> clearSettings();
}

/// Implementation using Hive
class NotificationLocalSourceImpl implements NotificationLocalSource {
  @override
  Future<NotificationSettings?> getSettings() {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }

  @override
  Future<void> saveSettings(NotificationSettings settings) {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }

  @override
  Future<void> clearSettings() {
    // TODO: Implement using Hive
    throw UnimplementedError();
  }
}
