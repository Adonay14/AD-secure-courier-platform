import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_web/model/history.dart';
import 'package:user_web/model/pickup_address_model.dart';
import '../model/order_model.dart';
part 'checkout_provider.g.dart';

var logger = Logger();

@riverpod
Stream<num> getWallet(Ref ref) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .snapshots()
      .map((e) => e['wallet']);
}

@riverpod
Stream<bool> getCashOnDelivery( Ref ref) {
  return FirebaseFirestore.instance
      .collection('Payment System')
      .doc('Cash on delivery')
      .snapshots()
      .map((event) {
    return event['Cash on delivery'];
  });
}

@riverpod
updateWallet( Ref ref, num total) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .update({'wallet': FieldValue.increment(-total)}).then((value) {
    // Get the current date and time
    // DateTime now = DateTime.now();

    // // Format the date to '24th January, 2024' format
    // String formattedDate = DateFormat('d MMMM, y').format(now);
    history(HistoryModel(
        message: 'Debit Alert',
        amount: total.toString(),
        paymentSystem: 'Wallet',
        timeCreated: DateTime.now()));
  });
}

history(HistoryModel historyModel) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .collection('Transaction History')
      .add(historyModel.toMap());
}

@riverpod
Future<List<PickupAddressModel>> getPickUpAddress(
   Ref ref,String id) async {
  var e = await FirebaseFirestore.instance.collection('vendors').doc(id).collection('Pickup Address').get();
  return e.docs.map((r) {
    logger.d(r);
    return PickupAddressModel.fromMap(r.data(), r.id);
  }).toList();
}



getPercentageOfCoupon(num couponPercentage, num total) {
  if (couponPercentage != 0) {
    var result = (total * couponPercentage) / 100;
    return result;
  } else {
    return 0;
  }
}

addToOrder(OrderModel orderModel, String uid, BuildContext context) {
  context.loaderOverlay.show();
  FirebaseFirestore.instance
      .collection('Orders')
      .doc(uid)
      .set(orderModel.toMap())
      .then((value) {
    if (context.mounted) {
      context.loaderOverlay.hide();
      Fluttertoast.showToast(
              msg: "Your new order has been placed".tr(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              fontSize: 14.0)
          .then((value) {
        if (context.mounted) {
          context.go('/orders');
        }
      });
    }
  });
}
