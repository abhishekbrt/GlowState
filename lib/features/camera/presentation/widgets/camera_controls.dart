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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Close button
            _ControlButton(
              icon: Icons.close,
              onPressed: onClosePressed,
              tooltip: 'Close',
            ),

            // Right side controls
            Row(
              children: [
                // Flash toggle (only show for back camera)
                if (!isFrontCamera)
                  _ControlButton(
                    icon: isFlashOn ? Icons.flash_on : Icons.flash_off,
                    onPressed: onFlashPressed,
                    tooltip: isFlashOn ? 'Flash On' : 'Flash Off',
                    isActive: isFlashOn,
                  ),

                const SizedBox(width: 8),

                // Switch camera
                _ControlButton(
                  icon: Icons.flip_camera_ios,
                  onPressed: onSwitchCameraPressed,
                  tooltip: 'Switch Camera',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool isActive;

  const _ControlButton({
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
        color: isActive
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.3),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
