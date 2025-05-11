// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCategoriesForBannerHash() =>
    r'c6ddc434b1e7b64baff2b90c4c12976cf8590b4f';

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

/// See also [getCategoriesForBanner].
@ProviderFor(getCategoriesForBanner)
const getCategoriesForBannerProvider = GetCategoriesForBannerFamily();

/// See also [getCategoriesForBanner].
class GetCategoriesForBannerFamily extends Family<AsyncValue<List<String>>> {
  /// See also [getCategoriesForBanner].
  const GetCategoriesForBannerFamily();

  /// See also [getCategoriesForBanner].
  GetCategoriesForBannerProvider call(
    String module,
  ) {
    return GetCategoriesForBannerProvider(
      module,
    );
  }

  @override
  GetCategoriesForBannerProvider getProviderOverride(
    covariant GetCategoriesForBannerProvider provider,
  ) {
    return call(
      provider.module,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getCategoriesForBannerProvider';
}

/// See also [getCategoriesForBanner].
class GetCategoriesForBannerProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getCategoriesForBanner].
  GetCategoriesForBannerProvider(
    String module,
  ) : this._internal(
          (ref) => getCategoriesForBanner(
            ref as GetCategoriesForBannerRef,
            module,
          ),
          from: getCategoriesForBannerProvider,
          name: r'getCategoriesForBannerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCategoriesForBannerHash,
          dependencies: GetCategoriesForBannerFamily._dependencies,
          allTransitiveDependencies:
              GetCategoriesForBannerFamily._allTransitiveDependencies,
          module: module,
        );

  GetCategoriesForBannerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.module,
  }) : super.internal();

  final String module;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(GetCategoriesForBannerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCategoriesForBannerProvider._internal(
        (ref) => create(ref as GetCategoriesForBannerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        module: module,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _GetCategoriesForBannerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCategoriesForBannerProvider && other.module == module;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, module.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetCategoriesForBannerRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `module` of this provider.
  String get module;
}

class _GetCategoriesForBannerProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetCategoriesForBannerRef {
  _GetCategoriesForBannerProviderElement(super.provider);

  @override
  String get module => (origin as GetCategoriesForBannerProvider).module;
}

String _$getSubCategoriesForBannerHash() =>
    r'1a0fe2f778b3186bcd826a57f77b96c9557b5d37';

/// See also [getSubCategoriesForBanner].
@ProviderFor(getSubCategoriesForBanner)
const getSubCategoriesForBannerProvider = GetSubCategoriesForBannerFamily();

/// See also [getSubCategoriesForBanner].
class GetSubCategoriesForBannerFamily extends Family<AsyncValue<List<String>>> {
  /// See also [getSubCategoriesForBanner].
  const GetSubCategoriesForBannerFamily();

  /// See also [getSubCategoriesForBanner].
  GetSubCategoriesForBannerProvider call(
    String category,
  ) {
    return GetSubCategoriesForBannerProvider(
      category,
    );
  }

  @override
  GetSubCategoriesForBannerProvider getProviderOverride(
    covariant GetSubCategoriesForBannerProvider provider,
  ) {
    return call(
      provider.category,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSubCategoriesForBannerProvider';
}

/// See also [getSubCategoriesForBanner].
class GetSubCategoriesForBannerProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getSubCategoriesForBanner].
  GetSubCategoriesForBannerProvider(
    String category,
  ) : this._internal(
          (ref) => getSubCategoriesForBanner(
            ref as GetSubCategoriesForBannerRef,
            category,
          ),
          from: getSubCategoriesForBannerProvider,
          name: r'getSubCategoriesForBannerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSubCategoriesForBannerHash,
          dependencies: GetSubCategoriesForBannerFamily._dependencies,
          allTransitiveDependencies:
              GetSubCategoriesForBannerFamily._allTransitiveDependencies,
          category: category,
        );

  GetSubCategoriesForBannerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(GetSubCategoriesForBannerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSubCategoriesForBannerProvider._internal(
        (ref) => create(ref as GetSubCategoriesForBannerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _GetSubCategoriesForBannerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSubCategoriesForBannerProvider &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetSubCategoriesForBannerRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _GetSubCategoriesForBannerProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetSubCategoriesForBannerRef {
  _GetSubCategoriesForBannerProviderElement(super.provider);

  @override
  String get category => (origin as GetSubCategoriesForBannerProvider).category;
}

String _$getSubCategoriesCollectionsForBannerHash() =>
    r'c82632cc346e5c9ad8e9f615578b9ee58dbc45f9';

/// See also [getSubCategoriesCollectionsForBanner].
@ProviderFor(getSubCategoriesCollectionsForBanner)
const getSubCategoriesCollectionsForBannerProvider =
    GetSubCategoriesCollectionsForBannerFamily();

/// See also [getSubCategoriesCollectionsForBanner].
class GetSubCategoriesCollectionsForBannerFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [getSubCategoriesCollectionsForBanner].
  const GetSubCategoriesCollectionsForBannerFamily();

  /// See also [getSubCategoriesCollectionsForBanner].
  GetSubCategoriesCollectionsForBannerProvider call(
    String subcategory,
  ) {
    return GetSubCategoriesCollectionsForBannerProvider(
      subcategory,
    );
  }

  @override
  GetSubCategoriesCollectionsForBannerProvider getProviderOverride(
    covariant GetSubCategoriesCollectionsForBannerProvider provider,
  ) {
    return call(
      provider.subcategory,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSubCategoriesCollectionsForBannerProvider';
}

/// See also [getSubCategoriesCollectionsForBanner].
class GetSubCategoriesCollectionsForBannerProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getSubCategoriesCollectionsForBanner].
  GetSubCategoriesCollectionsForBannerProvider(
    String subcategory,
  ) : this._internal(
          (ref) => getSubCategoriesCollectionsForBanner(
            ref as GetSubCategoriesCollectionsForBannerRef,
            subcategory,
          ),
          from: getSubCategoriesCollectionsForBannerProvider,
          name: r'getSubCategoriesCollectionsForBannerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSubCategoriesCollectionsForBannerHash,
          dependencies:
              GetSubCategoriesCollectionsForBannerFamily._dependencies,
          allTransitiveDependencies: GetSubCategoriesCollectionsForBannerFamily
              ._allTransitiveDependencies,
          subcategory: subcategory,
        );

  GetSubCategoriesCollectionsForBannerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subcategory,
  }) : super.internal();

  final String subcategory;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(
            GetSubCategoriesCollectionsForBannerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSubCategoriesCollectionsForBannerProvider._internal(
        (ref) => create(ref as GetSubCategoriesCollectionsForBannerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subcategory: subcategory,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _GetSubCategoriesCollectionsForBannerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSubCategoriesCollectionsForBannerProvider &&
        other.subcategory == subcategory;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subcategory.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetSubCategoriesCollectionsForBannerRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `subcategory` of this provider.
  String get subcategory;
}

class _GetSubCategoriesCollectionsForBannerProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetSubCategoriesCollectionsForBannerRef {
  _GetSubCategoriesCollectionsForBannerProviderElement(super.provider);

  @override
  String get subcategory =>
      (origin as GetSubCategoriesCollectionsForBannerProvider).subcategory;
}

String _$getBannersHash() => r'a9f9fde9b8c19d2cbb55ca68231bf8ec819d2e2b';

/// See also [getBanners].
@ProviderFor(getBanners)
final getBannersProvider = AutoDisposeStreamProvider<List<FeedsModel>>.internal(
  getBanners,
  name: r'getBannersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getBannersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetBannersRef = AutoDisposeStreamProviderRef<List<FeedsModel>>;
String _$allBannerHash() => r'27322863b8fc5441be9f264d4095046280cb75b7';

/// See also [AllBanner].
@ProviderFor(AllBanner)
final allBannerProvider =
    AutoDisposeNotifierProvider<AllBanner, FeedsModel>.internal(
  AllBanner.new,
  name: r'allBannerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allBannerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllBanner = AutoDisposeNotifier<FeedsModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
