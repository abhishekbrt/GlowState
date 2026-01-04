import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/photo_gallery/data/datasources/photo_local_source.dart';
import 'package:glowstate/features/photo_gallery/data/models/photo_model.dart';
import 'package:glowstate/features/photo_gallery/data/repositories/photo_repository_impl.dart';
import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';

part 'photo_repository_provider.g.dart';

/// Provider for the Hive box storing photos
@Riverpod(keepAlive: true)
Box<PhotoModel> photoBox(PhotoBoxRef ref) {
  // This will be overridden in main.dart after Hive initialization
  throw UnimplementedError('photoBox must be overridden with a valid Box');
}

@Riverpod(keepAlive: true)
PhotoLocalSource photoLocalSource(PhotoLocalSourceRef ref) {
  final box = ref.watch(photoBoxProvider);
  return PhotoLocalSourceImpl(box: box);
}

@Riverpod(keepAlive: true)
PhotoRepository photoRepository(PhotoRepositoryRef ref) {
  return PhotoRepositoryImpl(localSource: ref.watch(photoLocalSourceProvider));
}
