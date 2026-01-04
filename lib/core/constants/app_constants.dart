abstract final class AppConstants {
  static const int cycleDurationDays = 30;
  static const int flowerRevealDay = 10;
  static const int maxPhotosPerDay = 2;

  static const double ghostOverlayOpacity = 0.3;
  static const int timelapseFrameRate = 60;
  static const int timelapseWidth = 1080;
  static const int timelapseHeight = 1920;

  static const Duration morningRoutineStart = Duration(hours: 5);
  static const Duration morningRoutineEnd = Duration(hours: 12);
  static const Duration nightRoutineStart = Duration(hours: 18);
  static const Duration nightRoutineEnd = Duration(hours: 23, minutes: 59);

  static const int standardCheckInPoints = 10;
  static const int goldenCheckInPoints = 50;

  static const String appName = 'GlowState';

  // === Face Guide Overlay Constants ===

  /// Width of face guide oval relative to screen width (0.0 to 1.0)
  static const double faceGuideOvalWidthRatio = 0.85;

  /// Height/width ratio of the oval (makes it taller than wide)
  static const double faceGuideOvalAspectRatio = 1.35;

  /// Vertical offset from center (moves oval slightly up for face framing)
  static const double faceGuideVerticalOffsetRatio = 0.05;

  /// Opacity of the dark vignette around the oval (0.0 to 1.0)
  static const double faceGuideVignetteOpacity = 0.4;

  /// Opacity of the glow effect around the oval border
  static const double faceGuideGlowOpacity = 0.5;

  /// Blur radius for the glow effect (in logical pixels)
  static const double faceGuideGlowBlurRadius = 8.0;

  /// Multiplier for glow stroke width relative to main stroke
  static const double faceGuideGlowStrokeMultiplier = 2.0;

  /// Size ratio for decorative accent curves at top/bottom of oval
  static const double faceGuideAccentSizeRatio = 0.1;

  /// Offset for accent curve control points (in logical pixels)
  static const double faceGuideAccentCurveOffset = 5.0;

  /// Multiplier for accent stroke width relative to main stroke
  static const double faceGuideAccentStrokeMultiplier = 1.5;
}
