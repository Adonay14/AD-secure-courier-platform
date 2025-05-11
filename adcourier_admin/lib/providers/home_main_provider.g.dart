// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_main_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseDetailsHash() => r'7980323ccf3c24bd0c6ab50a661586dac68b6a7e';

/// See also [firebaseDetails].
@ProviderFor(firebaseDetails)
final firebaseDetailsProvider =
    AutoDisposeFutureProvider<Map<String, String>>.internal(
  firebaseDetails,
  name: r'firebaseDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirebaseDetailsRef = AutoDisposeFutureProviderRef<Map<String, String>>;
String _$themeModeHash() => r'ac93804cae792c8ed0bd7663a484ae1278e5b817';

/// See also [themeMode].
@ProviderFor(themeMode)
final themeModeProvider = FutureProvider<bool>.internal(
  themeMode,
  name: r'themeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeRef = FutureProviderRef<bool>;
String _$initAuthHash() => r'23797ed3d96afa680635f29292016e49fd9ffc8e';

/// See also [initAuth].
@ProviderFor(initAuth)
final initAuthProvider = FutureProvider<void>.internal(
  initAuth,
  name: r'initAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$initAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitAuthRef = FutureProviderRef<void>;
String _$themeNotifierProviderHash() =>
    r'b8675f33f971c178549dbebacc1e6565f4ae42f8';

/// See also [ThemeNotifierProvider].
@ProviderFor(ThemeNotifierProvider)
final themeNotifierProviderProvider =
    AsyncNotifierProvider<ThemeNotifierProvider, bool>.internal(
  ThemeNotifierProvider.new,
  name: r'themeNotifierProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifierProvider = AsyncNotifier<bool>;
String _$themeListenerHash() => r'c37573aee493aadc0dda40efee9c40a6d3a9f7f9';

/// See also [ThemeListener].
@ProviderFor(ThemeListener)
final themeListenerProvider = NotifierProvider<ThemeListener, bool>.internal(
  ThemeListener.new,
  name: r'themeListenerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeListenerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeListener = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
