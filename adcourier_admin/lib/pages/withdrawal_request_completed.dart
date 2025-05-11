import 'package:flutter/material.dart';
import '../Widget/withdrawal_request_completed_datatable.dart';

class WithdrawalRequestCompletedPage extends StatefulWidget {
  const WithdrawalRequestCompletedPage({super.key});

  @override
  State<WithdrawalRequestCompletedPage> createState() =>
      _WithdrawalRequestCompletedPageState();
}

class _WithdrawalRequestCompletedPageState
    extends State<WithdrawalRequestCompletedPage> {
 


  @override
  Widget build(BuildContext context) {


    return const Scaffold(
      body: SafeArea(
        child: WithdrawalRequestCompletedDatatable(),
      ),
    );
  }
}
