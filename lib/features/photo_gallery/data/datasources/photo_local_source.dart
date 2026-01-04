import 'package:hive/hive.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';

abstract class PhotoLocalSource {
  Future<List<PhotoModel>> getPhotosByDate(DateTime date);
  Future<List<PhotoModel>> getPhotosByDateRange(DateTime start, DateTime end);
  Future<List<PhotoModel>> getPhotosForMonth(int year, int month);
  Future<List<PhotoModel>> getAllPhotos();
  Future<PhotoModel> savePhoto(PhotoModel photo);
  Future<void> deletePhoto(String id);
  Future<void> updatePhoto(PhotoModel photo);
  Future<PhotoModel?> getPhotoById(String id);
  Future<PhotoModel?> getLatestPhoto();
  Future<int> getPhotoCount();
}

class PhotoLocalSourceImpl implements PhotoLocalSource {
  PhotoLocalSourceImpl({required this.box});

  final Box<PhotoModel> box;

  /// Helper to get date without time
  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  @override
  Future<List<PhotoModel>> getPhotosByDate(DateTime date) async {
    final targetDate = _dateOnly(date);
    return box.values.where((photo) {
      final photoDate = _dateOnly(photo.capturedAt);
      return photoDate == targetDate;
    }).toList()..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
  }

  @override
  Future<List<PhotoModel>> getPhotosByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final startDate = _dateOnly(start);
    final endDate = _dateOnly(end);
    return box.values.where((photo) {
      final photoDate = _dateOnly(photo.capturedAt);
      return !photoDate.isBefore(startDate) && !photoDate.isAfter(endDate);
    }).toList()..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
  }

  @override
  Future<List<PhotoModel>> getPhotosForMonth(int year, int month) async {
    return box.values.where((photo) {
      return photo.capturedAt.year == year && photo.capturedAt.month == month;
    }).toList()..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
  }

  @override
  Future<List<PhotoModel>> getAllPhotos() async {
    return box.values.toList()
      ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
  }

  @override
  Future<PhotoModel> savePhoto(PhotoModel photo) async {
    await box.put(photo.id, photo);
    return photo;
  }

  @override
  Future<void> deletePhoto(String id) async {
    await box.delete(id);
  }

  @override
  Future<void> updatePhoto(PhotoModel photo) async {
    await box.put(photo.id, photo);
  }

  @override
  Future<PhotoModel?> getPhotoById(String id) async {
    return box.get(id);
  }

  @override
  Future<PhotoModel?> getLatestPhoto() async {
    if (box.isEmpty) return null;
    final photos = box.values.toList()
      ..sort((a, b) => b.capturedAt.compareTo(a.capturedAt));
    return photos.first;
  }

  @override
  Future<int> getPhotoCount() async {
    return box.length;
  }
}
