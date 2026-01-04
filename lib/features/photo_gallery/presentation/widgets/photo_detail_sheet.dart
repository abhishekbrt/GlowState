import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glowstate/features/photo_gallery/presentation/providers/photo_gallery_provider.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:intl/intl.dart';

class PhotoDetailSheet extends ConsumerWidget {
  const PhotoDetailSheet({super.key, required this.photo});

  final PhotoRecord photo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = DateFormat('MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Photo
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(photo.filePath),
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 80),
                    );
                  },
                ),
              ),
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      photo.isMorning ? Icons.wb_sunny : Icons.nightlight_round,
                      color: photo.isMorning ? Colors.amber : Colors.indigo,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      photo.isMorning ? 'Morning Routine' : 'Night Routine',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${dateFormat.format(photo.capturedAt)} at ${timeFormat.format(photo.capturedAt)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (photo.cycleDay != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Day ${photo.cycleDay} of 30',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ref
                          .read(photoGalleryProvider.notifier)
                          .togglePrivacy(photo.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(photo.isPrivate ? Icons.lock_open : Icons.lock),
                    label: Text(
                      photo.isPrivate ? 'Make Public' : 'Make Private',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelete(context, ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Photo?'),
        content: const Text(
          'This photo will be permanently deleted and cannot be recovered.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(photoGalleryProvider.notifier).deletePhoto(photo.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
