import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';

part 'photo_gallery_provider.g.dart';

/// Provider for photo gallery state
///
/// Uses shared [PhotoRecord] from shared domain.
@riverpod
class PhotoGallery extends _$PhotoGallery {
  @override
  FutureOr<List<PhotoRecord>> build() async {
    // TODO: Implement - load recent photos
    throw UnimplementedError('PhotoGalleryProvider.build');
  }

  Future<void> loadPhotosForMonth(int year, int month) async {
    // TODO: Implement - load photos for calendar month
    throw UnimplementedError('PhotoGalleryProvider.loadPhotosForMonth');
  }

  Future<void> deletePhoto(String id) async {
    // TODO: Implement - delete photo
    throw UnimplementedError('PhotoGalleryProvider.deletePhoto');
  }

  Future<void> togglePrivacy(String id) async {
    // TODO: Implement - toggle privacy flag
    throw UnimplementedError('PhotoGalleryProvider.togglePrivacy');
  }
}

/// Provider for photos on a specific date
@riverpod
Future<List<PhotoRecord>> photosForDate(
  PhotosForDateRef ref,
  DateTime date,
) async {
  final repository = ref.watch(photoRepositoryProvider);
  return repository.getPhotosByDate(date);
}

/// Provider for total photo count
@riverpod
Future<int> photoCount(PhotoCountRef ref) async {
  final repository = ref.watch(photoRepositoryProvider);
  return repository.getPhotoCount();
}
