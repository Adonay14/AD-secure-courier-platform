import 'package:admin/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CouponSystem extends StatefulWidget {
  const CouponSystem({super.key});

  @override
  State<CouponSystem> createState() => _CouponSystemState();
}

class _CouponSystemState extends State<CouponSystem> {
  final _formKey = GlobalKey<FormState>();

  bool enablCoupon = false;
  bool status = false;

  getReferralDetails() {
    FirebaseFirestore.instance
        .collection('Coupon System')
        .doc('Coupon System')
        .snapshots()
        .listen((value) {
      setState(() {
        if (mounted) {
          enablCoupon = value['Status'];
        }
      });
    });
  }

  updateReferralStatus(bool status) {
    FirebaseFirestore.instance
        .collection('Coupon System')
        .doc('Coupon System')
        .set({
      'Status': status,
    });
  }

  @override
  void initState() {
    getReferralDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Coupon System',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Enable Coupon System'),
          value: enablCoupon,
          onChanged: demo == true
              ? (v) {
                  Fluttertoast.showToast(
                      msg: "Sorry this is in demo mode",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                }
              : (bool? value) {
                  setState(() {
                    enablCoupon = !enablCoupon;
                    updateReferralStatus(enablCoupon);
                  });
                },
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        flex: 1,
                        child: Text('Referral reward amount:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(10),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      buttonColor,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.reset();
                      updateReferralStatus(
                        enablCoupon,
                      );
                      Fluttertoast.showToast(
                          msg: "Update completed",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  },
                  child: const Text('Update',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ],
    );
  }
}
