import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'profile_provider.dart';
part 'carts_state_provider.g.dart';

@riverpod
Future<bool> getCouponStatus(Ref ref) async {
  var event = await FirebaseFirestore.instance.collection('Coupons').get();
  var logger = Logger();
  logger.d('Coupons are $event');
  if (event.docs.isEmpty) {
    return false;
  } else {
    return true;
  }
}

