import 'package:hive_flutter/hive_flutter.dart';
import 'package:glowstate/core/constants/hive_constants.dart';
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
  static const String _settingsKey = 'notification_settings';

  Future<Box> _getBox() async {
    return await Hive.openBox(HiveConstants.settingsBox);
  }

  @override
  Future<NotificationSettings?> getSettings() async {
    final box = await _getBox();
    final data = box.get(_settingsKey);
    if (data == null) return null;

    final map = Map<String, dynamic>.from(data);
    return NotificationSettings(
      morningReminderEnabled: map['morningReminderEnabled'] as bool,
      eveningReminderEnabled: map['eveningReminderEnabled'] as bool,
      morningReminderTime: DateTime.fromMillisecondsSinceEpoch(
        map['morningReminderTime'] as int,
      ),
      eveningReminderTime: DateTime.fromMillisecondsSinceEpoch(
        map['eveningReminderTime'] as int,
      ),
      streakReminderEnabled: map['streakReminderEnabled'] as bool,
    );
  }

  @override
  Future<void> saveSettings(NotificationSettings settings) async {
    final box = await _getBox();
    await box.put(_settingsKey, {
      'morningReminderEnabled': settings.morningReminderEnabled,
      'eveningReminderEnabled': settings.eveningReminderEnabled,
      'morningReminderTime':
          settings.morningReminderTime.millisecondsSinceEpoch,
      'eveningReminderTime':
          settings.eveningReminderTime.millisecondsSinceEpoch,
      'streakReminderEnabled': settings.streakReminderEnabled,
    });
  }

  @override
  Future<void> clearSettings() async {
    final box = await _getBox();
    await box.delete(_settingsKey);
  }
}
