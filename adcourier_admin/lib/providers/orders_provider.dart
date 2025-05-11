import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:admin/models/order_model.dart';

part 'orders_provider.g.dart';

@riverpod
Stream<List<OrderModel2>> ordersStream(Ref ref, String status) async* {
  final query = (status == 'All')
      ? FirebaseFirestore.instance.collection('Orders')
      : status == 'Pickup'
          ? FirebaseFirestore.instance
              .collection('Orders')
              .where('deliveryAddress', isEqualTo: '')
          : status == 'Scheduled'
              ? FirebaseFirestore.instance
                  .collection('Orders')
                  .where('scheduleDate', isNotEqualTo: '')
              : FirebaseFirestore.instance
                  .collection('Orders')
                  .where('status', isEqualTo: status);

  await for (var snapshot in query.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      final orders = snapshot.docs.map((doc) {
        return OrderModel2(
          scheduleDate: doc.data()['scheduleDate'],
          scheduleTime: doc.data()['scheduleTime'],
          vendorId: doc.data()['vendorId'],
          senderName: doc.data()['senderName'],
          receiverName: doc.data()['receiverName'],
          parcelCategory: doc.data()['parcelCategory'],
          senderEmail: doc.data()['senderEmail'],
          senderPhone: doc.data()['senderPhone'],
          senderAddress: doc.data()['senderAddress'],
          senderHouseNumber: doc.data()['senderHouseNumber'],
          senderStreetNumber: doc.data()['senderStreetNumber'],
          senderFloorNumber: doc.data()['senderFloorNumber'],
          senderLat: doc.data()['senderLat'],
          senderLong: doc.data()['senderLong'],
          receiverLat: doc.data()['receiverLat'],
          receiverLong: doc.data()['receiverLong'],
          receiverPhone: doc.data()['receiverPhone'],
          receiverEmail: doc.data()['receiverEmail'],
          receiverAddress: doc.data()['receiverAddress'],
          receiverHouseNumber: doc.data()['receiverHouseNumber'],
          receiverStreetNumber: doc.data()['receiverStreetNumber'],
          receiverFloorNumber: doc.data()['receiverFloorNumber'],
          parcelAdminCommission: doc.data()['parcelAdminCommission'],
          parcelPayer: doc.data()['parcelPayer'],
          prescription: doc.data()['prescription'],
          prescriptionPic: doc.data()['prescriptionPic'],
          module: doc.data()['module'],
          orders: (doc.data()['orders'] as List).map((item) {
            return OrdersList.fromMap(item);
          }).toList(),
          pickupStorename: doc.data()['pickupStorename'],
          pickupPhone: doc.data()['pickupPhone'],
          pickupAddress: doc.data()['pickupAddress'],
          instruction: doc.data()['instruction'],
          couponPercentage: doc.data()['couponPercentage'],
          couponTitle: doc.data()['couponTitle'],
          useCoupon: doc.data()['useCoupon'],
          confirmationStatus: doc.data()['confirmationStatus'],
          uid: doc.data()['uid'],
          // marketID: doc.data()['marketID'],
          vendorIDs: [
            ...(doc.data()['vendorIDs']).map((items) {
              return items;
            })
          ],
          userID: doc.data()['userID'],
          deliveryAddress: doc.data()['deliveryAddress'],
          houseNumber: doc.data()['houseNumber'],
          closesBusStop: doc.data()['closesBusStop'],
          deliveryBoyID: doc.data()['deliveryBoyID'],
          status: doc.data()['status'],
          accept: doc.data()['accept'],
          orderID: doc.data()['orderID'],
          timeCreated: doc.data()['timeCreated'].toDate(),
          total: doc.data()['total'],
          deliveryFee: doc.data()['deliveryFee'],
          acceptDelivery: doc.data()['acceptDelivery'],
          paymentType: doc.data()['paymentType'],
        );
      }).toList();

      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
      yield orders;
    }
  }
}

@riverpod
Stream<List<OrderModel2>> ordersStreamByPos(Ref ref, String status) async* {
  final query = (status == 'All')
      ? FirebaseFirestore.instance
          .collection('Orders')
          .where('isPos', isEqualTo: true)
      : status == 'Pickup'
          ? FirebaseFirestore.instance
              .collection('Orders')
              .where('deliveryAddress', isEqualTo: '')
              .where('isPos', isEqualTo: true)
          : status == 'Scheduled'
              ? FirebaseFirestore.instance
                  .collection('Orders')
                  .where('scheduleDate', isNotEqualTo: '')
                  .where('isPos', isEqualTo: true)
              : FirebaseFirestore.instance
                  .collection('Orders')
                  .where('status', isEqualTo: status)
                  .where('isPos', isEqualTo: true);

  await for (var snapshot in query.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      final orders = snapshot.docs.map((doc) {
        return OrderModel2(
          scheduleDate: doc.data()['scheduleDate'],
          scheduleTime: doc.data()['scheduleTime'],
          vendorId: doc.data()['vendorId'],
          vendorIDs: [
            ...(doc.data()['vendorIDs']).map((items) {
              return items;
            })
          ],
          orders: (doc.data()['orders'] as List).map((item) {
            return OrdersList.fromMap(item);
          }).toList(),
          pickupStorename: doc.data()['pickupStorename'],
          pickupPhone: doc.data()['pickupPhone'],
          pickupAddress: doc.data()['pickupAddress'],
          instruction: doc.data()['instruction'],
          couponPercentage: doc.data()['couponPercentage'],
          couponTitle: doc.data()['couponTitle'],
          useCoupon: doc.data()['useCoupon'],
          confirmationStatus: doc.data()['confirmationStatus'],
          uid: doc.data()['uid'],
          // marketID: doc.data()['marketID'],
          // vendorID: doc.data()['vendorID'],
          userID: doc.data()['userID'],
          deliveryAddress: doc.data()['deliveryAddress'],
          houseNumber: doc.data()['houseNumber'],
          closesBusStop: doc.data()['closesBusStop'],
          deliveryBoyID: doc.data()['deliveryBoyID'],
          status: doc.data()['status'],
          accept: doc.data()['accept'],
          orderID: doc.data()['orderID'],
          timeCreated: doc.data()['timeCreated'].toDate(),
          total: doc.data()['total'],
          deliveryFee: doc.data()['deliveryFee'],
          acceptDelivery: doc.data()['acceptDelivery'],
          paymentType: doc.data()['paymentType'], module: doc.data()['module'],
        );
      }).toList();

      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
      yield orders;
    }
  }
}
