import 'package:cloud_firestore/cloud_firestore.dart';

class SocialInfoDatabase {
  final CollectionReference paymentDetail =
      FirebaseFirestore.instance.collection('Social Details');

  Future<void> updateFacebook(String businessName) async {
    await paymentDetail.doc('facebook').set({
      'facebook': businessName,
    });
  }

  Future<void> updateInstagram(String email) async {
    await paymentDetail.doc('instagram').set({
      'instagram': email,
    });
  }

  Future<void> updateTwitter(String phone) async {
    await paymentDetail.doc('twitter').set({
      'twitter': phone,
    });
  }
}
