import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowstate/features/camera/presentation/screens/camera_screen.dart';
import 'package:glowstate/features/camera/presentation/screens/photo_preview_screen.dart';
import 'package:glowstate/features/home/presentation/screens/home_screen.dart';
import 'package:glowstate/features/photo_gallery/presentation/screens/gallery_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/gallery',
        name: 'gallery',
        builder: (context, state) => const GalleryScreen(),
      ),
      GoRoute(
        path: '/camera',
        name: 'camera',
        builder: (context, state) => const CameraScreen(),
      ),
      GoRoute(
        path: '/camera/preview',
        name: 'camera-preview',
        builder: (context, state) {
          final imagePath = state.extra as String;
          return PhotoPreviewScreen(imagePath: imagePath);
        },
      ),
    ],
  );
});
