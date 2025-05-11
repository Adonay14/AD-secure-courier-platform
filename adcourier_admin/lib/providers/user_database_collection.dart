import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

class Database with ChangeNotifier {
  final String uid;
  String collection;
  Database({
    required this.uid,
    required this.collection,
  });

  // collection reference
  // final CollectionReference  FirebaseFirestore.instance.collection(collection) =
  //     FirebaseFirestore.instance.collection(collection);

//update C\:\\Usersdel signup page
  Future<void> updateUserData(
    String email,
    String fullname,
    String phone,
    String tokenID,
    String referralCode,
  ) async {
    notifyListeners();
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(uid)
        .set({
      'email': email,
      'fullname': fullname,
      'created': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      'id': uid,
      'phone': phone,
      'photoUrl': '',
      'address': '',
      'DeliveryAddress': '',
      'HouseNumber': '',
      'ClosestBustStop': '',
      'DeliveryAddressID': '',
      'CurrentMarketID': '',
      'deliveryFee': 0,
      'wallet': 0,
      'tokenID': tokenID,
      'referralCode': referralCode,
      'awardReferral': false,
      'personalReferralCode': '',
      'Coupon Reward': 0,
      'timeCreated':DateTime.now()
    });
  }

  //update C\:\\Usersdel signup page
  Future<void> updateVendorData(
    String email,
    String fullname,
    String phone,
    String tokenID,
    String referralCode,
    String module,
  ) async {
    notifyListeners();
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(uid)
        .set({
      'email': email,
      'fullname': fullname,
      'created': DateFormat.yMMMMEEEEd().format(DateTime.now()).toString(),
      'id': uid,
      'phone': phone,
      'photoUrl': '',
      'address': '',
      'DeliveryAddress': '',
      'HouseNumber': '',
      'ClosestBustStop': '',
      'DeliveryAddressID': '',
      'CurrentMarketID': '',
      'deliveryFee': 0,
      'wallet': 0,
      'tokenID': tokenID,
      'referralCode': referralCode,
      'awardReferral': false,
      'personalReferralCode': '',
      'Coupon Reward': 0,
      'approval': false,
      'module': module,
      'opening Time': '',
      'closing Time': '',
      'timeCreated':DateTime.now(),
      'isOpened':false,
      'city':'',
      'lat':0,
      'long':0
    });
  }
}
