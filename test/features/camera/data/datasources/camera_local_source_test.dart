import 'package:flutter_test/flutter_test.dart';
import 'package:glowstate/features/camera/data/datasources/camera_local_source.dart';

void main() {
  group('CameraLocalSourceImpl', () {
    late CameraLocalSourceImpl localSource;

    setUp(() {
      localSource = CameraLocalSourceImpl();
    });

    group('initial state', () {
      test('isInitialized should be false initially', () {
        expect(localSource.isInitialized, isFalse);
      });

      test('controller should be null initially', () {
        expect(localSource.controller, isNull);
      });

      test('isFrontCamera should be true initially (selfie default)', () {
        expect(localSource.isFrontCamera, isTrue);
      });
    });

    // Note: Camera hardware tests require a real device or platform mocking.
    // These tests verify the initial state and basic behavior.
    // Integration tests should be used for actual camera functionality.

    group('captureImage', () {
      test('should throw CameraException when not initialized', () async {
        // Camera not initialized should throw
        await expectLater(
          () => localSource.captureImage(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('switchCamera', () {
      test('should not throw when cameras list is empty or null', () async {
        // When no cameras available, should complete without error
        await expectLater(localSource.switchCamera(), completes);
      });
    });

    group('setFlash', () {
      test('should not throw when controller is null', () async {
        // When controller not initialized, should silently return
        await expectLater(localSource.setFlash(enabled: true), completes);
      });
    });

    group('setZoom', () {
      test('should not throw when controller is null', () async {
        // When controller not initialized, should silently return
        await expectLater(localSource.setZoom(2.0), completes);
      });
    });

    group('disposeCamera', () {
      test('should complete when controller is null', () async {
        // When controller not initialized, should complete without error
        await expectLater(localSource.disposeCamera(), completes);
        expect(localSource.isInitialized, isFalse);
      });
    });
  });
}
