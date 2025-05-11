import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfoDatabase {
  final CollectionReference paymentDetail =
      FirebaseFirestore.instance.collection('Business Details');

  Future<void> updateBusinessName(String businessName) async {
    await paymentDetail.doc('business name').set({
      'business name': businessName,
    });
  }

  Future<void> updateEmail(String email) async {
    await paymentDetail.doc('email').set({
      'email': email,
    });
  }

  Future<void> updatePhone(String phone) async {
    await paymentDetail.doc('phone').set({
      'phone': phone,
    });
  }

  Future<void> updateAddress(String address) async {
    await paymentDetail.doc('address').set({
      'address': address,
    });
  }
}
