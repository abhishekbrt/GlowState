import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/timelapse/data/datasources/video_generator_source.dart';
import 'package:glowstate/features/timelapse/data/repositories/timelapse_repository_impl.dart';
import 'package:glowstate/features/timelapse/domain/repositories/timelapse_repository.dart';

part 'timelapse_repository_provider.g.dart';

@Riverpod(keepAlive: true)
VideoGeneratorSource videoGeneratorSource(VideoGeneratorSourceRef ref) {
  return VideoGeneratorSourceImpl();
}

@Riverpod(keepAlive: true)
TimelapseRepository timelapseRepository(TimelapseRepositoryRef ref) {
  return TimelapseRepositoryImpl(
    videoGeneratorSource: ref.watch(videoGeneratorSourceProvider),
  );
}
