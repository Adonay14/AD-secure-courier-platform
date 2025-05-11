// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_distance_calculation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calculateDistanceHash() => r'62e44d20188a09fc21760f2051468122b53f1e71';

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

/// See also [calculateDistance].
@ProviderFor(calculateDistance)
const calculateDistanceProvider = CalculateDistanceFamily();

/// See also [calculateDistance].
class CalculateDistanceFamily extends Family<double> {
  /// See also [calculateDistance].
  const CalculateDistanceFamily();

  /// See also [calculateDistance].
  CalculateDistanceProvider call(
    dynamic lat1,
    dynamic lon1,
    dynamic lat2,
    dynamic lon2,
  ) {
    return CalculateDistanceProvider(
      lat1,
      lon1,
      lat2,
      lon2,
    );
  }

  @override
  CalculateDistanceProvider getProviderOverride(
    covariant CalculateDistanceProvider provider,
  ) {
    return call(
      provider.lat1,
      provider.lon1,
      provider.lat2,
      provider.lon2,
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
  String? get name => r'calculateDistanceProvider';
}

/// See also [calculateDistance].
class CalculateDistanceProvider extends AutoDisposeProvider<double> {
  /// See also [calculateDistance].
  CalculateDistanceProvider(
    dynamic lat1,
    dynamic lon1,
    dynamic lat2,
    dynamic lon2,
  ) : this._internal(
          (ref) => calculateDistance(
            ref as CalculateDistanceRef,
            lat1,
            lon1,
            lat2,
            lon2,
          ),
          from: calculateDistanceProvider,
          name: r'calculateDistanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calculateDistanceHash,
          dependencies: CalculateDistanceFamily._dependencies,
          allTransitiveDependencies:
              CalculateDistanceFamily._allTransitiveDependencies,
          lat1: lat1,
          lon1: lon1,
          lat2: lat2,
          lon2: lon2,
        );

  CalculateDistanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lat1,
    required this.lon1,
    required this.lat2,
    required this.lon2,
  }) : super.internal();

  final dynamic lat1;
  final dynamic lon1;
  final dynamic lat2;
  final dynamic lon2;

  @override
  Override overrideWith(
    double Function(CalculateDistanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CalculateDistanceProvider._internal(
        (ref) => create(ref as CalculateDistanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lat1: lat1,
        lon1: lon1,
        lat2: lat2,
        lon2: lon2,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _CalculateDistanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalculateDistanceProvider &&
        other.lat1 == lat1 &&
        other.lon1 == lon1 &&
        other.lat2 == lat2 &&
        other.lon2 == lon2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lat1.hashCode);
    hash = _SystemHash.combine(hash, lon1.hashCode);
    hash = _SystemHash.combine(hash, lat2.hashCode);
    hash = _SystemHash.combine(hash, lon2.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalculateDistanceRef on AutoDisposeProviderRef<double> {
  /// The parameter `lat1` of this provider.
  dynamic get lat1;

  /// The parameter `lon1` of this provider.
  dynamic get lon1;

  /// The parameter `lat2` of this provider.
  dynamic get lat2;

  /// The parameter `lon2` of this provider.
  dynamic get lon2;
}

class _CalculateDistanceProviderElement
    extends AutoDisposeProviderElement<double> with CalculateDistanceRef {
  _CalculateDistanceProviderElement(super.provider);

  @override
  dynamic get lat1 => (origin as CalculateDistanceProvider).lat1;
  @override
  dynamic get lon1 => (origin as CalculateDistanceProvider).lon1;
  @override
  dynamic get lat2 => (origin as CalculateDistanceProvider).lat2;
  @override
  dynamic get lon2 => (origin as CalculateDistanceProvider).lon2;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
