import 'package:flutter/material.dart';
import 'package:glowstate/core/constants/app_constants.dart';

/// A widget that displays a dashed oval guide for face positioning

///
/// This helps users align their face consistently for daily photos,
/// enabling better timelapse generation.
class FaceGuideOverlay extends StatelessWidget {
  /// Color of the guide outline
  final Color color;

  /// Width of the guide stroke
  final double strokeWidth;

  /// Opacity of the guide (0.0 to 1.0)
  final double opacity;

  const FaceGuideOverlay({
    super.key,
    this.color = Colors.white,
    this.strokeWidth = 2.0,
    this.opacity = 0.7,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _FaceGuidePainter(
          color: color.withValues(alpha: opacity),
          strokeWidth: strokeWidth,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _FaceGuidePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _FaceGuidePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Vignette (Darken outside the oval)
    // Create a path for the screen
    final screenPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Calculate oval dimensions using constants
    // Position slightly above center for natural face framing
    final centerX = size.width / 2;
    final centerY =
        size.height / 2 -
        size.height * AppConstants.faceGuideVerticalOffsetRatio;

    // Oval size relative to screen width
    final ovalWidth = size.width * AppConstants.faceGuideOvalWidthRatio;
    final ovalHeight = ovalWidth * AppConstants.faceGuideOvalAspectRatio;

    final ovalRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: ovalWidth,
      height: ovalHeight,
    );

    final ovalPath = Path()..addOval(ovalRect);

    // Create the "hole" by subtracting oval from screen
    final vignettePath = Path.combine(
      PathOperation.difference,
      screenPath,
      ovalPath,
    );

    final vignettePaint = Paint()
      ..color = Colors.black
          .withValues(
            alpha: AppConstants.faceGuideVignetteOpacity,
          ) // Subtle darkening
      ..style = PaintingStyle.fill;

    canvas.drawPath(vignettePath, vignettePaint);

    // 2. Draw Soft Glow Guide
    final glowPaint = Paint()
      ..color = color.withValues(alpha: AppConstants.faceGuideGlowOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * AppConstants.faceGuideGlowStrokeMultiplier
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        AppConstants.faceGuideGlowBlurRadius,
      );

    canvas.drawOval(ovalRect, glowPaint);

    // 3. Draw Sharp Guide Line
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Use a solid line instead of dashed for a cleaner, more elegant look
    canvas.drawOval(ovalRect, borderPaint);

    // 4. Draw Botanical/Organic Accents instead of crosshairs
    _drawOrganicAccents(canvas, ovalRect, borderPaint);
  }

  void _drawOrganicAccents(Canvas canvas, Rect rect, Paint paint) {
    final accentPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * AppConstants.faceGuideAccentStrokeMultiplier
      ..strokeCap = StrokeCap.round;

    // Draw small "leaf-like" curves at the corners of the bounding box
    // Top-Left
    final cornerSize = rect.width * AppConstants.faceGuideAccentSizeRatio;
    final curveOffset = AppConstants.faceGuideAccentCurveOffset;

    // Top Arc
    final topPath = Path();
    topPath.moveTo(rect.topCenter.dx - cornerSize, rect.top);
    topPath.quadraticBezierTo(
      rect.topCenter.dx,
      rect.top + curveOffset,
      rect.topCenter.dx + cornerSize,
      rect.top,
    );
    canvas.drawPath(topPath, accentPaint);

    // Bottom Arc
    final bottomPath = Path();
    bottomPath.moveTo(rect.bottomCenter.dx - cornerSize, rect.bottom);
    bottomPath.quadraticBezierTo(
      rect.bottomCenter.dx,
      rect.bottom - curveOffset,
      rect.bottomCenter.dx + cornerSize,
      rect.bottom,
    );
    canvas.drawPath(bottomPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant _FaceGuidePainter oldDelegate) {
    return color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
  }
}
