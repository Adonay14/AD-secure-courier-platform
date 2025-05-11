import 'package:flutter/material.dart';

import '../../widget/reports widget/users_report_widget.dart';
//import '../Widgets/verification_page.dart';

class UsersReportPage extends StatefulWidget {
  const UsersReportPage({super.key});

  @override
  State<UsersReportPage> createState() => _UsersReportPageState();
}

class _UsersReportPageState extends State<UsersReportPage> {


  @override
  Widget build(BuildContext context) {
    // verificationStatus();
    return const Scaffold(
      body: SafeArea(
        child: Center(child: UsersReportWidget()),
      ),
    );
  }
}
