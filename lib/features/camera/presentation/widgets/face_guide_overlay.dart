import 'dart:math' as math;

import 'package:flutter/material.dart';

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
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Calculate oval dimensions
    // Position slightly above center for natural face framing
    final centerX = size.width / 2;
    final centerY = size.height / 2 - size.height * 0.05;

    // Oval size relative to screen width
    final ovalWidth = size.width * 0.55;
    final ovalHeight =
        ovalWidth * 1.3; // Slightly taller than wide for face shape

    final rect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Draw dashed oval
    _drawDashedOval(canvas, rect, paint);

    // Draw small alignment marks at key points
    _drawAlignmentMarks(canvas, rect, paint);
  }

  void _drawDashedOval(Canvas canvas, Rect rect, Paint paint) {
    const dashLength = 12.0;
    const gapLength = 8.0;
    final path = Path()..addOval(rect);

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      bool draw = true;

      while (distance < metric.length) {
        final length = draw ? dashLength : gapLength;
        final end = math.min(distance + length, metric.length);

        if (draw) {
          final extractPath = metric.extractPath(distance, end);
          canvas.drawPath(extractPath, paint);
        }

        distance = end;
        draw = !draw;
      }
    }
  }

  void _drawAlignmentMarks(Canvas canvas, Rect rect, Paint paint) {
    final markerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 0.8
      ..strokeCap = StrokeCap.round;

    const markLength = 8.0;

    // Top center mark
    canvas.drawLine(
      Offset(rect.center.dx, rect.top - markLength),
      Offset(rect.center.dx, rect.top - 2),
      markerPaint,
    );

    // Bottom center mark
    canvas.drawLine(
      Offset(rect.center.dx, rect.bottom + 2),
      Offset(rect.center.dx, rect.bottom + markLength),
      markerPaint,
    );

    // Left center mark
    canvas.drawLine(
      Offset(rect.left - markLength, rect.center.dy),
      Offset(rect.left - 2, rect.center.dy),
      markerPaint,
    );

    // Right center mark
    canvas.drawLine(
      Offset(rect.right + 2, rect.center.dy),
      Offset(rect.right + markLength, rect.center.dy),
      markerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FaceGuidePainter oldDelegate) {
    return color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
  }
}
