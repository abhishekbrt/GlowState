import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/notification_repository_provider.dart';
import '../../domain/entities/notification_settings.dart';

/// Provider for notification settings
final notificationSettingsProvider = FutureProvider<NotificationSettings>((
  ref,
) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.getSettings();
});

/// Provider for notification permission status
final notificationPermissionProvider = FutureProvider<bool>((ref) async {
  final repository = ref.watch(notificationRepositoryProvider);
  return repository.hasPermission();
});

/// Notifier for managing notification settings
class NotificationSettingsNotifier
    extends StateNotifier<AsyncValue<NotificationSettings>> {
  NotificationSettingsNotifier(this._ref) : super(const AsyncValue.loading()) {
    _loadSettings();
  }

  final Ref _ref;

  Future<void> _loadSettings() async {
    state = const AsyncValue.loading();
    try {
      final repository = _ref.read(notificationRepositoryProvider);
      final settings = await repository.getSettings();
      state = AsyncValue.data(settings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSettings(NotificationSettings settings) async {
    try {
      final repository = _ref.read(notificationRepositoryProvider);
      await repository.saveSettings(settings);
      await repository.scheduleNotifications(settings);
      state = AsyncValue.data(settings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<bool> requestPermission() async {
    final repository = _ref.read(notificationRepositoryProvider);
    return repository.requestPermission();
  }

  Future<void> toggleMorningReminder(bool enabled) async {
    final current = state.valueOrNull;
    if (current != null) {
      await updateSettings(current.copyWith(morningReminderEnabled: enabled));
    }
  }

  Future<void> toggleEveningReminder(bool enabled) async {
    final current = state.valueOrNull;
    if (current != null) {
      await updateSettings(current.copyWith(eveningReminderEnabled: enabled));
    }
  }

  Future<void> setMorningTime(DateTime time) async {
    final current = state.valueOrNull;
    if (current != null) {
      await updateSettings(current.copyWith(morningReminderTime: time));
    }
  }

  Future<void> setEveningTime(DateTime time) async {
    final current = state.valueOrNull;
    if (current != null) {
      await updateSettings(current.copyWith(eveningReminderTime: time));
    }
  }
}

/// Provider for notification settings state notifier
final notificationSettingsNotifierProvider =
    StateNotifierProvider<
      NotificationSettingsNotifier,
      AsyncValue<NotificationSettings>
    >((ref) => NotificationSettingsNotifier(ref));
