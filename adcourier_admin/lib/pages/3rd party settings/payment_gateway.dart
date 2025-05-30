import 'package:admin/widget/payment_settings.dart';
import 'package:flutter/material.dart';

class PaymentGateway extends StatefulWidget {
  const PaymentGateway({super.key});

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(12.0),
        child: PaymentSettings(),
      )),
    );
  }
}
