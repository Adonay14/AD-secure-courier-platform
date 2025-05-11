import 'package:admin/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin/Widget/currency_settings.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//import 'package:admin/Widget/home_screen_settings.dart';
// import '../../Widget/delivery_fee.dart';
import '../../Widget/payment_settings.dart';
import '../../Widget/referral_system.dart';
import '../../Widget/rider_charge.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  DocumentReference? userRef;

  @override
  void initState() {
    getCashondeliveryStatus();
    super.initState();
  }

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

  bool enableCashondelivery = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              //    HomeScreenSettings(),
              //  Divider(
              //    color: Colors.grey,
              //    thickness: 2,
              //  ),

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
              // const Divider(
              //   color: Colors.grey,
              //   thickness: 2,
              // ),
              // const DeliveryFeeSettings(),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const PaymentSettings(),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const ReferralSystem(),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              const RiderCharge()
            ],
          ),
        ),
      ),
    );
  }
}
