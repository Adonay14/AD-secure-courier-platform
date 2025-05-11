import 'package:admin/widget/rider_charge.dart';
import 'package:flutter/material.dart';

class DeliverySettings extends StatefulWidget {
  const DeliverySettings({super.key});

  @override
  State<DeliverySettings> createState() => _DeliverySettingsState();
}

class _DeliverySettingsState extends State<DeliverySettings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
            
              RiderCharge()
            ],
          ),
        ),
      ),
    );
  }
}
