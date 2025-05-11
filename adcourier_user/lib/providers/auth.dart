import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:random_string/random_string.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../database/database.dart';
import '../model/user.dart';
part 'auth.g.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String token = '';
  // create user obj based on firebase user
  UserModel _userFromFirebase(User? user) {
    return UserModel(
        email: user!.email!,
        displayName: user.displayName!,
        phonenumber: user.phoneNumber!,
        token: '',
        photoUrl: '',
        referralCode: '',
        uid: '');
  }

  // getToken() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();

  //   var playerId = status.subscriptionStatus.userId;

  //   debugPrint(playerId);
  //   User user = FirebaseAuth.instance.currentUser;
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user.uid)
  //       .update({'token': playerId});
  // }

  //auth change user steam
  Stream<UserModel> get user {
    notifyListeners();
    return auth.authStateChanges().map(_userFromFirebase);
  }

  bool? loginStatus;
  //signin with email and password
  Future signIn(String email, String password, context, String token) async {
    notifyListeners();
    // context.loaderOverlay.show();
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      //  context.loaderOverlay.hide();
      if (userCredential.user!.emailVerified) {
        GoRouter.of(context).go('/parcel-delivery');
        loginStatus = true;
        Fluttertoast.showToast(
            msg: "You logged in successfully".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            fontSize: 14.0);
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({'tokenID': token});
      } else {
        loginStatus = true;
        await auth.signOut();
        Fluttertoast.showToast(
            msg: "Please verify your email to continue".tr(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            fontSize: 14.0);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      //  context.loaderOverlay.hide();
      loginStatus = false;
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0);
    }
  }

  bool? signupStatus;
  // register with email and password
  Future signUp(
      String email,
      String password,
      String fullname,
      String phone,
      context,
      String referralCode,
      referralBonus,
      bool referralStatus,
      String token) async {
    notifyListeners();
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      // user!.sendEmailVerification();
      await userCredential.user!.sendEmailVerification();
      await Database(uid: user!.uid)
          .updateUserData(email, fullname, phone, token, referralCode)
          .then((value) {});
      GoRouter.of(context).go('/login');
      auth.signOut();
      signupStatus = true;
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'personalReferralCode': randomAlphaNumeric(8)});
      Fluttertoast.showToast(
          msg:
              "Your account has been created sucessfully Please Verify account to continue"
                  .tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0);
      user.updateDisplayName(user.displayName).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .where('personalReferralCode', isEqualTo: referralCode)
            .get()
            .then((value) {
          if (referralStatus == true) {
            for (var item in value.docs) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(item['id'])
                  .collection('Referral Bonuses')
                  .add({
                'Referral Bonus': referralBonus,
                'Claim Bonus': false,
                'Referred': fullname
              });
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(item['id'])
                  .update({'wallet': item['wallet'] + referralBonus});
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({'awardReferral': true});
            }
          }
        });
      });

      user.reload();
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      signupStatus = false;
      Fluttertoast.showToast(
          msg: e.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          fontSize: 14.0);
    }
  }

  // sign user out
  Future signOut(
    context,
  ) async {
    notifyListeners();
    await auth.signOut();
    Fluttertoast.showToast(
        msg: "You've successfully logged out".tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 14.0);
    GoRouter.of(context).go('/parcel-delivery');
  }

  bool? forgotPasswordStatus;
  Future forgotPassword(context, String email) async {
    notifyListeners();
    await auth.sendPasswordResetEmail(email: email);
    forgotPasswordStatus = true;
    GoRouter.of(context).go('/login');
    Fluttertoast.showToast(
        msg: 'Pease check your email'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  Future updateProfile(String fullname, String phone, context,
      String profilePic, String address) async {
    User? user = auth.currentUser;
    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
      'phone': phone,
      'fullname': fullname,
      'photoUrl': profilePic,
      'address': address
    }).then((value) {
      user.updateDisplayName(fullname);
      Fluttertoast.showToast(
          msg: "Profile has been updated successfully".tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          fontSize: 14.0);
      user.updateDisplayName(user.displayName);
      EasyLoading.dismiss();
      // user.updateEmail(newEmail);
    });
  }
}

@riverpod
Stream<User?> authState( Ref ref) {
  return FirebaseAuth.instance.authStateChanges();
}

@riverpod
bool isLoggedIn(Ref ref) {
  final user = ref.watch(authStateProvider).value;
  return user != null;
}
