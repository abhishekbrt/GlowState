import 'package:flutter/material.dart';

/// Bottom navigation bar for camera screen
///
/// Contains the large capture button in the center,
/// with gallery button on left and placeholder on right.
class CameraBottomNav extends StatelessWidget {
  /// Callback when capture button is pressed
  final VoidCallback? onCapture;

  /// Callback when gallery button is pressed (disabled for now)
  final VoidCallback? onGallery;

  /// Whether capture is in progress (shows loading indicator)
  final bool isCapturing;

  const CameraBottomNav({
    super.key,
    this.onCapture,
    this.onGallery,
    this.isCapturing = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gallery button (disabled - not implemented yet)
            _SideButton(
              icon: Icons.photo_library_outlined,
              onPressed: onGallery,
              enabled: false,
              tooltip: 'Gallery (Coming Soon)',
            ),

            // Capture button (large, center)
            _CaptureButton(onPressed: onCapture, isCapturing: isCapturing),

            // Placeholder for symmetry (or future feature)
            const _SideButton(
              icon: Icons.photo_library_outlined,
              onPressed: null,
              enabled: false,
              visible: false,
              tooltip: '',
            ),
          ],
        ),
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isCapturing;

  const _CaptureButton({required this.onPressed, required this.isCapturing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isCapturing ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCapturing ? Colors.grey : Colors.white,
          ),
          child: isCapturing
              ? const Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.black54,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool visible;
  final String tooltip;

  const _SideButton({
    required this.icon,
    required this.onPressed,
    this.enabled = true,
    this.visible = true,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox(width: 48, height: 48);
    }

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: Icon(
              icon,
              color: enabled ? Colors.white : Colors.white38,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
