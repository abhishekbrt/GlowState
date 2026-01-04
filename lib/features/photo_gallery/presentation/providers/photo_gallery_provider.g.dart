// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_gallery_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$photosForDateHash() => r'c4a8d7557c29dfe14caaaad6e0beb82edb1c251a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for photos on a specific date
///
/// Copied from [photosForDate].
@ProviderFor(photosForDate)
const photosForDateProvider = PhotosForDateFamily();

/// Provider for photos on a specific date
///
/// Copied from [photosForDate].
class PhotosForDateFamily extends Family<AsyncValue<List<PhotoRecord>>> {
  /// Provider for photos on a specific date
  ///
  /// Copied from [photosForDate].
  const PhotosForDateFamily();

  /// Provider for photos on a specific date
  ///
  /// Copied from [photosForDate].
  PhotosForDateProvider call(DateTime date) {
    return PhotosForDateProvider(date);
  }

  @override
  PhotosForDateProvider getProviderOverride(
    covariant PhotosForDateProvider provider,
  ) {
    return call(provider.date);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'photosForDateProvider';
}

/// Provider for photos on a specific date
///
/// Copied from [photosForDate].
class PhotosForDateProvider
    extends AutoDisposeFutureProvider<List<PhotoRecord>> {
  /// Provider for photos on a specific date
  ///
  /// Copied from [photosForDate].
  PhotosForDateProvider(DateTime date)
    : this._internal(
        (ref) => photosForDate(ref as PhotosForDateRef, date),
        from: photosForDateProvider,
        name: r'photosForDateProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$photosForDateHash,
        dependencies: PhotosForDateFamily._dependencies,
        allTransitiveDependencies:
            PhotosForDateFamily._allTransitiveDependencies,
        date: date,
      );

  PhotosForDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    FutureOr<List<PhotoRecord>> Function(PhotosForDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PhotosForDateProvider._internal(
        (ref) => create(ref as PhotosForDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PhotoRecord>> createElement() {
    return _PhotosForDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PhotosForDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PhotosForDateRef on AutoDisposeFutureProviderRef<List<PhotoRecord>> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _PhotosForDateProviderElement
    extends AutoDisposeFutureProviderElement<List<PhotoRecord>>
    with PhotosForDateRef {
  _PhotosForDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as PhotosForDateProvider).date;
}

String _$photoCountHash() => r'4610a5a0b7ea87ab16a8378812bac4a0b23a8733';

/// Provider for total photo count
///
/// Copied from [photoCount].
@ProviderFor(photoCount)
final photoCountProvider = AutoDisposeFutureProvider<int>.internal(
  photoCount,
  name: r'photoCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$photoCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PhotoCountRef = AutoDisposeFutureProviderRef<int>;
String _$latestPhotoHash() => r'c9d41f64ee4abe6fa1976754c689873af7008d6b';

/// Provider for latest photo (used by camera for ghost overlay)
///
/// Copied from [latestPhoto].
@ProviderFor(latestPhoto)
final latestPhotoProvider = AutoDisposeFutureProvider<PhotoRecord?>.internal(
  latestPhoto,
  name: r'latestPhotoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestPhotoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LatestPhotoRef = AutoDisposeFutureProviderRef<PhotoRecord?>;
String _$photoGalleryHash() => r'32b8bc9f4e8baa80e0c303ead29599aadcab9292';

/// Provider for photo gallery state
///
/// Copied from [PhotoGallery].
@ProviderFor(PhotoGallery)
final photoGalleryProvider =
    AutoDisposeAsyncNotifierProvider<PhotoGallery, List<PhotoRecord>>.internal(
      PhotoGallery.new,
      name: r'photoGalleryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$photoGalleryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PhotoGallery = AutoDisposeAsyncNotifier<List<PhotoRecord>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
