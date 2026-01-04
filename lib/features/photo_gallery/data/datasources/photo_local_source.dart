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
  @override
  Future<List<PhotoModel>> getPhotosByDate(DateTime date) async {
    throw UnimplementedError('PhotoLocalSourceImpl.getPhotosByDate');
  }

  @override
  Future<List<PhotoModel>> getPhotosByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    throw UnimplementedError('PhotoLocalSourceImpl.getPhotosByDateRange');
  }

  @override
  Future<List<PhotoModel>> getPhotosForMonth(int year, int month) async {
    throw UnimplementedError('PhotoLocalSourceImpl.getPhotosForMonth');
  }

  @override
  Future<List<PhotoModel>> getAllPhotos() async {
    throw UnimplementedError('PhotoLocalSourceImpl.getAllPhotos');
  }

  @override
  Future<PhotoModel> savePhoto(PhotoModel photo) async {
    throw UnimplementedError('PhotoLocalSourceImpl.savePhoto');
  }

  @override
  Future<void> deletePhoto(String id) async {
    throw UnimplementedError('PhotoLocalSourceImpl.deletePhoto');
  }

  @override
  Future<void> updatePhoto(PhotoModel photo) async {
    throw UnimplementedError('PhotoLocalSourceImpl.updatePhoto');
  }

  @override
  Future<PhotoModel?> getPhotoById(String id) async {
    throw UnimplementedError('PhotoLocalSourceImpl.getPhotoById');
  }

  @override
  Future<PhotoModel?> getLatestPhoto() async {
    throw UnimplementedError('PhotoLocalSourceImpl.getLatestPhoto');
  }

  @override
  Future<int> getPhotoCount() async {
    throw UnimplementedError('PhotoLocalSourceImpl.getPhotoCount');
  }
}
