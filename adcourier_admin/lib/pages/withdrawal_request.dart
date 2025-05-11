import 'package:flutter/material.dart';
import '../Widget/withdrawal_request_datatable.dart';

class WithdrawalRequestPage extends StatefulWidget {
  const WithdrawalRequestPage({super.key});

  @override
  State<WithdrawalRequestPage> createState() => _WithdrawalRequestPageState();
}

class _WithdrawalRequestPageState extends State<WithdrawalRequestPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: WithdrawalRequestDatatable(),
      ),
    );
  }
}
