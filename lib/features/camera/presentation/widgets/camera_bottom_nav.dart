import 'package:flutter/material.dart';
import 'package:glowstate/core/theme/app_colors.dart';

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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
          stops: const [0.0, 0.8],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gallery button
              _GlassSideButton(
                icon: Icons.photo_library_outlined,
                onPressed: onGallery,
                enabled: false, // Keeping disabled as per original
                tooltip: 'Gallery (Coming Soon)',
              ),

              // Capture button (large, center)
              _BotanicalCaptureButton(
                onPressed: onCapture,
                isCapturing: isCapturing,
              ),

              // Placeholder for symmetry
              const _GlassSideButton(
                icon: Icons.photo_library_outlined,
                onPressed: null,
                enabled: false,
                visible: false,
                tooltip: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BotanicalCaptureButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isCapturing;

  const _BotanicalCaptureButton({
    required this.onPressed,
    required this.isCapturing,
  });

  @override
  State<_BotanicalCaptureButton> createState() =>
      _BotanicalCaptureButtonState();
}

class _BotanicalCaptureButtonState extends State<_BotanicalCaptureButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isCapturing) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isCapturing) {
      _controller.reverse();
      widget.onPressed?.call();
    }
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primaryLight, AppColors.primary],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: widget.isCapturing
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: AppColors.primary,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GlassSideButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool visible;
  final String tooltip;

  const _GlassSideButton({
    required this.icon,
    required this.onPressed,
    this.enabled = true,
    this.visible = true,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox(width: 56, height: 56);
    }

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: enabled ? Colors.white : Colors.white38,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
