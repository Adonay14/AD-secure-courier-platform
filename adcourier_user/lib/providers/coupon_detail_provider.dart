import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_web/model/coupon_detail_model.dart';
part 'coupon_detail_provider.g.dart';
  var logger = Logger();
@riverpod
class CouponNotifier extends _$CouponNotifier {

  @override
  Future<CouponDetails?> build(String couponCode) async {
    return getCoupon(couponCode);
  }

  Future<CouponDetails?> getCoupon(String couponCode) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Coupons')
          .where('coupon', isEqualTo: couponCode)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final couponData = snapshot.docs.first.data();
        final couponDetails = CouponDetails(
          title: couponData['title'],
          percentage: couponData['percentage'],
        );

        // Show success toast
        await Fluttertoast.showToast(
          msg: "Coupon reward added to your cart.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 14.0,
        );

        return couponDetails;
      } else {
        // Show failure toast
        await Fluttertoast.showToast(
          msg: "Wrong coupon number.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          fontSize: 14.0,
        );
        return null;
      }
    } catch (e) {
      logger.d('Error fetching coupon: $e');
      return null;
    }
  }

  Stream<dynamic> getCouponStatus() {
    return FirebaseFirestore.instance
        .collection('Coupons')
        .snapshots()
        .map((event) {
      if (event.docs.isEmpty) {
        return false;
      } else {
        return true;
      }
    });
  }
}
