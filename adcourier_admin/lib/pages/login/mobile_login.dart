// import 'dart:io';

import 'package:admin/constance.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';

class MobileLogin extends ConsumerStatefulWidget {
  const MobileLogin({super.key});

  @override
  ConsumerState<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends ConsumerState<MobileLogin>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProviderProvider);
    final authNotifier = ref.read(authProviderProvider.notifier);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title:
      // ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // if(platform == 'android')
             const SizedBox(height: 50,),
            Image.asset(
              logo,
              scale: 5,
            ),
            const SizedBox(height: 10,),
            Text(
              'Welcome To $appName',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(height: 20),
            const Text(
              'Login To Admin',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ).tr(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Divider(
                color: Color.fromARGB(255, 237, 234, 234),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: const Text(
                            ' Email Address',
                            style:
                                TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                        const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern.toString());
                            if (!regex.hasMatch(value!)) {
                              return 'Enter a valid Email';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.grey,
                            hintText: "Email".tr(),
                            hintStyle: const TextStyle(),
                            prefixIcon: const Icon(
                              Icons.alternate_email,
                              size: 30,
                              // color: buttonColor,
                            ),
                            filled: true,
                            fillColor: Colors.white10,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                          onChanged: authNotifier.setEmail,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: const Text(
                            ' Password',
                            style:
                                TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                       const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                            validator: (arg) {
                              if (arg!.length <= 5) {
                                return 'Pasword must be up to 6 digits';
                              } else {
                                return null;
                              }
                            },
                            obscureText: authState.showPassword!,
                            onChanged: authNotifier.setPassword,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusColor: Colors.grey,
                              hintText: "password".tr(),
                              hintStyle: const TextStyle(
                                  // color: buttonColor
                                  ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 30,
                                // color: buttonColor,
                              ),
                              suffixIcon: authState.showPassword!
                                  ? InkWell(
                                      onTap: authNotifier
                                          .togglePasswordVisibilityFalse,
                                      child: const Icon(
                                        Icons.visibility,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: authNotifier
                                          .togglePasswordVisibility,
                                      child: const Icon(
                                          Icons.visibility_off,
                                          color: Colors.grey,
                                          size: 30),
                                    ),
                              filled: true,
                              fillColor: Colors.white10,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: authState.loading!
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  12))),
                                  onPressed: null,
                                  child: const Text(
                                    "Logging in...",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  12))),
                                  onPressed: () async {
                                    if (_formKey.currentState!
                                        .validate()) {
                                            final result =
                                          await authNotifier.loginDetails(
                                        authState.email,
                                        authState.password,
                                      );
                                      if (result == AuthResult.success) {
                                        if (context.mounted) {
                                          if (context.mounted) {
                                            Flushbar(
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              title: "Notification",
                                              message: "Login successful",
                                              duration:
                                                  const Duration(seconds: 1),
                                            ).show(context).then((v) {
                                              authNotifier.updateLoading(false);
                                              context.go('/');
                                            });
                                          }
                                        }
                                      } else {
                                        Flushbar(
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                          title: "Notification",
                                          message: "Incorrect login details",
                                          duration: const Duration(seconds: 1),
                                        ).show(context);
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
                                ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
