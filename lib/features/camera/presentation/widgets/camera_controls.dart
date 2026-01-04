import 'package:flutter/material.dart';

/// Top camera controls for flash and camera switching
///
/// Positioned at the top of the camera screen, provides
/// quick access to flash toggle and camera switch.
class CameraControls extends StatelessWidget {
  /// Whether flash is currently enabled
  final bool isFlashOn;

  /// Whether using front camera
  final bool isFrontCamera;

  /// Callback when flash button is pressed
  final VoidCallback? onFlashPressed;

  /// Callback when switch camera button is pressed
  final VoidCallback? onSwitchCameraPressed;

  /// Callback when close button is pressed
  final VoidCallback? onClosePressed;

  const CameraControls({
    super.key,
    required this.isFlashOn,
    required this.isFrontCamera,
    this.onFlashPressed,
    this.onSwitchCameraPressed,
    this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.4), Colors.transparent],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Close button
              _GlassControlButton(
                icon: Icons.close_rounded,
                onPressed: onClosePressed,
                tooltip: 'Close',
              ),

              // Right side controls
              Row(
                children: [
                  // Flash toggle (only show for back camera)
                  if (!isFrontCamera) ...[
                    _GlassControlButton(
                      icon: isFlashOn
                          ? Icons.flash_on_rounded
                          : Icons.flash_off_rounded,
                      onPressed: onFlashPressed,
                      tooltip: isFlashOn ? 'Flash On' : 'Flash Off',
                      isActive: isFlashOn,
                    ),
                    const SizedBox(width: 16),
                  ],

                  // Switch camera
                  _GlassControlButton(
                    icon: Icons.flip_camera_ios_rounded,
                    onPressed: onSwitchCameraPressed,
                    tooltip: 'Switch Camera',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool isActive;

  const _GlassControlButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.amber[200] : Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
