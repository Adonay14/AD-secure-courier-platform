import 'package:admin/pages/login/mobile_login.dart';
import 'package:flutter/material.dart';
import 'desktop_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return const DesktopLogin();
      } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1200) {
        return const MobileLogin();
      } else {
        return const MobileLogin();
      }
    });
  }
}
