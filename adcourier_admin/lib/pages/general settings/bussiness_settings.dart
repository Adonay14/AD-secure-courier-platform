import 'package:admin/constance.dart';
import 'package:admin/widget/currency_settings.dart';
import 'package:admin/widget/referral_system.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'business_info.dart';

class BussinessSettings extends StatefulWidget {
  const BussinessSettings({super.key});

  @override
  State<BussinessSettings> createState() => _BussinessSettingsState();
}

class _BussinessSettingsState extends State<BussinessSettings> {
  @override
  void initState() {
    getCashondeliveryStatus();
    super.initState();
  }

  bool enableCashondelivery = false;
  getCashondeliveryStatus() {
    FirebaseFirestore.instance
        .collection('Payment System')
        .doc('Cash on delivery')
        .get()
        .then((value) {
      setState(() {
        enableCashondelivery = value['Cash on delivery'];
      });
    });
  }

  Future<void> enableCashondeliveryFunction(bool enableCashondelivery) async {
    await FirebaseFirestore.instance
        .collection('Payment System')
        .doc('Cash on delivery')
        .set({'Cash on delivery': enableCashondelivery});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const BusinessInfo(),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Cash on delivery Payment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text('Enable Cash on delivery payment'),
                value: enableCashondelivery,
                onChanged: demo == true
                    ? (v) {
                        Fluttertoast.showToast(
                            msg: "Sorry this is in demo mode",
                            backgroundColor: buttonColor,
                            textColor: Colors.white);
                      }
                    : (bool? value) {
                        setState(() {
                          enableCashondelivery = !enableCashondelivery;
                          enableCashondeliveryFunction(enableCashondelivery);
                        });

                        // Fluttertoast.showToast(
                        //     msg:
                        //         "This is a test version you can't change the details",
                        //     backgroundColor: buttonColor,
                        //     textColor: Colors.white);
                      },
              ),
              const CurrencySettings(),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            
              const ReferralSystem(),
            ],
          ),
        ),
      ),
    );
  }
}
