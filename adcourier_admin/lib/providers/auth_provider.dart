import 'package:admin/models/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_provider.g.dart';

var logger = Logger();

enum AuthResult { success, failure }

@riverpod
class AuthProvider extends _$AuthProvider {
  @override
  AuthModel build() {
    // loginDetails();
    // Initialize with default values
    return AuthModel(email: '', password: '');
  }

  updateLoading(bool v) {
    state = state.copyWith(loading: v);
  }

  Future<AuthResult> loginDetails(String email, String password) async {
    state = state.copyWith(loading: true);
    final doc =
        await FirebaseFirestore.instance.collection('Admin').doc('Admin').get();

    if (email == doc['username'] && password == doc['password']) {
      final box = GetStorage();
      await box.write('user', {
        'email': state.email,
        'password': state.password,
      });
      // state = state.copyWith(loading: false);
      return AuthResult.success;
    } else {
      state = state.copyWith(loading: false);
      return AuthResult.failure;
      // if (context.mounted) {
      //   state = state.copyWith(loading: false);
      //   Flushbar(
      //     flushbarPosition: FlushbarPosition.TOP,
      //     title: "Notification",
      //     message: "Wrong credentials",
      //     duration: const Duration(seconds: 1),
      //   ).show(context);
      // }
    }
  }

  // Future<void> auth(BuildContext context) async {
  //   final box = GetStorage();
  //   await box.write('user', {
  //     'email': state.email,
  //     'password': state.password,
  //   });

  //   if (context.mounted) {
  //     context.go('/');
  //     Flushbar(
  //       flushbarPosition: FlushbarPosition.TOP,
  //       title: "Notification",
  //       message: "Login successful",
  //       duration: const Duration(seconds: 1),
  //     ).show(context);
  //   }
  // }

  void toggleLoading() {
    state = state.copyWith(loading: state.loading);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(showPassword: true);
  }

  void togglePasswordVisibilityFalse() {
    state = state.copyWith(showPassword: false);
  }

  Future<void> logout() async {
    final box = GetStorage();
    await box.remove('user'); // Clear user data from local storage
    state = AuthModel(email: '', password: ''); // Reset the state
  }
}
