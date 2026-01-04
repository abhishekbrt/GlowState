import 'package:glowstate/features/photo_gallery/data/datasources/photo_local_source.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';

import '../../domain/repositories/photo_repository.dart';

/// Implementation of [PhotoRepository] using shared [PhotoRecord]
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoLocalSource localSource;

  PhotoRepositoryImpl({required this.localSource});

  @override
  Future<List<PhotoRecord>> getPhotosByDate(DateTime date) async {
    final models = await localSource.getPhotosByDate(date);
    return models.map((m) => m.toPhotoRecord()).toList();
  }

  @override
  Future<List<PhotoRecord>> getPhotosByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final models = await localSource.getPhotosByDateRange(start, end);
    return models.map((m) => m.toPhotoRecord()).toList();
  }

  @override
  Future<List<PhotoRecord>> getPhotosForMonth(int year, int month) async {
    final models = await localSource.getPhotosForMonth(year, month);
    return models.map((m) => m.toPhotoRecord()).toList();
  }

  @override
  Future<List<PhotoRecord>> getPhotosForTimelapse({
    bool includePrivate = true,
  }) async {
    final models = await localSource.getAllPhotos();
    final filtered = includePrivate
        ? models
        : models.where((m) => !m.isPrivate).toList();
    // Sort by capturedAt ascending for timelapse (oldest first)
    final sorted = filtered.toList()
      ..sort((a, b) => a.capturedAt.compareTo(b.capturedAt));
    return sorted.map((m) => m.toPhotoRecord()).toList();
  }

  @override
  Future<PhotoRecord> savePhoto(PhotoRecord photo) async {
    final model = PhotoModel.fromPhotoRecord(photo);
    final saved = await localSource.savePhoto(model);
    return saved.toPhotoRecord();
  }

  @override
  Future<void> deletePhoto(String id) async {
    await localSource.deletePhoto(id);
  }

  @override
  Future<void> updatePhotoPrivacy(String id, {required bool isPrivate}) async {
    final existing = await localSource.getPhotoById(id);
    if (existing != null) {
      final updated = existing.copyWith(isPrivate: isPrivate);
      await localSource.updatePhoto(updated);
    }
  }

  @override
  Future<PhotoRecord?> getLatestPhoto() async {
    final model = await localSource.getLatestPhoto();
    return model?.toPhotoRecord();
  }

  @override
  Future<PhotoRecord?> getLatestPhotoByType(dynamic checkInType) async {
    if (checkInType is! CheckInType) return null;

    final isMorning = checkInType == CheckInType.morning;
    final all = await localSource.getAllPhotos();
    final filtered = all.where((m) => m.isMorning == isMorning).toList();
    if (filtered.isEmpty) return null;

    // Already sorted newest first from getAllPhotos
    return filtered.first.toPhotoRecord();
  }

  @override
  Future<int> getPhotoCount() async {
    return localSource.getPhotoCount();
  }

  @override
  Future<List<PhotoRecord>> getPhotosByCycleDay(int cycleDay) async {
    final all = await localSource.getAllPhotos();
    return all
        .where((m) => m.cycleDay == cycleDay)
        .map((m) => m.toPhotoRecord())
        .toList();
  }
}
