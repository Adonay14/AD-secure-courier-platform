import 'package:admin/models/order_model.dart';
import 'package:admin/models/top_customers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:isoweek/isoweek.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/status_order_count.dart';
part 'dashboard_provider.g.dart';

@riverpod
Future<int> getOrdersByMondayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');
  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Monday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByTuesdayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Tuesday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByWednessdayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Wednessday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByThursdayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Thursday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByFridayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Friday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersBySaturdayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Saturday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersBySundayToday(Ref ref) async {
  Week currentWeek = Week.current();
  //ignore: avoid_print
  print('Current week: ${currentWeek.weekNumber}');

  final d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('weekNumber', isEqualTo: currentWeek.weekNumber)
      .where('day', isEqualTo: "Sunday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByMonday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Monday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByTuesday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Tuesday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByWednessday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Wednessday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByThursday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Thursday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersByFriday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Friday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersBySaturday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Saturday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getOrdersBySunday(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('Orders')
      .where('day', isEqualTo: "Sunday")
      .get();
  return d.docs.length;
}

@riverpod
Future<int> getUsers(Ref ref) async {
  var d = await FirebaseFirestore.instance
      .collection('users')
      // .where('day', isEqualTo: "Sunday")
      .get();
  return d.docs.length;
}

@riverpod
Stream<int> allOrdersFunc(Ref ref) async* {
  // Listen to the Firestore collection snapshots
  final snapshots = FirebaseFirestore.instance.collection('Orders').snapshots();

  // Use async* to yield the length of documents whenever the snapshot changes
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrders(Ref ref) async* {
  // Listen to the Firestore collection snapshots where 'acceptDelivery' is true
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('acceptDelivery', isEqualTo: true)
      .snapshots();

  // Use await for to yield the number of documents in each snapshot
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersPending(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Pending')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersConfirm(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Confirmed')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersProcessing(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Processing')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersOntheway(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'On the way')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersDelivered(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Delivered')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersCancelled(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Cancelled')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

@riverpod
Stream<int> fetchOrdersPickup(Ref ref) async* {
  final snapshots = FirebaseFirestore.instance
      .collection('Orders')
      .where('status', isEqualTo: 'Pickup')
      .snapshots();
  await for (final snapshot in snapshots) {
    yield snapshot.docs.length;
  }
}

List<Color> colorList = [
  // Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.deepOrange,
  Colors.blue.shade100,
  Colors.grey,
  Colors.red
];

@riverpod
Future<int> getNumberofUsers(Ref ref) async {
  var d = await FirebaseFirestore.instance.collection('users').get();
  return d.docs.length;
}

@riverpod
Future<int> getNumberofProducts(Ref ref) async {
  var d = await FirebaseFirestore.instance.collection('Products').get();
  return d.docs.length;
}

@riverpod
Future<int> getNumberofVendors(Ref ref) async {
  var d = await FirebaseFirestore.instance.collection('riders').get();
  return d.docs.length;
}

@riverpod
Stream<num> getTotalSales(Ref ref) async* {
  // Listen to the Firestore collection snapshots
  await for (final snapshot
      in FirebaseFirestore.instance.collection('Orders').snapshots()) {
    // Calculate the total sales
    num totalSales =
        snapshot.docs.fold(0, (tot, doc) => tot + (doc.data()['total'] ?? 0));

    // Yield the total sales to the stream
    yield totalSales;
  }
}

@riverpod
Stream<List<OrderModel2>> ordersDatatable(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return firestore
      .collection('Orders')
      // .where('status', isEqualTo: 'Pending')
      // .orderBy('timeCreated')
      .limit(8)
      .snapshots()
      .asyncMap((snapshot) async {
    final orders = snapshot.docs.map((doc) {
      final data = doc.data();
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
        module: data['module'],
        orders: (data['orders'] as List)
            .map((item) => OrdersList.fromMap(item))
            .toList(),
        pickupStorename: data['pickupStorename'],
        pickupPhone: data['pickupPhone'],
        pickupAddress: data['pickupAddress'],
        instruction: data['instruction'],
        couponPercentage: data['couponPercentage'],
        couponTitle: data['couponTitle'],
        useCoupon: data['useCoupon'],
        confirmationStatus: data['confirmationStatus'],
        uid: data['uid'],
        // marketID: data['marketID'],
        vendorIDs: [
          ...(doc.data()['vendorIDs']).map((items) {
            return items;
          })
        ],
        userID: data['userID'],
        deliveryAddress: data['deliveryAddress'],
        houseNumber: data['houseNumber'],
        closesBusStop: data['closesBusStop'],
        deliveryBoyID: data['deliveryBoyID'],
        status: data['status'],
        accept: data['accept'],
        orderID: data['orderID'],
        timeCreated: (data['timeCreated'] as Timestamp).toDate(),
        total: data['total'],
        deliveryFee: data['deliveryFee'],
        acceptDelivery: data['acceptDelivery'],
        paymentType: data['paymentType'],
      );
    }).toList();
    orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
    return orders;
  });
}



@riverpod
Stream<List<OrdersList>> ordersListFromOrders(
  Ref ref,
) async* {
  final query = FirebaseFirestore.instance.collection('Orders');

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

      // Sort orders by timeCreated descending
      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));

      // Extract orders from each OrderModel2 and combine them into a single list
      final orderLists =
          orders.expand((orderModel) => orderModel.orders!).toList();

      // Create a map to hold the combined quantities for each productID
      final Map<String, OrdersList> combinedOrdersMap = {};

      // Iterate through each order and combine quantities by productID
      for (var order in orderLists) {
        if (combinedOrdersMap.containsKey(order.productID)) {
          // If the productID exists, add the quantity
          combinedOrdersMap[order.productID]!.quantity += order.quantity;
        } else {
          // If the productID does not exist, add the order to the map
          combinedOrdersMap[order.productID] = order;
        }
      }

      // Convert the map values to a list
      final combinedOrdersList = combinedOrdersMap.values.toList();

      // Sort the list by quantity in descending order
      combinedOrdersList.sort((a, b) => b.quantity.compareTo(a.quantity));

      // Limit the list to top 10 by quantity
      final top10Orders = combinedOrdersList.take(10).toList();

      yield top10Orders;
    }
  }
}

