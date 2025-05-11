// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchEmailsFromFirestoreHash() =>
    r'215e96db450f015efc2a412f0c7d68b5caee1a4b';

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

/// See also [fetchEmailsFromFirestore].
@ProviderFor(fetchEmailsFromFirestore)
const fetchEmailsFromFirestoreProvider = FetchEmailsFromFirestoreFamily();

/// See also [fetchEmailsFromFirestore].
class FetchEmailsFromFirestoreFamily extends Family<AsyncValue<List<String>>> {
  /// See also [fetchEmailsFromFirestore].
  const FetchEmailsFromFirestoreFamily();

  /// See also [fetchEmailsFromFirestore].
  FetchEmailsFromFirestoreProvider call(
    String userCollection,
  ) {
    return FetchEmailsFromFirestoreProvider(
      userCollection,
    );
  }

  @override
  FetchEmailsFromFirestoreProvider getProviderOverride(
    covariant FetchEmailsFromFirestoreProvider provider,
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
  String? get name => r'fetchEmailsFromFirestoreProvider';
}

/// See also [fetchEmailsFromFirestore].
class FetchEmailsFromFirestoreProvider
    extends AutoDisposeFutureProvider<List<String>> {
  /// See also [fetchEmailsFromFirestore].
  FetchEmailsFromFirestoreProvider(
    String userCollection,
  ) : this._internal(
          (ref) => fetchEmailsFromFirestore(
            ref as FetchEmailsFromFirestoreRef,
            userCollection,
          ),
          from: fetchEmailsFromFirestoreProvider,
          name: r'fetchEmailsFromFirestoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchEmailsFromFirestoreHash,
          dependencies: FetchEmailsFromFirestoreFamily._dependencies,
          allTransitiveDependencies:
              FetchEmailsFromFirestoreFamily._allTransitiveDependencies,
          userCollection: userCollection,
        );

  FetchEmailsFromFirestoreProvider._internal(
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
    FutureOr<List<String>> Function(FetchEmailsFromFirestoreRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchEmailsFromFirestoreProvider._internal(
        (ref) => create(ref as FetchEmailsFromFirestoreRef),
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
    return _FetchEmailsFromFirestoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchEmailsFromFirestoreProvider &&
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
mixin FetchEmailsFromFirestoreRef
    on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `userCollection` of this provider.
  String get userCollection;
}

class _FetchEmailsFromFirestoreProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with FetchEmailsFromFirestoreRef {
  _FetchEmailsFromFirestoreProviderElement(super.provider);

  @override
  String get userCollection =>
      (origin as FetchEmailsFromFirestoreProvider).userCollection;
}

String _$emailSettingsNotifierHash() =>
    r'1ca08d8867c29e7df78223ca4f8d22abcbb32722';

/// See also [EmailSettingsNotifier].
@ProviderFor(EmailSettingsNotifier)
final emailSettingsNotifierProvider = AutoDisposeNotifierProvider<
    EmailSettingsNotifier, EmailSettingsModel>.internal(
  EmailSettingsNotifier.new,
  name: r'emailSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emailSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EmailSettingsNotifier = AutoDisposeNotifier<EmailSettingsModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
