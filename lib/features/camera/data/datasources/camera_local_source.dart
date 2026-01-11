import 'package:camera/camera.dart';

abstract class CameraLocalSource {
  Future<void> initializeCamera();
  Future<void> disposeCamera();
  Future<String> captureImage();
  Future<void> switchCamera();
  Future<void> setFlash({required bool enabled});
  Future<void> setZoom(double level);
  bool get isInitialized;
  bool get isFrontCamera;
  CameraController? get controller;
}

class CameraLocalSourceImpl implements CameraLocalSource {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _currentCameraIndex = 0;
  bool _isInitialized = false;
  bool _isFrontCamera = true;

  @override
  bool get isInitialized => _isInitialized;

  @override
  bool get isFrontCamera => _isFrontCamera;

  @override
  CameraController? get controller => _controller;

  @override
  Future<void> initializeCamera() async {
    _cameras = await availableCameras();

    if (_cameras == null || _cameras!.isEmpty) {
      throw CameraException('NoCameraAvailable', 'No cameras found on device');
    }

    // Find front camera for selfies (default)
    _currentCameraIndex = _cameras!.indexWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    // Fall back to first camera if no front camera
    if (_currentCameraIndex == -1) {
      _currentCameraIndex = 0;
      _isFrontCamera = false;
    } else {
      _isFrontCamera = true;
    }

    await _initializeController(_cameras![_currentCameraIndex]);
  }

  Future<void> _initializeController(CameraDescription camera) async {
    _controller?.dispose();

    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller!.initialize();
    _isInitialized = true;
  }

  @override
  Future<void> disposeCamera() async {
    await _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }

  @override
  Future<String> captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      throw CameraException(
        'CameraNotInitialized',
        'Camera must be initialized before capturing',
      );
    }

    if (_controller!.value.isTakingPicture) {
      throw CameraException(
        'CaptureInProgress',
        'A capture is already in progress',
      );
    }

    final XFile image = await _controller!.takePicture();
    return image.path;
  }

  @override
  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      return; // No other camera to switch to
    }

    // Toggle between front and back
    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras!.length;
    final newCamera = _cameras![_currentCameraIndex];

    _isFrontCamera = newCamera.lensDirection == CameraLensDirection.front;

    await _initializeController(newCamera);
  }

  @override
  Future<void> setFlash({required bool enabled}) async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    await _controller!.setFlashMode(enabled ? FlashMode.torch : FlashMode.off);
  }

  @override
  Future<void> setZoom(double level) async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    final minZoom = await _controller!.getMinZoomLevel();
    final maxZoom = await _controller!.getMaxZoomLevel();

    // Clamp level between min and max
    final clampedLevel = level.clamp(minZoom, maxZoom);
    await _controller!.setZoomLevel(clampedLevel);
  }
}
