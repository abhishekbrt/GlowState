import 'dart:io';

import 'package:flutter/material.dart';

/// An overlay that displays the previous photo with low opacity
///
/// This implements the "Ghost Mode" feature, helping users
/// align their face perfectly with their previous photo.
class GhostOverlay extends StatelessWidget {
  /// File path to the previous photo
  final String? imagePath;

  /// Opacity of the ghost image (0.0 to 1.0)
  final double opacity;

  const GhostOverlay({super.key, this.imagePath, this.opacity = 0.25});

  @override
  Widget build(BuildContext context) {
    if (imagePath == null) {
      return const SizedBox.shrink();
    }

    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Image.file(
          File(imagePath!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
