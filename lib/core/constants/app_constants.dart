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
}
