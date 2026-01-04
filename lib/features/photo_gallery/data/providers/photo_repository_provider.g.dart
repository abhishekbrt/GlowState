// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$photoBoxHash() => r'ffab457470086d288d63c9b8f7d7418e4d5245a8';

/// Provider for the Hive box storing photos
///
/// Copied from [photoBox].
@ProviderFor(photoBox)
final photoBoxProvider = Provider<Box<PhotoModel>>.internal(
  photoBox,
  name: r'photoBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PhotoBoxRef = ProviderRef<Box<PhotoModel>>;
String _$photoLocalSourceHash() => r'd0cad0d8e2ecc226e140daff87d693edf66ae4b3';

/// See also [photoLocalSource].
@ProviderFor(photoLocalSource)
final photoLocalSourceProvider = Provider<PhotoLocalSource>.internal(
  photoLocalSource,
  name: r'photoLocalSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoLocalSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PhotoLocalSourceRef = ProviderRef<PhotoLocalSource>;
String _$photoRepositoryHash() => r'731c776e0dfb857f3b24660f1e3e7cb90947ecfb';

/// See also [photoRepository].
@ProviderFor(photoRepository)
final photoRepositoryProvider = Provider<PhotoRepository>.internal(
  photoRepository,
  name: r'photoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PhotoRepositoryRef = ProviderRef<PhotoRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
