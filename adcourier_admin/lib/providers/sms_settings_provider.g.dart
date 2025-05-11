// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPhonesFromFirestoreHash() =>
    r'ae5dde3a0183e88a713f299f379cee402e1b9a1d';

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

/// See also [fetchPhonesFromFirestore].
@ProviderFor(fetchPhonesFromFirestore)
const fetchPhonesFromFirestoreProvider = FetchPhonesFromFirestoreFamily();

/// See also [fetchPhonesFromFirestore].
class FetchPhonesFromFirestoreFamily extends Family<AsyncValue<List<String>>> {
  /// See also [fetchPhonesFromFirestore].
  const FetchPhonesFromFirestoreFamily();

  /// See also [fetchPhonesFromFirestore].
  FetchPhonesFromFirestoreProvider call(
    String userCollection,
  ) {
    return FetchPhonesFromFirestoreProvider(
      userCollection,
    );
  }

  @override
  FetchPhonesFromFirestoreProvider getProviderOverride(
    covariant FetchPhonesFromFirestoreProvider provider,
  ) {
    return call(
      provider.userCollection,
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
  String? get name => r'fetchPhonesFromFirestoreProvider';
}

/// See also [fetchPhonesFromFirestore].
class FetchPhonesFromFirestoreProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [fetchPhonesFromFirestore].
  FetchPhonesFromFirestoreProvider(
    String userCollection,
  ) : this._internal(
          (ref) => fetchPhonesFromFirestore(
            ref as FetchPhonesFromFirestoreRef,
            userCollection,
          ),
          from: fetchPhonesFromFirestoreProvider,
          name: r'fetchPhonesFromFirestoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPhonesFromFirestoreHash,
          dependencies: FetchPhonesFromFirestoreFamily._dependencies,
          allTransitiveDependencies:
              FetchPhonesFromFirestoreFamily._allTransitiveDependencies,
          userCollection: userCollection,
        );

  FetchPhonesFromFirestoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userCollection,
  }) : super.internal();

  final String userCollection;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(FetchPhonesFromFirestoreRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchPhonesFromFirestoreProvider._internal(
        (ref) => create(ref as FetchPhonesFromFirestoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userCollection: userCollection,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _FetchPhonesFromFirestoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPhonesFromFirestoreProvider &&
        other.userCollection == userCollection;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userCollection.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchPhonesFromFirestoreRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `userCollection` of this provider.
  String get userCollection;
}

class _FetchPhonesFromFirestoreProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with FetchPhonesFromFirestoreRef {
  _FetchPhonesFromFirestoreProviderElement(super.provider);

  @override
  String get userCollection =>
      (origin as FetchPhonesFromFirestoreProvider).userCollection;
}

String _$smsSettingsNotifierHash() =>
    r'2870d941c3138d5b46cff05d82a4f02bbf0a4a98';

/// See also [SmsSettingsNotifier].
@ProviderFor(SmsSettingsNotifier)
final smsSettingsNotifierProvider =
    AutoDisposeNotifierProvider<SmsSettingsNotifier, SmsSettingsState>.internal(
  SmsSettingsNotifier.new,
  name: r'smsSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$smsSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SmsSettingsNotifier = AutoDisposeNotifier<SmsSettingsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
