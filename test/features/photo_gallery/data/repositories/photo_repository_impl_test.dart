import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:glowstate/features/photo_gallery/data/datasources/photo_local_source.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';
import 'package:glowstate/features/photo_gallery/data/repositories/photo_repository_impl.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';

class MockPhotoLocalSource extends Mock implements PhotoLocalSource {}

void main() {
  late MockPhotoLocalSource mockLocalSource;
  late PhotoRepositoryImpl repository;

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
    mockLocalSource = MockPhotoLocalSource();
    repository = PhotoRepositoryImpl(localSource: mockLocalSource);
  });

  group('PhotoRepositoryImpl', () {
    final tPhotoModel = PhotoModel(
      id: 'test-id',
      filePath: '/path/to/photo.jpg',
      capturedAt: DateTime(2023, 1, 1, 10),
      isMorning: true,
      notes: 'Some notes',
    );

    test('getPhotosByDate should return PhotoRecord list', () async {
      // Arrange
      when(
        () => mockLocalSource.getPhotosByDate(any()),
      ).thenAnswer((_) async => [tPhotoModel]);

      // Act
      final result = await repository.getPhotosByDate(DateTime.now());

      // Assert
      expect(result.length, 1);
      expect(result.first.id, tPhotoModel.id);
      expect(result.first.notes, tPhotoModel.notes);
      expect(result.first, isA<PhotoRecord>());
    });

    test('savePhoto should convert to model and back', () async {
      // Arrange
      final tPhotoRecord = tPhotoModel.toPhotoRecord();
      when(
        () => mockLocalSource.savePhoto(any()),
      ).thenAnswer((_) async => tPhotoModel);

      // Act
      final result = await repository.savePhoto(tPhotoRecord);

      // Assert
      expect(result.id, tPhotoRecord.id);
      verify(() => mockLocalSource.savePhoto(any())).called(1);
    });
  });
}
