import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/photo_gallery/data/providers/photo_repository_provider.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';

part 'photo_gallery_provider.g.dart';

/// Provider for photo gallery state
@riverpod
class PhotoGallery extends _$PhotoGallery {
  @override
  FutureOr<List<PhotoRecord>> build() async {
    // Load all photos by default (last 30 days)
    final repository = ref.watch(photoRepositoryProvider);
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    return repository.getPhotosByDateRange(thirtyDaysAgo, now);
  }

  Future<void> loadPhotosForMonth(int year, int month) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(photoRepositoryProvider);
      return repository.getPhotosForMonth(year, month);
    });
  }

  Future<void> loadPhotosForDateRange(DateTime start, DateTime end) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(photoRepositoryProvider);
      return repository.getPhotosByDateRange(start, end);
    });
  }

  Future<void> deletePhoto(String id) async {
    final repository = ref.read(photoRepositoryProvider);
    await repository.deletePhoto(id);

    // Remove from current state without reloading
    state = state.whenData((photos) {
      return photos.where((p) => p.id != id).toList();
    });
  }

  Future<void> togglePrivacy(String id) async {
    final repository = ref.read(photoRepositoryProvider);
    final photos = state.valueOrNull ?? [];
    final photo = photos.firstWhere((p) => p.id == id);

    await repository.updatePhotoPrivacy(id, isPrivate: !photo.isPrivate);

    // Update local state
    state = state.whenData((photos) {
      return photos.map((p) {
        if (p.id == id) {
          return p.copyWith(isPrivate: !p.isPrivate);
        }
        return p;
      }).toList();
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
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

/// Provider for latest photo (used by camera for ghost overlay)
@riverpod
Future<PhotoRecord?> latestPhoto(LatestPhotoRef ref) async {
  final repository = ref.watch(photoRepositoryProvider);
  return repository.getLatestPhoto();
}