@riverpod
Stream<List<UserOrderCount>> userOrdersCount(
  Ref ref,
) async* {
  final ordersQuery = FirebaseFirestore.instance.collection('Orders');

  // Map to store the number of orders per userID
  final Map<String, int> userOrderCountMap = {};

  // Fetch orders from Firestore
  await for (var snapshot
      in ordersQuery.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      // Group orders by userID and count the number of orders for each user
      for (var doc in snapshot.docs) {
        final userID = doc.data()['userID'] as String;
        if (userOrderCountMap.containsKey(userID)) {
          userOrderCountMap[userID] = userOrderCountMap[userID]! + 1;
        } else {
          userOrderCountMap[userID] = 1;
        }
      }

      // List to store user order count information
      final List<UserOrderCount> userOrderCounts = [];

      // Fetch user details from 'users' collection
      for (var entry in userOrderCountMap.entries) {
        final userID = entry.key;
        final orderCount = entry.value;

        // Fetch user details
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .get();
        if (userSnapshot.exists) {
          final userName = userSnapshot.data()?['fullname'] as String;
          userOrderCounts
              .add(UserOrderCount(userName: userName, orderCount: orderCount));
        }
      }

      // Sort the list by order count in descending order
      userOrderCounts.sort((a, b) => b.orderCount.compareTo(a.orderCount));

      yield userOrderCounts;
    }
  }
}

@riverpod
Stream<List<UserOrderCount>> vendorOrdersCount(
  Ref ref,
) async* {
  final ordersQuery = FirebaseFirestore.instance.collection('Orders');

  // Map to store the number of orders per vendorID
  final Map<String, int> vendorOrderCountMap = {};

  // Fetch orders from Firestore
  await for (var snapshot
      in ordersQuery.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      // Group orders by vendorID and count the number of orders for each vendor
      for (var doc in snapshot.docs) {
        final vendorIDs = doc.data()['deliveryBoyID'] as String;

        // for (var vendorID in vendorIDs) {
        if (vendorOrderCountMap.containsKey(vendorIDs)) {
          vendorOrderCountMap[vendorIDs] = vendorOrderCountMap[vendorIDs]! + 1;
        } else {
          vendorOrderCountMap[vendorIDs] = 1;
        }
        // }
      }

      // List to store vendor order count information
      final List<UserOrderCount> vendorOrderCounts = [];

      // Fetch vendor details from 'vendors' collection
      for (var entry in vendorOrderCountMap.entries) {
        final vendorID = entry.key;
        final orderCount = entry.value;

        if (vendorID.isNotEmpty) {
          // Fetch vendor details
          final vendorSnapshot = await FirebaseFirestore.instance
              .collection('riders')
              .doc(vendorID)
              .get();
          if (vendorSnapshot.exists) {
            final vendorName = vendorSnapshot.data()?['fullname'] as String;
            vendorOrderCounts.add(
              UserOrderCount(userName: vendorName, orderCount: orderCount),
            );
          }
        }
      }

      // Sort the list by order count in descending order
      vendorOrderCounts.sort((a, b) => b.orderCount.compareTo(a.orderCount));

      yield vendorOrderCounts;
    }
  }
}

@riverpod
Stream<List<StatusOrderCount>> statusOrdersCount(
  Ref ref,
) async* {
  final ordersQuery = FirebaseFirestore.instance.collection('Orders');

  // Map to store the number of orders per status
  final Map<String, int> statusOrderCountMap = {};

  // Fetch orders from Firestore
  await for (var snapshot
      in ordersQuery.snapshots(includeMetadataChanges: true)) {
    if (snapshot.docs.isEmpty) {
      yield [];
    } else {
      // Group orders by status and count the number of orders for each status
      for (var doc in snapshot.docs) {
        final status = doc.data()['status'] as String;
        if (statusOrderCountMap.containsKey(status)) {
          statusOrderCountMap[status] = statusOrderCountMap[status]! + 1;
        } else {
          statusOrderCountMap[status] = 1;
        }
      }

      // List to store status order count information
      final List<StatusOrderCount> statusOrderCounts = [];

      // Add the status and corresponding order count to the list
      for (var entry in statusOrderCountMap.entries) {
        statusOrderCounts
            .add(StatusOrderCount(status: entry.key, orderCount: entry.value));
      }

      // Sort the list by order count in descending order
      statusOrderCounts.sort((a, b) => b.orderCount.compareTo(a.orderCount));

      yield statusOrderCounts;
    }
  }
}
