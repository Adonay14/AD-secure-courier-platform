import 'package:admin/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/theme/theme_data.dart';
part 'home_main_provider.g.dart';

@riverpod
Future<Map<String, String>> firebaseDetails( Ref ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Admin').doc('Admin').get();
  return {
    'ProfilePic': snapshot['ProfilePic'] as String,
    'password': snapshot['password'] as String,
    'username': snapshot['username'] as String,
  };
}

@Riverpod(keepAlive: true)
Future<bool> themeMode( Ref ref) async {
  final box = GetStorage();
  return box.read('lightMode') ?? true;
}

@Riverpod(keepAlive: true)
Future<void> initAuth( Ref ref) async {
  final box = GetStorage();
  await box.write('logged in', true);
}

@Riverpod(keepAlive: true)
class ThemeNotifierProvider extends _$ThemeNotifierProvider {
  @override
  FutureOr<bool> build() async {
    final box = GetStorage();
    return box.read('lightMode') ?? true;
  }

  void toggleTheme(bool isLightTheme, ThemeNotifier themeNotifier) async {
    (isLightTheme == true)
        ? themeNotifier.setTheme(lightTheme)
        : themeNotifier.setTheme(darkTheme);
    final box = GetStorage();
    await box.write('lightMode', isLightTheme);
    state = AsyncValue.data(isLightTheme);
  }
}

// @riverpod
// bool themeListener(ThemeListenerRef ref) {
//   final box = GetStorage();
//   var logger = Logger();
//   // bool lightMode ;
//   bool lightMode = true;
//   // logger.d('selected theme is $userJson');
//   // return userJson;
//   //  final box = GetStorage();
//   final userJson = box.read('lightMode');
//   lightMode = userJson ?? true;
//   box.listenKey('lightMode', (value) {
//     if (value == true) {
//       lightMode = true;
//       logger.d('selected theme is $lightMode');
//     } else {
//       lightMode = false;
//       logger.d('selected theme is $lightMode');
//     }
//   });
//   return lightMode;
// }

// Generate the provider using @riverpod annotation
@Riverpod(keepAlive: true)
class ThemeListener extends _$ThemeListener {
  late final GetStorage _box;
  late final Logger _logger;

  @override
  bool build() {
    _box = GetStorage();
    _logger = Logger();

    // Initialize the state with the saved theme value
    final storedTheme = _box.read('lightMode') ?? true;
    _box.listenKey('lightMode', (value) {
      state = value ?? true;
      _logger.d('Selected theme is $state');
    });

    return storedTheme;
  }
}
