// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ghostOverlayPathHash() => r'e235f393f74a7cfeef82b46cfae656723621ec0b';

/// See also [ghostOverlayPath].
@ProviderFor(ghostOverlayPath)
final ghostOverlayPathProvider = AutoDisposeFutureProvider<String?>.internal(
  ghostOverlayPath,
  name: r'ghostOverlayPathProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ghostOverlayPathHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GhostOverlayPathRef = AutoDisposeFutureProviderRef<String?>;
String _$cameraHash() => r'5366c42b1a93447551d7d29bb681be6850bed476';

/// See also [Camera].
@ProviderFor(Camera)
final cameraProvider =
    AutoDisposeNotifierProvider<Camera, CameraState>.internal(
      Camera.new,
      name: r'cameraProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cameraHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Camera = AutoDisposeNotifier<CameraState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
