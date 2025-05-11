import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'parcel_wallet_provider.g.dart';

@riverpod
Stream<num?> getUserParcelWallet(Ref ref) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  if (user == null) {
    // If no user is signed in, return an empty stream.
    return Stream.value(null);
  }

  // Listening to the user's document snapshots.
  return FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .snapshots()
      .map((snapshot) {
    return snapshot.data()?['wallet'];
  });
}

@riverpod
updateParcelWallet(Ref ref, num amount) {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;

  FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .update({'wallet': FieldValue.increment(-amount)});
}
