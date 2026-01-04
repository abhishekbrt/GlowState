import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:glowstate/features/photo_gallery/data/datasources/photo_local_source.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';

class MockBox extends Mock implements Box<PhotoModel> {}

void main() {
  late MockBox mockBox;
  late PhotoLocalSourceImpl localSource;

  setUpAll(() {
    registerFallbackValue(
      PhotoModel(
        id: 'fake',
        filePath: '',
        capturedAt: DateTime.now(),
        isMorning: true,
      ),
    );
  });

  setUp(() {
    mockBox = MockBox();
    localSource = PhotoLocalSourceImpl(box: mockBox);
  });

  group('PhotoLocalSource', () {
    final tPhoto = PhotoModel(
      id: 'test-id',
      filePath: '/path/to/photo.jpg',
      capturedAt: DateTime(2023, 1, 1, 10),
      isMorning: true,
    );

    test('savePhoto should store photo in box', () async {
      // Arrange
      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // Act
      await localSource.savePhoto(tPhoto);

      // Assert
      verify(() => mockBox.put('test-id', tPhoto)).called(1);
    });

    test('getPhotosByDate should filter and sort photos', () async {
      // Arrange
      final today = DateTime(2023, 1, 1);
      final photo1 = tPhoto.copyWith(
        id: '1',
        capturedAt: today.add(const Duration(hours: 1)),
      );
      final photo2 = tPhoto.copyWith(
        id: '2',
        capturedAt: today.add(const Duration(hours: 2)),
      );
      final photo3 = tPhoto.copyWith(
        id: '3',
        capturedAt: today.subtract(const Duration(days: 1)),
      );

      when(() => mockBox.values).thenReturn([photo1, photo2, photo3]);

      // Act
      final result = await localSource.getPhotosByDate(today);

      // Assert
      expect(result.length, 2);
      expect(result.first.id, '2'); // sorted newest first
      expect(result.last.id, '1');
    });

    test('getLatestPhoto should return the newest photo', () async {
      // Arrange
      final photo1 = tPhoto.copyWith(id: '1', capturedAt: DateTime(2023, 1, 1));
      final photo2 = tPhoto.copyWith(id: '2', capturedAt: DateTime(2023, 1, 2));

      when(() => mockBox.isEmpty).thenReturn(false);
      when(() => mockBox.values).thenReturn([photo1, photo2]);

      // Act
      final result = await localSource.getLatestPhoto();

      // Assert
      expect(result?.id, '2');
    });

    test('deletePhoto should remove photo from box', () async {
      // Arrange
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      // Act
      await localSource.deletePhoto('test-id');

      // Assert
      verify(() => mockBox.delete('test-id')).called(1);
    });
  });
}
