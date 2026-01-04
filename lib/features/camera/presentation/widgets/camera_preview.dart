import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

/// Widget that displays the camera preview feed
///
/// Wraps [CameraPreview] from the camera package with proper
/// aspect ratio handling and loading states.
class CameraPreviewWidget extends StatelessWidget {
  /// The camera controller to display preview from
  final CameraController? controller;

  /// Widget to show while camera is loading
  final Widget? loadingWidget;

  /// Widget to show when camera has error
  final Widget? errorWidget;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    this.loadingWidget,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return loadingWidget ??
          const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (controller!.value.hasError) {
      return errorWidget ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Camera Error',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  controller!.value.errorDescription ?? 'Unknown error',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
    }

    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller!.value.previewSize?.height ?? 0,
            height: controller!.value.previewSize?.width ?? 0,
            child: CameraPreview(controller!),
          ),
        ),
      ),
    );
  }
}
