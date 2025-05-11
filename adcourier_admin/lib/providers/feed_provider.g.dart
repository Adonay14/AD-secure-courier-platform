// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCategoriesForFeedsHash() =>
    r'728fcfa93e44dcbc23eb24643b4ecf5a48be606e';

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

/// See also [getCategoriesForFeeds].
@ProviderFor(getCategoriesForFeeds)
const getCategoriesForFeedsProvider = GetCategoriesForFeedsFamily();

/// See also [getCategoriesForFeeds].
class GetCategoriesForFeedsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [getCategoriesForFeeds].
  const GetCategoriesForFeedsFamily();

  /// See also [getCategoriesForFeeds].
  GetCategoriesForFeedsProvider call(
    String module,
  ) {
    return GetCategoriesForFeedsProvider(
      module,
    );
  }

  @override
  GetCategoriesForFeedsProvider getProviderOverride(
    covariant GetCategoriesForFeedsProvider provider,
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
  String? get name => r'getCategoriesForFeedsProvider';
}

/// See also [getCategoriesForFeeds].
class GetCategoriesForFeedsProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getCategoriesForFeeds].
  GetCategoriesForFeedsProvider(
    String module,
  ) : this._internal(
          (ref) => getCategoriesForFeeds(
            ref as GetCategoriesForFeedsRef,
            module,
          ),
          from: getCategoriesForFeedsProvider,
          name: r'getCategoriesForFeedsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCategoriesForFeedsHash,
          dependencies: GetCategoriesForFeedsFamily._dependencies,
          allTransitiveDependencies:
              GetCategoriesForFeedsFamily._allTransitiveDependencies,
          module: module,
        );

  GetCategoriesForFeedsProvider._internal(
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
    FutureOr<List<String>> Function(GetCategoriesForFeedsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCategoriesForFeedsProvider._internal(
        (ref) => create(ref as GetCategoriesForFeedsRef),
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
    return _GetCategoriesForFeedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCategoriesForFeedsProvider && other.module == module;
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
mixin GetCategoriesForFeedsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `module` of this provider.
  String get module;
}

class _GetCategoriesForFeedsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetCategoriesForFeedsRef {
  _GetCategoriesForFeedsProviderElement(super.provider);

  @override
  String get module => (origin as GetCategoriesForFeedsProvider).module;
}

String _$getSubCategoriesForFeedsHash() =>
    r'c11d8da81eec29d7de2369ca2d2a7c7ced09a04e';

/// See also [getSubCategoriesForFeeds].
@ProviderFor(getSubCategoriesForFeeds)
const getSubCategoriesForFeedsProvider = GetSubCategoriesForFeedsFamily();

/// See also [getSubCategoriesForFeeds].
class GetSubCategoriesForFeedsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [getSubCategoriesForFeeds].
  const GetSubCategoriesForFeedsFamily();

  /// See also [getSubCategoriesForFeeds].
  GetSubCategoriesForFeedsProvider call(
    String category,
  ) {
    return GetSubCategoriesForFeedsProvider(
      category,
    );
  }

  @override
  GetSubCategoriesForFeedsProvider getProviderOverride(
    covariant GetSubCategoriesForFeedsProvider provider,
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
  String? get name => r'getSubCategoriesForFeedsProvider';
}

/// See also [getSubCategoriesForFeeds].
class GetSubCategoriesForFeedsProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getSubCategoriesForFeeds].
  GetSubCategoriesForFeedsProvider(
    String category,
  ) : this._internal(
          (ref) => getSubCategoriesForFeeds(
            ref as GetSubCategoriesForFeedsRef,
            category,
          ),
          from: getSubCategoriesForFeedsProvider,
          name: r'getSubCategoriesForFeedsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSubCategoriesForFeedsHash,
          dependencies: GetSubCategoriesForFeedsFamily._dependencies,
          allTransitiveDependencies:
              GetSubCategoriesForFeedsFamily._allTransitiveDependencies,
          category: category,
        );

  GetSubCategoriesForFeedsProvider._internal(
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
    FutureOr<List<String>> Function(GetSubCategoriesForFeedsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSubCategoriesForFeedsProvider._internal(
        (ref) => create(ref as GetSubCategoriesForFeedsRef),
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
    return _GetSubCategoriesForFeedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSubCategoriesForFeedsProvider &&
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
mixin GetSubCategoriesForFeedsRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _GetSubCategoriesForFeedsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetSubCategoriesForFeedsRef {
  _GetSubCategoriesForFeedsProviderElement(super.provider);

  @override
  String get category => (origin as GetSubCategoriesForFeedsProvider).category;
}

String _$getSubCategoriesCollectionsForFeedsHash() =>
    r'db7675c1f9ea092cad10cfb9963983f1976e5c18';

/// See also [getSubCategoriesCollectionsForFeeds].
@ProviderFor(getSubCategoriesCollectionsForFeeds)
const getSubCategoriesCollectionsForFeedsProvider =
    GetSubCategoriesCollectionsForFeedsFamily();

/// See also [getSubCategoriesCollectionsForFeeds].
class GetSubCategoriesCollectionsForFeedsFamily
    extends Family<AsyncValue<List<String>>> {
  /// See also [getSubCategoriesCollectionsForFeeds].
  const GetSubCategoriesCollectionsForFeedsFamily();

  /// See also [getSubCategoriesCollectionsForFeeds].
  GetSubCategoriesCollectionsForFeedsProvider call(
    String subcategory,
  ) {
    return GetSubCategoriesCollectionsForFeedsProvider(
      subcategory,
    );
  }

  @override
  GetSubCategoriesCollectionsForFeedsProvider getProviderOverride(
    covariant GetSubCategoriesCollectionsForFeedsProvider provider,
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
  String? get name => r'getSubCategoriesCollectionsForFeedsProvider';
}

/// See also [getSubCategoriesCollectionsForFeeds].
class GetSubCategoriesCollectionsForFeedsProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [getSubCategoriesCollectionsForFeeds].
  GetSubCategoriesCollectionsForFeedsProvider(
    String subcategory,
  ) : this._internal(
          (ref) => getSubCategoriesCollectionsForFeeds(
            ref as GetSubCategoriesCollectionsForFeedsRef,
            subcategory,
          ),
          from: getSubCategoriesCollectionsForFeedsProvider,
          name: r'getSubCategoriesCollectionsForFeedsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSubCategoriesCollectionsForFeedsHash,
          dependencies: GetSubCategoriesCollectionsForFeedsFamily._dependencies,
          allTransitiveDependencies: GetSubCategoriesCollectionsForFeedsFamily
              ._allTransitiveDependencies,
          subcategory: subcategory,
        );

  GetSubCategoriesCollectionsForFeedsProvider._internal(
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
            GetSubCategoriesCollectionsForFeedsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSubCategoriesCollectionsForFeedsProvider._internal(
        (ref) => create(ref as GetSubCategoriesCollectionsForFeedsRef),
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
    return _GetSubCategoriesCollectionsForFeedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSubCategoriesCollectionsForFeedsProvider &&
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
mixin GetSubCategoriesCollectionsForFeedsRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `subcategory` of this provider.
  String get subcategory;
}

class _GetSubCategoriesCollectionsForFeedsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with GetSubCategoriesCollectionsForFeedsRef {
  _GetSubCategoriesCollectionsForFeedsProviderElement(super.provider);

  @override
  String get subcategory =>
      (origin as GetSubCategoriesCollectionsForFeedsProvider).subcategory;
}

String _$getFeedsHash() => r'2a37f04f5249356d068047a151cac6fcb8fdf7db';

/// See also [getFeeds].
@ProviderFor(getFeeds)
final getFeedsProvider = AutoDisposeStreamProvider<List<FeedsModel>>.internal(
  getFeeds,
  name: r'getFeedsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getFeedsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetFeedsRef = AutoDisposeStreamProviderRef<List<FeedsModel>>;
String _$allFeedsHash() => r'39693bd17d862a109e0c41bdb96db3689ddb25bb';

/// See also [AllFeeds].
@ProviderFor(AllFeeds)
final allFeedsProvider =
    AutoDisposeNotifierProvider<AllFeeds, FeedsModel>.internal(
  AllFeeds.new,
  name: r'allFeedsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allFeedsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AllFeeds = AutoDisposeNotifier<FeedsModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
