import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen to preview a captured photo before using or retaking
///
/// Displays the captured image full-screen with options to:
/// - Retake: Delete the temp file and go back to camera
/// - Use Photo: Accept the photo and return to home (no save for now)
class PhotoPreviewScreen extends ConsumerWidget {
  /// Path to the captured image file
  final String imagePath;

  const PhotoPreviewScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full screen image preview
          _buildImagePreview(),

          // Top bar with close button
          Positioned(top: 0, left: 0, right: 0, child: _buildTopBar(context)),

          // Bottom action buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    final file = File(imagePath);

    if (!file.existsSync()) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, color: Colors.white54, size: 64),
            SizedBox(height: 16),
            Text('Image not found', style: TextStyle(color: Colors.white70)),
          ],
        ),
      );
    }

    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 64),
              SizedBox(height: 16),
              Text(
                'Failed to load image',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close button
            Material(
              color: Colors.black.withValues(alpha: 0.3),
              shape: const CircleBorder(),
              child: InkWell(
                onTap: () => _handleClose(context),
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.close, color: Colors.white, size: 24),
                ),
              ),
            ),

            // Preview label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Preview',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Spacer for symmetry
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Retake button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: OutlinedButton.icon(
                  onPressed: () => _handleRetake(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Retake',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),

            // Use Photo button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ElevatedButton.icon(
                  onPressed: () => _handleUsePhoto(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text(
                    'Use Photo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRetake(BuildContext context) {
    // Delete the temp file
    _deleteTemporaryFile();

    // Go back to camera
    context.pop();
  }

  void _handleUsePhoto(BuildContext context) {
    // For now, just go back to home
    // TODO: Integrate with CapturePhotoUseCase to save to gallery
    // and create PhotoRecord when Gallery feature is implemented

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Photo captured! (Gallery integration coming soon)'),
        duration: Duration(seconds: 2),
      ),
    );

    // Navigate back to home
    context.go('/');
  }

  void _handleClose(BuildContext context) {
    // Delete temp file and go home
    _deleteTemporaryFile();
    context.go('/');
  }

  void _deleteTemporaryFile() {
    try {
      final file = File(imagePath);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } catch (e) {
      // Silently fail - temp files will be cleaned up eventually
      debugPrint('Failed to delete temp file: $e');
    }
  }
}
