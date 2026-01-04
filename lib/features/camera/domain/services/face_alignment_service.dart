abstract class FaceAlignmentService {
  Future<void> initialize();
  Future<void> dispose();
  Future<FaceAlignmentResult?> detectFace(String imagePath);
  Future<bool> isFaceAligned(
    String currentImagePath,
    String? referenceImagePath,
  );
}

class FaceAlignmentResult {
  final double leftEyeX;
  final double leftEyeY;
  final double rightEyeX;
  final double rightEyeY;
  final double noseX;
  final double noseY;
  final double faceWidth;
  final double faceHeight;
  final double rotationAngle;

  const FaceAlignmentResult({
    required this.leftEyeX,
    required this.leftEyeY,
    required this.rightEyeX,
    required this.rightEyeY,
    required this.noseX,
    required this.noseY,
    required this.faceWidth,
    required this.faceHeight,
    required this.rotationAngle,
  });

  bool get isWellAligned => rotationAngle.abs() < 10;
}
