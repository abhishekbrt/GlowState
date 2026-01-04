import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';

class PhotoGridItem extends StatelessWidget {
  const PhotoGridItem({super.key, required this.photo, required this.onTap});

  final PhotoRecord photo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Photo image
            Image.file(
              File(photo.thumbnailPath ?? photo.filePath),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 40),
                );
              },
            ),
            // Privacy indicator
            if (photo.isPrivate)
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.lock, size: 14, color: Colors.white),
                ),
              ),
            // Morning/Night indicator
            Positioned(
              bottom: 4,
              left: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  photo.isMorning ? Icons.wb_sunny : Icons.nightlight_round,
                  size: 14,
                  color: photo.isMorning ? Colors.amber : Colors.indigo[200],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
