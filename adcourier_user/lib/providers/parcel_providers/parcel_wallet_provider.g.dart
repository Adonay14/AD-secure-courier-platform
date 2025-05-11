// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_wallet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUserParcelWalletHash() =>
    r'41d00346bd741c933b75ef390163dec99feb5951';

/// See also [getUserParcelWallet].
@ProviderFor(getUserParcelWallet)
final getUserParcelWalletProvider = AutoDisposeStreamProvider<num?>.internal(
  getUserParcelWallet,
  name: r'getUserParcelWalletProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUserParcelWalletHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetUserParcelWalletRef = AutoDisposeStreamProviderRef<num?>;
String _$updateParcelWalletHash() =>
    r'8e858b4512d856c2bfe7ace8ebc43a8111fcff94';

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

/// See also [updateParcelWallet].
@ProviderFor(updateParcelWallet)
const updateParcelWalletProvider = UpdateParcelWalletFamily();

/// See also [updateParcelWallet].
class UpdateParcelWalletFamily extends Family<Object?> {
  /// See also [updateParcelWallet].
  const UpdateParcelWalletFamily();

  /// See also [updateParcelWallet].
  UpdateParcelWalletProvider call(
    num amount,
  ) {
    return UpdateParcelWalletProvider(
      amount,
    );
  }

  @override
  UpdateParcelWalletProvider getProviderOverride(
    covariant UpdateParcelWalletProvider provider,
  ) {
    return call(
      provider.amount,
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
  String? get name => r'updateParcelWalletProvider';
}

/// See also [updateParcelWallet].
class UpdateParcelWalletProvider extends AutoDisposeProvider<Object?> {
  /// See also [updateParcelWallet].
  UpdateParcelWalletProvider(
    num amount,
  ) : this._internal(
          (ref) => updateParcelWallet(
            ref as UpdateParcelWalletRef,
            amount,
          ),
          from: updateParcelWalletProvider,
          name: r'updateParcelWalletProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateParcelWalletHash,
          dependencies: UpdateParcelWalletFamily._dependencies,
          allTransitiveDependencies:
              UpdateParcelWalletFamily._allTransitiveDependencies,
          amount: amount,
        );

  UpdateParcelWalletProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.amount,
  }) : super.internal();

  final num amount;

  @override
  Override overrideWith(
    Object? Function(UpdateParcelWalletRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateParcelWalletProvider._internal(
        (ref) => create(ref as UpdateParcelWalletRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Object?> createElement() {
    return _UpdateParcelWalletProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateParcelWalletProvider && other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateParcelWalletRef on AutoDisposeProviderRef<Object?> {
  /// The parameter `amount` of this provider.
  num get amount;
}

class _UpdateParcelWalletProviderElement
    extends AutoDisposeProviderElement<Object?> with UpdateParcelWalletRef {
  _UpdateParcelWalletProviderElement(super.provider);

  @override
  num get amount => (origin as UpdateParcelWalletProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
