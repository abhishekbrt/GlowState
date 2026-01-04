import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:glowstate/app.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(PhotoModelAdapter());

  // Open boxes
  final photoBox = await Hive.openBox<PhotoModel>('photos');

  runApp(
    ProviderScope(
      overrides: [photoBoxProvider.overrideWithValue(photoBox)],
      child: const GlowStateApp(),
    ),
  );
}
