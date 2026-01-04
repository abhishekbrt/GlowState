import 'package:flutter_test/flutter_test.dart';
import 'package:glowstate/features/camera/data/datasources/camera_local_source.dart';
import 'package:glowstate/features/camera/data/repositories/camera_repository_impl.dart';
import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';
import 'package:mocktail/mocktail.dart';

class MockCameraLocalSource extends Mock implements CameraLocalSource {}

class MockPhotoRepository extends Mock implements PhotoRepository {}

void main() {
  group('CameraRepositoryImpl', () {
    late CameraRepositoryImpl repository;
    late MockCameraLocalSource mockLocalSource;
    late MockPhotoRepository mockPhotoRepository;

    setUp(() {
      mockLocalSource = MockCameraLocalSource();
      mockPhotoRepository = MockPhotoRepository();
      repository = CameraRepositoryImpl(
        localSource: mockLocalSource,
        photoRepository: mockPhotoRepository,
      );
    });

    group('initialize', () {
      test('should call localSource.initializeCamera', () async {
        when(() => mockLocalSource.initializeCamera()).thenAnswer((_) async {});

        await repository.initialize();

        verify(() => mockLocalSource.initializeCamera()).called(1);
      });
    });

    group('dispose', () {
      test('should call localSource.disposeCamera', () async {
        when(() => mockLocalSource.disposeCamera()).thenAnswer((_) async {});

        await repository.dispose();

        verify(() => mockLocalSource.disposeCamera()).called(1);
      });
    });

    group('capturePhoto', () {
      test(
        'should call localSource.captureImage and return file path',
        () async {
          const expectedPath = '/tmp/photo.jpg';
          when(
            () => mockLocalSource.captureImage(),
          ).thenAnswer((_) async => expectedPath);

          final result = await repository.capturePhoto(
            checkInType: CheckInType.morning,
          );

          expect(result, equals(expectedPath));
          verify(() => mockLocalSource.captureImage()).called(1);
        },
      );
    });

    group('switchCamera', () {
      test('should call localSource.switchCamera', () async {
        when(() => mockLocalSource.switchCamera()).thenAnswer((_) async {});

        await repository.switchCamera();

        verify(() => mockLocalSource.switchCamera()).called(1);
      });
    });

    group('setFlash', () {
      test('should call localSource.setFlash with correct parameter', () async {
        when(
          () => mockLocalSource.setFlash(enabled: true),
        ).thenAnswer((_) async {});

        await repository.setFlash(enabled: true);

        verify(() => mockLocalSource.setFlash(enabled: true)).called(1);
      });
    });

    group('setZoom', () {
      test('should call localSource.setZoom with correct level', () async {
        when(() => mockLocalSource.setZoom(2.0)).thenAnswer((_) async {});

        await repository.setZoom(2.0);

        verify(() => mockLocalSource.setZoom(2.0)).called(1);
      });
    });

    group('isInitialized', () {
      test('should return localSource.isInitialized', () {
        when(() => mockLocalSource.isInitialized).thenReturn(true);

        expect(repository.isInitialized, isTrue);

        verify(() => mockLocalSource.isInitialized).called(1);
      });
    });

    group('isFrontCamera', () {
      test('should return localSource.isFrontCamera', () {
        when(() => mockLocalSource.isFrontCamera).thenReturn(true);

        expect(repository.isFrontCamera, isTrue);

        verify(() => mockLocalSource.isFrontCamera).called(1);
      });
    });
  });
}
