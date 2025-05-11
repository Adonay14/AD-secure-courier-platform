import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:isoweek/isoweek.dart';
import 'package:logger/logger.dart';
import 'package:user_web/constant.dart';
import 'package:user_web/model/order_model.dart';
import 'package:user_web/model/parcel_category.dart';
import 'package:user_web/model/parcel_model.dart';
import 'package:user_web/providers/checkout_provider.dart';
import 'package:user_web/providers/coupon_detail_provider.dart';
import 'package:user_web/providers/currency_provider.dart';
import 'package:user_web/providers/parcel_providers/parcel_distance_calculation_provider.dart';
import 'package:user_web/providers/parcel_providers/parcel_wallet_provider.dart';
import 'package:user_web/widgets/schedule_time_picker.dart';
import 'package:uuid/uuid.dart';

import '../../providers/carts_state_provider.dart';

class ParcelCheckout extends ConsumerStatefulWidget {
  final ParcelModel senderDetails;
  final ParcelCategoriesModel parcelCategoriesModel;
  const ParcelCheckout({
    super.key,
    required this.senderDetails,
    required this.parcelCategoriesModel,
  });

  @override
  ConsumerState<ParcelCheckout> createState() => _ParcelCheckoutState();
}

class _ParcelCheckoutState extends ConsumerState<ParcelCheckout> {
  var logger = Logger();
  int selectedPayer = 1;
  int? selectedPaymentType;
  String scheduleDate = '';
  String scheduleTime = '';
  bool isSchedule = false;
  String uid = '';
  String userID = '';
  num couponPercentage = 0;
  String couponTitle = '';
  String couponCode = '';
  String instruction = '';

  @override
  void initState() {
    var uuid = const Uuid();
    uid = uuid.v1();
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    userID = user!.uid;
    super.initState();
  }

