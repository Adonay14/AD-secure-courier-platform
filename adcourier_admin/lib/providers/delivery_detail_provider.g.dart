// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deliveryDetailsNotifierHash() =>
    r'e53351c677b187890fb827699f9b25456b98e12b';

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

abstract class _$DeliveryDetailsNotifier
    extends BuildlessAutoDisposeStreamNotifier<DeliveryDetails?> {
  late final String userID;

  Stream<DeliveryDetails?> build(
    String userID,
  );
}

/// See also [DeliveryDetailsNotifier].
@ProviderFor(DeliveryDetailsNotifier)
const deliveryDetailsNotifierProvider = DeliveryDetailsNotifierFamily();

/// See also [DeliveryDetailsNotifier].
class DeliveryDetailsNotifierFamily
    extends Family<AsyncValue<DeliveryDetails?>> {
  /// See also [DeliveryDetailsNotifier].
  const DeliveryDetailsNotifierFamily();

  /// See also [DeliveryDetailsNotifier].
  DeliveryDetailsNotifierProvider call(
    String userID,
  ) {
    return DeliveryDetailsNotifierProvider(
      userID,
    );
  }

  @override
  DeliveryDetailsNotifierProvider getProviderOverride(
    covariant DeliveryDetailsNotifierProvider provider,
  ) {
    return call(
      provider.userID,
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
  String? get name => r'deliveryDetailsNotifierProvider';
}

/// See also [DeliveryDetailsNotifier].
class DeliveryDetailsNotifierProvider
    extends AutoDisposeStreamNotifierProviderImpl<DeliveryDetailsNotifier,
        DeliveryDetails?> {
  /// See also [DeliveryDetailsNotifier].
  DeliveryDetailsNotifierProvider(
    String userID,
  ) : this._internal(
          () => DeliveryDetailsNotifier()..userID = userID,
          from: deliveryDetailsNotifierProvider,
          name: r'deliveryDetailsNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryDetailsNotifierHash,
          dependencies: DeliveryDetailsNotifierFamily._dependencies,
          allTransitiveDependencies:
              DeliveryDetailsNotifierFamily._allTransitiveDependencies,
          userID: userID,
        );

  DeliveryDetailsNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userID,
  }) : super.internal();

  final String userID;

  @override
  Stream<DeliveryDetails?> runNotifierBuild(
    covariant DeliveryDetailsNotifier notifier,
  ) {
    return notifier.build(
      userID,
    );
  }

  @override
  Override overrideWith(DeliveryDetailsNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeliveryDetailsNotifierProvider._internal(
        () => create()..userID = userID,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userID: userID,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<DeliveryDetailsNotifier,
      DeliveryDetails?> createElement() {
    return _DeliveryDetailsNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryDetailsNotifierProvider && other.userID == userID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeliveryDetailsNotifierRef
    on AutoDisposeStreamNotifierProviderRef<DeliveryDetails?> {
  /// The parameter `userID` of this provider.
  String get userID;
}

class _DeliveryDetailsNotifierProviderElement
    extends AutoDisposeStreamNotifierProviderElement<DeliveryDetailsNotifier,
        DeliveryDetails?> with DeliveryDetailsNotifierRef {
  _DeliveryDetailsNotifierProviderElement(super.provider);

  @override
  String get userID => (origin as DeliveryDetailsNotifierProvider).userID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
