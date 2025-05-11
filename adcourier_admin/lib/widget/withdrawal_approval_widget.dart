
import 'package:admin/models/bank_model.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:admin/utils/push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WithdrawalApprovalWidget extends StatefulWidget {
  final BankModel bankModel;
  final String currency;
  const WithdrawalApprovalWidget(
      {super.key, required this.bankModel, required this.currency});

  @override
  State<WithdrawalApprovalWidget> createState() =>
      _WithdrawalApprovalWidgetState();
}

class _WithdrawalApprovalWidgetState extends State<WithdrawalApprovalWidget> {
  bool approval = false;
  getApprovalStatus() {
    FirebaseFirestore.instance
        .collection('Withdrawal Request')
        .doc(widget.bankModel.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        approval = event['paymentStatus'];
      });
    });
  }

  @override
  void initState() {
    getApprovalStatus();
    getUserDetails();
    super.initState();
  }

  String name = '';
  String token = '';

  getUserDetails() {
    if (widget.bankModel.account == 'vendor') {
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(widget.bankModel.vendorID)
          .get()
          .then((value) {
        setState(() {
          name = value['fullname'];
          token = value['tokenID'];
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection('riders')
          .doc(widget.bankModel.vendorID)
          .get()
          .then((value) {
        setState(() {
          name = value['fullname'];
          token = value['tokenID'];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          const Gap(10),
          Text('Baank Name: ${widget.bankModel.bankName}'),
          const Gap(10),
          Text('Account Number: ${widget.bankModel.accountNumber}'),
          const Gap(10),
          Text(
              'Amount: ${widget.currency}${CurrencyFormatter().converter(widget.bankModel.amount!.toDouble())}'),
          const Gap(10),
          if (widget.bankModel.account == 'vendor') Text('Vendor name: $name'),
          if (widget.bankModel.account == 'rider') Text('Rider name: $name'),
          const Gap(10),
          CheckboxListTile(
              title: const Text(
                'Payment Sent?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              value: approval,
              onChanged: (v) {
                setState(() {
                  approval = !approval;
                  FirebaseFirestore.instance
                      .collection('Withdrawal Request')
                      .doc(widget.bankModel.uid)
                      .update({'paymentStatus': approval});
                  PushNotificationFunction.sendPushNotification(
                      'Account Funded',
                      'Your account has been funded with ${widget.currency}${CurrencyFormatter().converter(widget.bankModel.amount!.toDouble())} ',
                      token);
                      Navigator.pop(context);
                });
              }),
        ],
      ),
    );
  }
}