  getPercentageOfCoupon(num couponPercentage, num total) {
    if (couponPercentage != 0) {
      var result = (total * couponPercentage) / 100;
      return result;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallet = ref.watch(getUserParcelWalletProvider).value;
    logger.d('wallet is $wallet');

    final currencySymbol = ref.watch(currencySymbolProvider).value ?? '';
    final distance = ref.watch(calculateDistanceProvider(
        widget.senderDetails.senderLat,
        widget.senderDetails.senderLong,
        widget.senderDetails.receiverLat,
        widget.senderDetails.receiverLong));
    final isCouponActive = ref.watch(getCouponStatusProvider).value;
    return Column(
      children: [
        // Gap(20),
        if (MediaQuery.of(context).size.width >= 1100)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ListTile(
                  title: const Text('Distance'),
                  subtitle: Text('${distance.toStringAsFixed(2)} Km'),
                  leading: Icon(
                    Icons.social_distance,
                    color: appColor,
                  ),
                ),
              ),
              const Gap(20),
              Expanded(
                flex: 3,
                child: ListTile(
                  title: const Text('Distance Fee'),
                  subtitle: Text(
                      '$currencySymbol${((widget.parcelCategoriesModel.chargePerKm * distance) - getPercentageOfCoupon(couponPercentage, widget.parcelCategoriesModel.chargePerKm * distance)).toStringAsFixed(2)}'),
                  leading: Icon(
                    Icons.monetization_on,
                    color: appColor,
                  ),
                ),
              )
            ],
          ),
        if (MediaQuery.of(context).size.width <= 1100)
          Column(
            children: [
              ListTile(
                title: const Text('Distance'),
                subtitle: Text('${distance.toStringAsFixed(2)} Km'),
                leading: Icon(
                  Icons.social_distance,
                  color: appColor,
                ),
              ),
              ListTile(
                title: const Text('Distance Fee'),
                subtitle: Text(
                    '$currencySymbol${((widget.parcelCategoriesModel.chargePerKm * distance) - getPercentageOfCoupon(couponPercentage, widget.parcelCategoriesModel.chargePerKm * distance)).toStringAsFixed(2)}'),
                leading: Icon(
                  Icons.monetization_on,
                  color: appColor,
                ),
              )
            ],
          ),
        const Divider(
          color: Colors.grey,
        ),
        Text(
          'Deliver Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderName!),
        ),
        ListTile(
          leading: Icon(
            Icons.email,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderEmail!),
        ),
        ListTile(
          leading: Icon(
            Icons.phone,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Phone',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderPhone!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderAddress!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender House Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderHouseNumber!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Street Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderStreetNumber!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Sender Floor Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.senderFloorNumber!),
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverName!),
        ),
        ListTile(
          leading: Icon(
            Icons.email,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Email',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverEmail!),
        ),
        ListTile(
          leading: Icon(
            Icons.phone,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Phone',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverPhone!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverAddress!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever House Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverHouseNumber!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Street Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverStreetNumber!),
        ),
        ListTile(
          leading: Icon(
            Icons.location_city,
            color: appColor,
          ),
          subtitle: const Text(
            'Reciever Floor Number',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          title: Text(widget.senderDetails.receiverFloorNumber!),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Text(
          'Charge Paid By',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
        ),
        Container(
          color: selectedPayer == 1 ? Colors.grey : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioListTile(
                secondary: Icon(Icons.person, color: appColor),
                title: const Text('Sender'),
                value: 1,
                groupValue: selectedPayer,
                onChanged: (v) {
                  setState(() {
                    selectedPayer = v!;
                  });
                }),
          ),
        ),
        Container(
          color: selectedPayer == 2 ? Colors.grey : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioListTile(
                secondary: Icon(Icons.person, color: appColor),
                title: const Text('Receiver'),
                value: 2,
                groupValue: selectedPayer,
                onChanged: (v) {
                  setState(() {
                    selectedPayer = v!;
                  });
                }),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
        ),
        Container(
          color: selectedPaymentType == 1 ? Colors.grey : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioListTile(
                secondary: Icon(Icons.handshake, color: appColor),
                title: const Text('Cash On Delivery'),
                value: 1,
                groupValue: selectedPaymentType,
                onChanged: (v) {
                  setState(() {
                    selectedPaymentType = v!;
                  });
                }),
          ),
        ),
        if (selectedPayer == 1)
          Container(
            color: selectedPaymentType == 2 ? Colors.grey : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RadioListTile(
                  secondary: Icon(Icons.wallet, color: appColor),
                  title: const Text('Wallet'),
                  value: 2,
                  groupValue: selectedPaymentType,
                  onChanged: (v) {
                    if ((widget.parcelCategoriesModel.chargePerKm * distance) >
                        wallet!) {
                      Fluttertoast.showToast(
                          msg: "Fund wallet to continue".tr(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          fontSize: 14.0);
                    } else {
                      setState(() {
                        selectedPaymentType = v!;
                      });
                    }
                  }),
            ),
          ),
        const Gap(20),
        if (isCouponActive == true)
          const Text(
            'Add Voucher Code',
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
        if (isCouponActive == true) const Gap(5),
        if (isCouponActive == true)
          const Text(
            'Do you have a voucher? Enter the voucher code below',
            style: TextStyle(),
          ).tr(),
        if (isCouponActive == true)
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  onChanged: (v) {
                    setState(() {
                      couponCode = v;
                    });
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.zero),
                      hintText: 'Add Voucher'.tr()),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    // width: 70,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: const BeveledRectangleBorder()),
                        onPressed: () async {
                          // Trigger the Riverpod provider to fetch the coupon
                          final couponDetails = await ref
                              .read(couponNotifierProvider(couponCode).future);
                          setState(() {
                            couponPercentage = couponDetails!.percentage;
                            couponTitle = couponDetails.title;
                          });
                        },
                        child: const Text(
                          'Apply',
                          style: TextStyle(color: Colors.white),
                        ).tr()),
                  ))
            ],
          ),
        const Gap(20),
        TextField(
          maxLines: 4,
          onChanged: (v) {
            setState(() {
              instruction = v;
            });
          },
          decoration: InputDecoration(
              border: const OutlineInputBorder(borderRadius: BorderRadius.zero),
              labelText: 'Add Instruction (Optional)'.tr()),
        ),
        const Gap(30),
        CheckboxListTile(
          value: isSchedule,
          onChanged: (v) {
            setState(() {
              isSchedule = !isSchedule;
              scheduleTime = '';
              scheduleDate = '';
            });
          },
          title: const Text(
            'Schedule Order',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        if (isSchedule == true)
          ScheduleTimePicker(
            onDateSelected: (DateTime? date) {
              if (date != null) {
                // ignore: avoid_print
                print('Selected date: $date');
                setState(() {
                  scheduleDate = DateFormat('yyyy-MM-dd').format(date);
                });
                // Do something with the date
              }
            },
            onTimeSelected: (TimeOfDay? time) {
              if (time != null) {
                // ignore: avoid_print
                print('Selected time: ${time.format(context)}');
                setState(() {
                  scheduleTime = time.format(context);
                });
                // Do something with the time
              }
            },
          ),
        const Gap(20),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: const BeveledRectangleBorder(),
            ),
            onPressed: selectedPaymentType == null
                ? null
                : () {
                    Random random = Random();
                    var result = '';

                    for (int i = 0; i < 9; i++) {
                      // Generate a random digit from 0 to 9
                      int digit = random.nextInt(10);

                      // Append the digit to the result string
                      result += digit.toString();
                    }

                    Week currentWeek = Week.current();

                    // Get the current date and time
                    var day = DateTime.now();
                    var dateDay = DateTime.now().day;
                    var month = DateTime.now();
                    // Format the date as a string
                    String formattedDate = DateFormat('MMMM').format(month);
                    String dayFormatter = DateFormat('EEEE').format(day);

                    addToOrder(
                        OrderModel(
                            parcelPayer:
                                selectedPayer == 1 ? 'Sender' : "Receiver",
                            senderAddress: widget.senderDetails.senderAddress,
                            senderEmail: widget.senderDetails.senderEmail,
                            senderFloorNumber:
                                widget.senderDetails.senderFloorNumber,
                            senderHouseNumber:
                                widget.senderDetails.senderHouseNumber,
                            senderLat: widget.senderDetails.senderLat,
                            senderLong: widget.senderDetails.senderLong,
                            senderName: widget.senderDetails.senderName,
                            senderPhone: widget.senderDetails.senderPhone,
                            senderStreetNumber:
                                widget.senderDetails.senderStreetNumber,
                            parcelCategory:
                                widget.parcelCategoriesModel.category,
                            parcelAdminCommission:
                                widget.parcelCategoriesModel.adminCommission,
                            receiverAddress:
                                widget.senderDetails.receiverAddress,
                            receiverEmail: widget.senderDetails.receiverEmail,
                            receiverFloorNumber:
                                widget.senderDetails.receiverFloorNumber,
                            receiverHouseNumber:
                                widget.senderDetails.receiverHouseNumber,
                            receiverLat: widget.senderDetails.receiverLat,
                            receiverLong: widget.senderDetails.receiverLong,
                            receiverName: widget.senderDetails.receiverName,
                            receiverPhone: widget.senderDetails.receiverPhone,
                            receiverStreetNumber:
                                widget.senderDetails.receiverStreetNumber,
                            prescription: null,
                            prescriptionPic: null,
                            scheduleDate: scheduleDate,
                            scheduleTime: scheduleTime,
                            vendorId: '',
                            vendorIDs: [],
                            confirmationStatus: false,
                            module: 'Parcel Delivery',
                            isPos: false,
                            couponTitle: couponTitle,
                            couponPercentage: couponPercentage,
                            useCoupon: couponTitle.isEmpty ? false : true,
                            day: dayFormatter,
                            instruction: instruction,
                            pickupAddress: '',
                            pickupPhone: '',
                            pickupStorename: '',
                            weekNumber: currentWeek.weekNumber,
                            date: '$dayFormatter, $formattedDate $dateDay',
                            orderID: result,
                            orders: [],
                            uid: uid,
                            acceptDelivery: false,
                            deliveryFee: (distance *
                                    widget.parcelCategoriesModel.chargePerKm -
                                getPercentageOfCoupon(
                                    couponPercentage,
                                    widget.parcelCategoriesModel.chargePerKm *
                                        distance)),
                            total: (distance *
                                    widget.parcelCategoriesModel.chargePerKm -
                                getPercentageOfCoupon(
                                    couponPercentage,
                                    widget.parcelCategoriesModel.chargePerKm *
                                        distance)),
                            paymentType: selectedPaymentType == 2
                                ? 'Wallet'
                                : 'Cash On Delivery',
                            userID: userID,
                            timeCreated: DateTime.now(),
                            deliveryAddress:
                                widget.senderDetails.receiverAddress,
                            houseNumber:
                                widget.senderDetails.receiverHouseNumber,
                            closesBusStop: '',
                            deliveryBoyID: '',
                            status: 'Pending',
                            accept: false),
                        uid,
                        context);
                    if (selectedPaymentType == 2) {
                      ref.read(updateParcelWalletProvider(
                          (distance * widget.parcelCategoriesModel.chargePerKm -
                              getPercentageOfCoupon(
                                  couponPercentage,
                                  widget.parcelCategoriesModel.chargePerKm *
                                      distance))));
                    }
                  },
            child: const Text(
              'Post Order',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
