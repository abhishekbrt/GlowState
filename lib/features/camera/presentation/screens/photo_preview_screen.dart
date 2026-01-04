import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/features/photo_gallery/presentation/providers/photo_gallery_provider.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';
import 'package:uuid/uuid.dart';

/// Screen to preview a captured photo before using or retaking
///
/// Displays the captured image full-screen with options to:
/// - Retake: Delete the temp file and go back to camera
/// - Use Photo: Save to gallery and navigate to gallery screen
class PhotoPreviewScreen extends ConsumerStatefulWidget {
  /// Path to the captured image file
  final String imagePath;

  const PhotoPreviewScreen({super.key, required this.imagePath});

  @override
  ConsumerState<PhotoPreviewScreen> createState() => _PhotoPreviewScreenState();
}

class _PhotoPreviewScreenState extends ConsumerState<PhotoPreviewScreen> {
  bool _isSaving = false;
  static const _uuid = Uuid();

  @override
  Widget build(BuildContext context) {
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
    final file = File(widget.imagePath);

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
                  onPressed: _isSaving ? null : () => _handleRetake(context),
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
                  onPressed: _isSaving ? null : () => _handleUsePhoto(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.check),
                  label: Text(
                    _isSaving ? 'Saving...' : 'Use Photo',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
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

  Future<void> _handleUsePhoto(BuildContext context) async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // Determine check-in type based on time of day
      final hour = DateTime.now().hour;
      final checkInType = (hour >= 5 && hour < 12)
          ? CheckInType.morning
          : CheckInType.night;

      // Create PhotoRecord with metadata
      final photo = PhotoRecord(
        id: _uuid.v4(),
        filePath: widget.imagePath,
        capturedAt: DateTime.now(),
        checkInType: checkInType,
      );

      // Save to gallery repository
      final repository = ref.read(photoRepositoryProvider);
      await repository.savePhoto(photo);

      // Invalidate providers to refresh gallery and ghost overlay
      ref.invalidate(photoGalleryProvider);
      ref.invalidate(latestPhotoProvider);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Photo saved to gallery!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to gallery to see the saved photo
      context.go('/gallery');
    } catch (e) {
      if (!context.mounted) return;

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save photo: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleClose(BuildContext context) {
    // Delete temp file and go home
    _deleteTemporaryFile();
    context.go('/');
  }

  void _deleteTemporaryFile() {
    try {
      final file = File(widget.imagePath);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } catch (e) {
      // Silently fail - temp files will be cleaned up eventually
      debugPrint('Failed to delete temp file: $e');
    }
  }
}
