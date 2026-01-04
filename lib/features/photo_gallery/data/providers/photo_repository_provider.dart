import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/photo_gallery/data/datasources/photo_local_source.dart';
import 'package:glowstate/features/photo_gallery/data/repositories/photo_repository_impl.dart';
import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';

part 'photo_repository_provider.g.dart';

@Riverpod(keepAlive: true)
PhotoLocalSource photoLocalSource(PhotoLocalSourceRef ref) {
  return PhotoLocalSourceImpl();
}

@Riverpod(keepAlive: true)
PhotoRepository photoRepository(PhotoRepositoryRef ref) {
  return PhotoRepositoryImpl(localSource: ref.watch(photoLocalSourceProvider));
}
