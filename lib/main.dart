import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowstate/app.dart';
import 'package:glowstate/features/notifications/data/providers/notification_repository_provider.dart';
import 'package:glowstate/features/notifications/data/services/local_notification_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize Notifications
  final notificationService = LocalNotificationService();
  await notificationService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        notificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: const GlowStateApp(),
    ),
  );
}
