// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timelapse_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timelapseProgressHash() => r'427192216f127b0700ab132499502600a401b8e9';

/// Provider for timelapse generation progress
///
/// Copied from [timelapseProgress].
@ProviderFor(timelapseProgress)
final timelapseProgressProvider =
    AutoDisposeStreamProvider<TimelapseProgress>.internal(
      timelapseProgress,
      name: r'timelapseProgressProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timelapseProgressHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef TimelapseProgressRef = AutoDisposeStreamProviderRef<TimelapseProgress>;
String _$allTimelapsesHash() => r'0eb0083ba367e19b5aadb43786011b2bc588b90b';

/// Provider for all generated timelapses
///
/// Copied from [allTimelapses].
@ProviderFor(allTimelapses)
final allTimelapsesProvider =
    AutoDisposeFutureProvider<List<Timelapse>>.internal(
      allTimelapses,
      name: r'allTimelapsesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$allTimelapsesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef AllTimelapsesRef = AutoDisposeFutureProviderRef<List<Timelapse>>;
String _$timelapseGeneratorHash() =>
    r'c6e5784ad9a77fb2cb56d4a4339556b6b570885f';

/// Provider for timelapse generation state
///
/// Copied from [TimelapseGenerator].
@ProviderFor(TimelapseGenerator)
final timelapseGeneratorProvider =
    AutoDisposeNotifierProvider<
      TimelapseGenerator,
      AsyncValue<Timelapse?>
    >.internal(
      TimelapseGenerator.new,
      name: r'timelapseGeneratorProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timelapseGeneratorHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TimelapseGenerator = AutoDisposeNotifier<AsyncValue<Timelapse?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
