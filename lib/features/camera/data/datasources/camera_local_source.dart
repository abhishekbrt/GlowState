abstract class CameraLocalSource {
  Future<void> initializeCamera();
  Future<void> disposeCamera();
  Future<String> captureImage();
  Future<void> switchCamera();
  Future<void> setFlash({required bool enabled});
  Future<void> setZoom(double level);
  bool get isInitialized;
  Stream<dynamic> get cameraStream;
}

class CameraLocalSourceImpl implements CameraLocalSource {
  var _isInitialized = false;

  @override
  bool get isInitialized => _isInitialized;

  @override
  Stream<dynamic> get cameraStream {
    throw UnimplementedError('CameraLocalSourceImpl.cameraStream');
  }

  @override
  Future<void> initializeCamera() async {
    throw UnimplementedError('CameraLocalSourceImpl.initializeCamera');
  }

  @override
  Future<void> disposeCamera() async {
    throw UnimplementedError('CameraLocalSourceImpl.disposeCamera');
  }

  @override
  Future<String> captureImage() async {
    throw UnimplementedError('CameraLocalSourceImpl.captureImage');
  }

  @override
  Future<void> switchCamera() async {
    throw UnimplementedError('CameraLocalSourceImpl.switchCamera');
  }

  @override
  Future<void> setFlash({required bool enabled}) async {
    throw UnimplementedError('CameraLocalSourceImpl.setFlash');
  }

  @override
  Future<void> setZoom(double level) async {
    throw UnimplementedError('CameraLocalSourceImpl.setZoom');
  }
}
