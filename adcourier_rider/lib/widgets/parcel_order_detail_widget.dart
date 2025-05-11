import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rider_app/model/formatter.dart';
import 'package:rider_app/model/history.dart';
import 'package:rider_app/model/order_model.dart';
import 'package:rider_app/pages/chat_page.dart';
import 'package:rider_app/constant.dart';

import 'map_with_polylines.dart';

class ParcelOrderDetailWidget extends StatefulWidget {
  final String uid;
  const ParcelOrderDetailWidget({super.key, required this.uid});

  @override
  State<ParcelOrderDetailWidget> createState() =>
      _ParcelOrderDetailWidgetState();
}

class _ParcelOrderDetailWidgetState extends State<ParcelOrderDetailWidget> {
  OrderModel2? orderDetail;
  num quantity = 0;
  num selectedPrice = 0;

  String currency = '';
  bool isLoading = true;
  Future<void> fetchOrderDetail() async {
    setState(() {
      isLoading = true;
    });
    context.loaderOverlay.show();

    FirebaseFirestore.instance
        .collection('Orders')
        .doc(widget.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((doc) {
      if (mounted) {
        context.loaderOverlay.hide();
      }
      setState(() {
        isLoading = false;
        orderDetail = OrderModel2(
          scheduleDate: doc.data()!['scheduleDate'],
          scheduleTime: doc.data()!['scheduleTime'],
          vendorId: doc.data()!['vendorId'],
          senderLat: doc.data()!['senderLat'],
          senderLong: doc.data()!['senderLong'],
          receiverLat: doc.data()!['receiverLat'],
          receiverLong: doc.data()!['receiverLong'],
          senderName: doc.data()!['senderName'],
          receiverName: doc.data()!['receiverName'],
          parcelCategory: doc.data()!['parcelCategory'],
          senderEmail: doc.data()!['senderEmail'],
          senderPhone: doc.data()!['senderPhone'],
          senderAddress: doc.data()!['senderAddress'],
          senderHouseNumber: doc.data()!['senderHouseNumber'],
          senderStreetNumber: doc.data()!['senderStreetNumber'],
          senderFloorNumber: doc.data()!['senderFloorNumber'],
          receiverPhone: doc.data()!['receiverPhone'],
          receiverEmail: doc.data()!['receiverEmail'],
          receiverAddress: doc.data()!['receiverAddress'],
          receiverHouseNumber: doc.data()!['receiverHouseNumber'],
          receiverStreetNumber: doc.data()!['receiverStreetNumber'],
          receiverFloorNumber: doc.data()!['receiverFloorNumber'],
          parcelAdminCommission: doc.data()!['parcelAdminCommission'],
          parcelPayer: doc.data()!['parcelPayer'],
          prescription: doc.data()!['prescription'],
          prescriptionPic: doc.data()!['prescriptionPic'],
          module: doc.data()!['module'],
          orders: [
            ...(doc.data()!['orders']).map((items) {
              return OrdersList.fromMap(items);
            })
          ],
          pickupStorename: doc.data()!['pickupStorename'],
          pickupPhone: doc.data()!['pickupPhone'],
          pickupAddress: doc.data()!['pickupAddress'],
          instruction: doc.data()!['instruction'],
          couponPercentage: doc.data()!['couponPercentage'],
          couponTitle: doc.data()!['couponTitle'],
          useCoupon: doc.data()!['useCoupon'],
          confirmationStatus: doc.data()!['confirmationStatus'],
          uid: doc.data()!['uid'],
          // marketID: doc.data()!['marketID'],
          vendorIDs: [
            ...(doc.data()!['vendorIDs']).map((items) {
              return items;
            })
          ],
          userID: doc.data()!['userID'],
          deliveryAddress: doc.data()!['deliveryAddress'],
          houseNumber: doc.data()!['houseNumber'],
          closesBusStop: doc.data()!['closesBusStop'],
          deliveryBoyID: doc.data()!['deliveryBoyID'],
          status: doc.data()!['status'],
          accept: doc.data()!['accept'],
          orderID: doc.data()!['orderID'],
          timeCreated: doc.data()!['timeCreated'].toDate(),
          total: doc.data()!['total'],
          deliveryFee: doc.data()!['deliveryFee'],
          acceptDelivery: doc.data()!['acceptDelivery'],
          paymentType: doc.data()!['paymentType'],
        );
      });
      setState(() {
        // carts.remove(id);
        quantity =
            orderDetail!.orders!.fold(0, (m, product) => m + product.quantity);
        selectedPrice = orderDetail!.orders!.fold(
            0, (s, product) => s + product.selectedPrice * product.quantity);
      });
    });
    //  for (var element in orderDetail!.orders) {

    //  }
  }

  @override
  initState() {
    super.initState();

    getCurrency();
    fetchOrderDetail();
  }

  getCurrency() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        currency = value['Currency symbol'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width >= 1100) const Gap(10),
          //  if (MediaQuery.of(context).size.width >= 1100)
          if (MediaQuery.of(context).size.width >= 1100)
            Align(
              alignment: MediaQuery.of(context).size.width >= 1100
                  ? Alignment.bottomLeft
                  : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width >= 1100 ? 20 : 0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.push('/orders');
                        },
                        child: const Icon(Icons.arrow_back)),
                    const Gap(20),
                    Text(
                      'Order Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width >= 1100
                              ? 15
                              : 15),
                    ).tr(),
                  ],
                ),
              ),
            ),
          if (MediaQuery.of(context).size.width >= 1100)
            const Divider(
              color: Color.fromARGB(255, 237, 235, 235),
              thickness: 1,
            ),
          if (MediaQuery.of(context).size.width >= 1100) const Gap(20),
          if (isLoading == true)
            MediaQuery.of(context).size.width >= 1100
                ? Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 200, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 300, // Set the width as needed
                                        height: 14, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 400, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 250, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 290, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              flex: 6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 400, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 600, // Set the width as needed
                                        height: 14, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 700, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 500, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 290, // Set the width as needed
                                        height: 15, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 400, // Set the width as needed
                              height: 15, // Set the height as needed
                              color: Colors.grey, // Set the color as needed
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 600, // Set the width as needed
                              height: 14, // Set the height as needed
                              color: Colors.grey, // Set the color as needed
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 700, // Set the width as needed
                              height: 15, // Set the height as needed
                              color: Colors.grey, // Set the color as needed
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 500, // Set the width as needed
                              height: 15, // Set the height as needed
                              color: Colors.grey, // Set the color as needed
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 290, // Set the width as needed
                              height: 15, // Set the height as needed
                              color: Colors.grey, // Set the color as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          if (isLoading == false)
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 25, right: 25)
                  : const EdgeInsets.all(8.0),
              child: Result(
                selectedPrice: selectedPrice,
                orderModel2: orderDetail!,
                quantity: quantity,
                currency: currency,
              ),
            )
        ],
      ),
    );
  }
}

