import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/camera_state.dart';
import '../providers/camera_provider.dart';
import '../widgets/camera_bottom_nav.dart';
import '../widgets/camera_controls.dart';
import '../widgets/camera_preview.dart';
import '../widgets/face_guide_overlay.dart';

/// Main camera screen for capturing daily photos
///
/// Features:
/// - Full-screen camera preview
/// - Face guide overlay for consistent positioning
/// - Top controls for flash and camera switching
/// - Bottom navigation with large capture button
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize camera after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cameraProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraNotifier = ref.read(cameraProvider.notifier);

    // Handle app lifecycle changes for camera
    if (state == AppLifecycleState.inactive) {
      cameraNotifier.dispose();
    } else if (state == AppLifecycleState.resumed) {
      cameraNotifier.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview (full screen)
          _buildCameraPreview(cameraState),

          // Face guide overlay
          const FaceGuideOverlay(),

          // Top controls (flash, switch camera, close)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CameraControls(
              isFlashOn: cameraState.isFlashOn,
              isFrontCamera: cameraState.isFrontCamera,
              onFlashPressed: () {
                ref.read(cameraProvider.notifier).toggleFlash();
              },
              onSwitchCameraPressed: () {
                ref.read(cameraProvider.notifier).switchCamera();
              },
              onClosePressed: () {
                context.pop();
              },
            ),
          ),

          // Bottom navigation with capture button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CameraBottomNav(
              onCapture: cameraState.isInitialized && !cameraState.isCapturing
                  ? () => _capturePhoto()
                  : null,
              isCapturing: cameraState.isCapturing,
            ),
          ),

          // Error overlay
          if (cameraState.error != null) _buildErrorOverlay(cameraState.error!),
        ],
      ),
    );
  }

  Widget _buildCameraPreview(CameraState cameraState) {
    if (!cameraState.isInitialized) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Initializing camera...',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }

    return CameraPreviewWidget(controller: cameraState.controller);
  }

  Widget _buildErrorOverlay(String error) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Camera Error',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(cameraProvider.notifier).initialize();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _capturePhoto() async {
    final imagePath = await ref.read(cameraProvider.notifier).capturePhoto();

    if (imagePath != null && mounted) {
      // Navigate to preview screen with captured image path
      context.push('/camera/preview', extra: imagePath);
    }
  }
}
