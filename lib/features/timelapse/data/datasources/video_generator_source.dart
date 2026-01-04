abstract class VideoGeneratorSource {
  Future<String> generateVideo({
    required List<String> imagePaths,
    required String outputPath,
    int frameRate = 60,
    int width = 1080,
    int height = 1920,
  });
  Stream<double> get progress;
  Future<void> cancel();
}

class VideoGeneratorSourceImpl implements VideoGeneratorSource {
  @override
  Future<String> generateVideo({
    required List<String> imagePaths,
    required String outputPath,
    int frameRate = 60,
    int width = 1080,
    int height = 1920,
  }) async {
    throw UnimplementedError('VideoGeneratorSourceImpl.generateVideo');
  }

  @override
  Stream<double> get progress {
    throw UnimplementedError('VideoGeneratorSourceImpl.progress');
  }

  @override
  Future<void> cancel() async {
    throw UnimplementedError('VideoGeneratorSourceImpl.cancel');
  }
}