class Result extends StatefulWidget {
  final OrderModel2 orderModel2;
  final num quantity;
  final num selectedPrice;
  final String currency;
  const Result(
      {super.key,
      required this.orderModel2,
      required this.quantity,
      required this.currency,
      required this.selectedPrice});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool isLoading = false;
  num wallet = 0;
  DateTime? completedTimeCreated;
  String userID = '';
  String reviewProduct = '';
  num ratingValProduct = 0;
  String name = '';
  getCompletedTimeCreated() {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(widget.orderModel2.uid)
        .snapshots()
        .listen((event) {
      if (event['completedTimeCreated'] != null) {
        setState(() {
          completedTimeCreated = event['completedTimeCreated'].toDate();
        });
        // ignore: avoid_print
        print(completedTimeCreated);
        // getExpiryForReturnPolicy(50);
      }
    });
  }

  getWallet() {
    setState(() {
      isLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        userID = user.uid;
        //  userID = user.uid;

        isLoading = false;
        wallet = event['wallet'];
        name = event['fullname'];
      });
      //  print('Fullname is $fullName');
    });
  }

  getExpiryForReturnPolicy(int returnPolicy) {
    if (completedTimeCreated != null) {}
    DateTime fixedDate = DateTime(completedTimeCreated!.year,
        completedTimeCreated!.month, completedTimeCreated!.day);
    var result = fixedDate.add(Duration(days: returnPolicy));
    // ignore: avoid_print
    print('Result is $result');
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the current date is greater than the new date
    bool dateExceeded = currentDate.isAfter(result);
    if (dateExceeded) {
      // ignore: avoid_print
      print('Date has been exceeded');
      // ignore: avoid_print
      print('Date bool is $dateExceeded');
    } else {
      // ignore: avoid_print
      print('Date has not been exceeded');
      // ignore: avoid_print
      print('Date bool is $dateExceeded');
    }
    return result;
  }

  getExpiry(int returnPolicy) {
    if (completedTimeCreated != null) {
      DateTime fixedDate = DateTime(completedTimeCreated!.year,
          completedTimeCreated!.month, completedTimeCreated!.day);
      var result = fixedDate.add(Duration(days: returnPolicy));
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(result.toString());

      // Format the DateTime object to the desired format
      String formattedDate = DateFormat('MMMM d, y').format(dateTime);

      return formattedDate;
    } else {
      return '';
    }
  }

  getExpiryBool(int returnPolicy) {
    if (completedTimeCreated != null) {}
    DateTime fixedDate = DateTime(completedTimeCreated!.year,
        completedTimeCreated!.month, completedTimeCreated!.day);
    var result = fixedDate.add(Duration(days: returnPolicy));
    // ignore: avoid_print
    print('Result is $result');
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the current date is greater than the new date
    bool dateExceeded = currentDate.isAfter(result);
    if (dateExceeded) {
      // ignore: avoid_print
      print('Date has been exceeded');
      // ignore: avoid_print
      print('Date bool is $dateExceeded');
      return true;
    } else {
      // ignore: avoid_print
      print('Date has not been exceeded');
      // ignore: avoid_print
      print('Date bool is $dateExceeded');
      return false;
    }
    //return result;
  }

  @override
  void initState() {
    getCompletedTimeCreated();

    // getWallet();
    getRiderDetail();
    super.initState();
  }

  String riderName = '';
  String riderPhone = '';
  getRiderDetail() {
    if (widget.orderModel2.acceptDelivery == true) {
      FirebaseFirestore.instance
          .collection('riders')
          .doc(widget.orderModel2.deliveryBoyID)
          .get()
          .then((value) {
        setState(() {
          riderName = value['fullname'];
          riderPhone = value['phone'];
        });
      });
    }
  }

  getPercentageOfCoupon() {
    if (widget.orderModel2.couponPercentage != 0) {
      var result =
          (widget.orderModel2.total * widget.orderModel2.couponPercentage!) /
              100;
      return result;
    } else {
      return 0;
    }
  }

  updateWallet() {
    var total = widget.orderModel2.total + getPercentageOfCoupon();
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'wallet': wallet + total}).then((value) {
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

  ratingAndReviewProduct(
    String productID,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Review Product').tr(),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: Column(children: [
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValProduct = rating;
                    });
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,

                    border: InputBorder.none,
                    fillColor: const Color.fromARGB(255, 236, 234, 234),
                    hintText: 'Review Product'.tr(),
                    //border: OutlineInputBorder()
                  ),
                  onChanged: (val) {
                    setState(() {
                      reviewProduct = val;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: appColor),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Products')
                          .doc(productID)
                          .get()
                          .then((v) {
                        if (v.exists) {
                          if (context.mounted) {
                            context.loaderOverlay.show();
                          }
                          FirebaseFirestore.instance
                              .collection('Products')
                              .doc(productID)
                              .get()
                              .then((value) {
                            if (context.mounted) {
                              context.loaderOverlay.hide();
                            }
                            FirebaseFirestore.instance
                                .collection('Products')
                                .doc(productID)
                                .update({
                              'totalRating':
                                  value['totalRating'] + ratingValProduct,
                              'totalNumberOfUserRating':
                                  value['totalNumberOfUserRating'] + 1
                            });
                          });

                          FirebaseFirestore.instance
                              .collection('Products')
                              .doc(productID)
                              .collection('Ratings')
                              .add({
                            'rating': ratingValProduct,
                            'review': reviewProduct,
                            'fullname': name,
                            'profilePicture': '',
                            'timeCreated': DateFormat.yMMMMEEEEd()
                                .format(DateTime.now())
                                .toString()
                          }).then((value) {
                            if (context.mounted) {
                              Navigator.of(context).pop();
                            }
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection('Flash Sales')
                              .doc(productID)
                              .get()
                              .then((v) {
                            if (v.exists) {
                              if (context.mounted) {
                                context.loaderOverlay.show();
                              }
                              FirebaseFirestore.instance
                                  .collection('Flash Sales')
                                  .doc(productID)
                                  .get()
                                  .then((value) {
                                if (context.mounted) {
                                  context.loaderOverlay.hide();
                                }
                                FirebaseFirestore.instance
                                    .collection('Flash Sales')
                                    .doc(productID)
                                    .update({
                                  'totalRating':
                                      value['totalRating'] + ratingValProduct,
                                  'totalNumberOfUserRating':
                                      value['totalNumberOfUserRating'] + 1
                                });
                              });

                              FirebaseFirestore.instance
                                  .collection('Flash Sales')
                                  .doc(productID)
                                  .collection('Ratings')
                                  .add({
                                'rating': ratingValProduct,
                                'review': reviewProduct,
                                'fullname': name,
                                'profilePicture': '',
                                'timeCreated': DateFormat.yMMMMEEEEd()
                                    .format(DateTime.now())
                                    .toString()
                              }).then((value) {
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection('Hot Deals')
                                  .doc(productID)
                                  .get()
                                  .then((v) {
                                if (context.mounted) {
                                  context.loaderOverlay.show();
                                }
                                FirebaseFirestore.instance
                                    .collection('Hot Deals')
                                    .doc(productID)
                                    .get()
                                    .then((value) {
                                  if (context.mounted) {
                                    context.loaderOverlay.hide();
                                  }
                                  FirebaseFirestore.instance
                                      .collection('Hot Deals')
                                      .doc(productID)
                                      .update({
                                    'totalRating':
                                        value['totalRating'] + ratingValProduct,
                                    'totalNumberOfUserRating':
                                        value['totalNumberOfUserRating'] + 1
                                  });
                                });

                                FirebaseFirestore.instance
                                    .collection('Hot Deals')
                                    .doc(productID)
                                    .collection('Ratings')
                                    .add({
                                  'rating': ratingValProduct,
                                  'review': reviewProduct,
                                  'fullname': name,
                                  'profilePicture': '',
                                  'timeCreated': DateFormat.yMMMMEEEEd()
                                      .format(DateTime.now())
                                      .toString()
                                }).then((value) {
                                  if (context.mounted) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              });
                            }
                          });
                        }
                      });
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ).tr())
              ]),
            ),
          );
        });
  }

  ratingAndReviewVendor(
    String productID,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Rate Vendor').tr(),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: double.infinity,
              child: Column(children: [
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValProduct = rating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: appColor),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Products')
                          .doc(productID)
                          .update({
                        'totalRating': FieldValue.increment(ratingValProduct),
                        'totalNumberOfUserRating': FieldValue.increment(1)
                      }).then((v) {
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      });
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ).tr())
              ]),
            ),
          );
        });
  }

  String fullName = '';
  String userEmail = '';
  String userphone = '';
  getUserDetails() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.orderModel2.userID)
        .snapshots()
        .listen((value) {
      setState(() {
        fullName = value['fullname'];
        userEmail = value['email'];
        userphone = value['phone'];
        // userToken = value['tokenID'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Parse the string into a DateTime object
    DateTime dateTime =
        DateTime.parse(widget.orderModel2.timeCreated.toString());

    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        SizedBox(
          width: double.infinity,
          height: 400,
          child: MapWithPolylines(
              originLatitude: widget.orderModel2.senderLat!,
              originLongitude: widget.orderModel2.senderLong!,
              destLatitude: widget.orderModel2.receiverLat!,
              destLongitude: widget.orderModel2.receiverLong!,
              address: widget.orderModel2.senderAddress!),
        ),
        const Gap(20),
        Row(
          children: [
            Text(
              'Order n° ${widget.orderModel2.orderID}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(5),
            IconButton(
                onPressed: () {
                  FlutterClipboard.copy(widget.orderModel2.orderID)
                      // ignore: avoid_print
                      .then((value) => print('copied'));
                  Fluttertoast.showToast(
                      msg: "Order id has been copied".tr(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      fontSize: 14.0);
                },
                icon: const Icon(
                  Icons.copy,
                  size: 14,
                ))
          ],
        ),
        const Gap(5),
        Text('Order Status: ${widget.orderModel2.status}'),
        const Gap(5),
        Text('Parcel type: ${widget.orderModel2.parcelCategory}'),
        const Gap(5),
        Text('Placed on $formattedDate'),
        if (widget.orderModel2.scheduleDate!.isNotEmpty) const Gap(5),
        if (widget.orderModel2.scheduleDate!.isNotEmpty)
          Text('Scheduled Date ${widget.orderModel2.scheduleDate}'),
        if (widget.orderModel2.scheduleDate!.isNotEmpty) const Gap(5),
        if (widget.orderModel2.scheduleDate!.isNotEmpty)
          Text('Scheduled Time ${widget.orderModel2.scheduleTime}'),
        const Gap(5),
        Text(
            'Total ${widget.currency}${Formatter().converter(widget.orderModel2.total.toDouble())}'),
        const Gap(10),
        const Divider(
          color: Color.fromARGB(255, 237, 235, 235),
          thickness: 1,
        ),
        // const Gap(10),
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'SENDERS INFORMATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextButton.icon(
                style: TextButton.styleFrom(
                    iconColor: appColor, textStyle: TextStyle(color: appColor)),
                onPressed: () {
                  MapsLauncher.launchQuery(widget.orderModel2.senderAddress!);
                },
                label: Text(
                  'View in Map',
                  style: TextStyle(color: appColor),
                ),
                icon: const Icon(Icons.map))
          ],
        ),
        const Gap(5),
        const Divider(
          color: Color.fromARGB(255, 237, 235, 235),
          thickness: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderName),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Email: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderEmail),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Phone: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderPhone),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Address: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderAddress),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender House Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderHouseNumber),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Floor Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderFloorNumber),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sender Street Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.senderStreetNumber),
                ],
              ),
            ),
          ],
        ),

        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RECEIVER INFORMATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
            TextButton.icon(
                style: TextButton.styleFrom(
                    iconColor: appColor, textStyle: TextStyle(color: appColor)),
                onPressed: () {
                  MapsLauncher.launchQuery(widget.orderModel2.receiverAddress!);
                },
                label: Text(
                  'View in Map',
                  style: TextStyle(color: appColor),
                ),
                icon: const Icon(Icons.map))
          ],
        ),
        const Gap(5),
        const Divider(
          color: Color.fromARGB(255, 237, 235, 235),
          thickness: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Name: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverName),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Email: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverEmail),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Phone: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverPhone),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Address: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverAddress),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver House Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverHouseNumber),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Floor Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverFloorNumber),
                ],
              ),
            ),
            const Gap(10),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Receiver Street Number: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.orderModel2.receiverStreetNumber),
                ],
              ),
            ),
          ],
        ),

        const Gap(20),
        const Text(
          'PAYMENT INFORMATION',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        const Gap(5),
        const Divider(
          color: Color.fromARGB(255, 237, 235, 235),
          thickness: 1,
        ),
        const Gap(10),
        Text('Payment Method: ${widget.orderModel2.paymentType}'),
        const Gap(10),
        Text('Payer: ${widget.orderModel2.parcelPayer}'),
        const Gap(10),

        Text(
            'Delivery Fee: ${widget.currency}${Formatter().converter(widget.orderModel2.deliveryFee!.toDouble())}'),
        if (widget.orderModel2.useCoupon == true) const Gap(5),
        if (widget.orderModel2.useCoupon == true)
          Text(
              'Discount: ${widget.currency}${Formatter().converter(((widget.selectedPrice + widget.orderModel2.deliveryFee!) * widget.orderModel2.couponPercentage! / 100).toDouble())} at ${widget.orderModel2.couponPercentage}% Discount'),
        const Gap(5),
        Text(
            'Total: ${widget.currency}${Formatter().converter(widget.orderModel2.total.toDouble())}'),
        const Gap(20),
        if (widget.orderModel2.deliveryAddress!.isNotEmpty)
          if (riderName.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RIDER INFORMATION',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ).tr(),
                const Gap(5),
                const Divider(
                  color: Color.fromARGB(255, 237, 235, 235),
                  thickness: 1,
                ),
                const Gap(10),
                if (riderName.isNotEmpty)
                  if (widget.orderModel2.acceptDelivery == true) const Gap(5),
                if (riderName.isNotEmpty)
                  if (widget.orderModel2.acceptDelivery == true)
                    Text('Rider name: $riderName'),
                if (riderName.isNotEmpty)
                  if (widget.orderModel2.acceptDelivery == true) const Gap(5),
                if (riderName.isNotEmpty)
                  if (widget.orderModel2.acceptDelivery == true)
                    Text('Rider name: $riderPhone'),
                if (riderName.isNotEmpty) const Gap(20),
                if (widget.orderModel2.acceptDelivery == true &&
                    widget.orderModel2.status == 'On the way')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        style: TextButton.styleFrom(backgroundColor: appColor),
                        onPressed: () {
                          if (MediaQuery.of(context).size.width >= 1100) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: ChatPage(
                                            orderModel2: widget.orderModel2)),
                                  );
                                });
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatPage(orderModel2: widget.orderModel2);
                            }));
                          }
                        },
                        label: const Text(
                          "Chat Sender",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
                      TextButton.icon(
                        style: TextButton.styleFrom(backgroundColor: appColor),
                        onPressed: () {
                          makePhoneCall(widget.orderModel2.senderPhone!);
                        },
                        label: const Text(
                          "Call Sender",
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                if (widget.orderModel2.acceptDelivery == true &&
                    widget.orderModel2.status == 'On the way')
                  const Gap(20),
                if (widget.orderModel2.acceptDelivery == true &&
                    widget.orderModel2.status == 'On the way')
                  Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(backgroundColor: appColor),
                      onPressed: () {
                        makePhoneCall(widget.orderModel2.receiverPhone!);
                      },
                      label: const Text(
                        "Call Receiver",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
        const Gap(20),
        const Text(
          'INSTRUCTION INFORMATION',
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
        const Gap(5),
        const Divider(
          color: Color.fromARGB(255, 237, 235, 235),
          thickness: 1,
        ),
        Text(widget.orderModel2.instruction!),
        const Gap(20),
        if (widget.orderModel2.acceptDelivery == false) const Gap(20),
        if (widget.orderModel2.acceptDelivery == false)
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  User? user = auth.currentUser;
                  FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(widget.orderModel2.uid)
                      .update({'acceptDelivery': true});
                  FirebaseFirestore.instance
                      .collection('riders')
                      .doc(user!.uid)
                      .update({'isActive': true});
                  Navigator.pop(context);
                },
                child: const Text(
                  'Accept Delivery',
                  style: TextStyle(color: Colors.white),
                ).tr()),
          ),
        if (widget.orderModel2.acceptDelivery == false) const Gap(20),
        if (widget.orderModel2.acceptDelivery == false)
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Orders')
                      .doc(widget.orderModel2.uid)
                      .update({'deliveryBoyID': ''});
                },
                child: const Text(
                  'Reject Delivery',
                  style: TextStyle(color: Colors.white),
                ).tr()),
          ),
        const Gap(20)
      ],
    );
  }
}
