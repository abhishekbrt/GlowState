// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$totalPointsHash() => r'6a7332dcd4a5a1bbbf36f25119cbd803f6a873ca';

/// See also [totalPoints].
@ProviderFor(totalPoints)
final totalPointsProvider = AutoDisposeFutureProvider<int>.internal(
  totalPoints,
  name: r'totalPointsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalPointsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TotalPointsRef = AutoDisposeFutureProviderRef<int>;
String _$todayCheckInsHash() => r'fdcdf8134b1cbb51ebe1903454f063764148d04e';

/// See also [TodayCheckIns].
@ProviderFor(TodayCheckIns)
final todayCheckInsProvider =
    AutoDisposeAsyncNotifierProvider<
      TodayCheckIns,
      TodayCheckInStatus
    >.internal(
      TodayCheckIns.new,
      name: r'todayCheckInsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayCheckInsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodayCheckIns = AutoDisposeAsyncNotifier<TodayCheckInStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
