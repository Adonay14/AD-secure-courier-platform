import 'dart:async';

import 'package:admin/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AssignCountdown extends ConsumerStatefulWidget {
  final bool acceptDelivery;
  final OrderModel2 orderModel2;

  const AssignCountdown(
      {super.key, required this.acceptDelivery, required this.orderModel2});

  @override
  ConsumerState<AssignCountdown> createState() => _AssignCountdownState();
}

class _AssignCountdownState extends ConsumerState<AssignCountdown> {
  Timer? _timer;
  int _remainingSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
          _onCountdownComplete(); // Trigger function after 1 minute
        }
      });
    });
  }

  void _onCountdownComplete() {
    if (widget.acceptDelivery == false) {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(widget.orderModel2.uid)
          .update({'deliveryBoyID': ''}).then((v) {
        if (mounted) {
          Fluttertoast.showToast(
              msg: "Delivery has been cancelled".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_remainingSeconds seconds',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
