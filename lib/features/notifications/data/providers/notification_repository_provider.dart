import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/notification_repository.dart';
import '../../domain/services/notification_service.dart';
import '../datasources/notification_local_source.dart';
import '../repositories/notification_repository_impl.dart';

/// Provider for [NotificationService]
///
/// Must be overridden with platform-specific implementation
final notificationServiceProvider = Provider<NotificationService>((ref) {
  // This should be overridden in main.dart with actual implementation
  throw UnimplementedError(
    'notificationServiceProvider must be overridden with platform implementation',
  );
});

/// Provider for [NotificationLocalSource]
final notificationLocalSourceProvider = Provider<NotificationLocalSource>((
  ref,
) {
  return NotificationLocalSourceImpl();
});

/// Provider for [NotificationRepository]
final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final localSource = ref.watch(notificationLocalSourceProvider);
  final notificationService = ref.watch(notificationServiceProvider);
  return NotificationRepositoryImpl(
    localSource: localSource,
    notificationService: notificationService,
  );
});
