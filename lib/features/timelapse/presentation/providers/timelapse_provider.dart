import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:glowstate/features/timelapse/data/providers/timelapse_repository_provider.dart';
import 'package:glowstate/features/timelapse/domain/entities/timelapse.dart';
import 'package:glowstate/features/timelapse/domain/repositories/timelapse_repository.dart';

part 'timelapse_provider.g.dart';

/// Provider for timelapse generation state
@riverpod
class TimelapseGenerator extends _$TimelapseGenerator {
  @override
  AsyncValue<Timelapse?> build() {
    return const AsyncData(null);
  }

  Future<void> generate({
    required DateTime startDate,
    required DateTime endDate,
    bool includePrivate = true,
  }) async {
    // TODO: Implement - generate timelapse from photos
    throw UnimplementedError('TimelapseGenerator.generate');
  }

  Future<void> cancel() async {
    // TODO: Implement - cancel generation
    throw UnimplementedError('TimelapseGenerator.cancel');
  }
}

/// Provider for timelapse generation progress
@riverpod
Stream<TimelapseProgress> timelapseProgress(TimelapseProgressRef ref) async* {
  // TODO: Implement - stream progress updates
  throw UnimplementedError('timelapseProgress');
}

/// Provider for all generated timelapses
@riverpod
Future<List<Timelapse>> allTimelapses(AllTimelapsesRef ref) async {
  final repository = ref.watch(timelapseRepositoryProvider);
  return repository.getAllTimelapses();
}
