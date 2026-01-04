import 'package:glowstate/shared/domain/entities/photo_record.dart';

import '../../domain/entities/timelapse.dart';
import '../../domain/repositories/timelapse_repository.dart';
import '../datasources/video_generator_source.dart';

/// Implementation of [TimelapseRepository]
///
/// Uses shared [PhotoRecord] for input photos.
class TimelapseRepositoryImpl implements TimelapseRepository {
  final VideoGeneratorSource videoGeneratorSource;

  TimelapseRepositoryImpl({required this.videoGeneratorSource});

  @override
  Future<Timelapse> generate({
    required List<PhotoRecord> photos,
    int fps = 10,
  }) async {
    // TODO: Implement - generate video from photos using FFmpeg
    throw UnimplementedError('TimelapseRepositoryImpl.generate');
  }

  @override
  Stream<TimelapseProgress> generateWithProgress({
    required List<PhotoRecord> photos,
    int fps = 10,
  }) {
    // TODO: Implement - generate with progress updates
    throw UnimplementedError('TimelapseRepositoryImpl.generateWithProgress');
  }

  @override
  Future<List<Timelapse>> getAllTimelapses() async {
    // TODO: Implement - get all generated timelapses
    throw UnimplementedError('TimelapseRepositoryImpl.getAllTimelapses');
  }

  @override
  Future<Timelapse?> getTimelapseById(String id) async {
    // TODO: Implement - get specific timelapse
    throw UnimplementedError('TimelapseRepositoryImpl.getTimelapseById');
  }

  @override
  Future<void> deleteTimelapse(String id) async {
    // TODO: Implement - delete timelapse video
    throw UnimplementedError('TimelapseRepositoryImpl.deleteTimelapse');
  }

  @override
  Future<bool> isSupported() async {
    // TODO: Implement - check FFmpeg availability
    throw UnimplementedError('TimelapseRepositoryImpl.isSupported');
  }
}
