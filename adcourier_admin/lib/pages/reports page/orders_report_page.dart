import 'package:flutter/material.dart';

import '../../widget/reports widget/orders_report_widget.dart';


//import '../Widgets/verification_page.dart';

class OrdersReportPage extends StatefulWidget {
  const OrdersReportPage({super.key});

  @override
  State<OrdersReportPage> createState() => _OrdersReportPageState();
}

class _OrdersReportPageState extends State<OrdersReportPage> {

  @override
  Widget build(BuildContext context) {
    // verificationStatus();
    return const Scaffold(
      body: SafeArea(
        child: Center(child: OrdersReportWidget()),
      ),
    );
  }
}
