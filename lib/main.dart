import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:glowstate/app.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/features/notifications/data/providers/notification_repository_provider.dart';
import 'package:glowstate/features/notifications/data/services/local_notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Run app immediately with the initializer
  runApp(const AppInitializer());
}

/// A wrapper widget that handles asynchronous initialization of Hive and Services
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late Future<List<Override>> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = _initializeServices();
  }

  Future<List<Override>> _initializeServices() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();

      // Register adapters
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(PhotoModelAdapter());
      }

      // Open boxes
      final photoBox = await Hive.openBox<PhotoModel>('photos');

      // Initialize Notifications
      final notificationService = LocalNotificationService();
      await notificationService.initialize();

      return [
        photoBoxProvider.overrideWithValue(photoBox),
        notificationServiceProvider.overrideWithValue(notificationService),
      ];
    } catch (e) {
      debugPrint('Initialization error: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Override>>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // Show a simple splash screen while initializing
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 24),
                    Text(
                      'GlowState',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Initialization Failed',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(snapshot.error.toString()),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _initFuture = _initializeServices();
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // Only one ProviderScope here, at the root of the actual app logic
        return ProviderScope(
          overrides: snapshot.data!,
          child: const GlowStateApp(),
        );
      },
    );
  }
}
