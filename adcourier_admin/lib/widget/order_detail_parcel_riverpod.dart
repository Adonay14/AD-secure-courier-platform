import 'dart:math';
import 'package:admin/constance.dart';
import 'package:admin/models/user.dart';
import 'package:admin/providers/email_settings_provider.dart';
import 'package:admin/providers/order_detail_provider.dart';
import 'package:admin/widget/assign_countdown.dart';
import 'package:admin/widget/map_with_polylines.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../models/currency_formatter.dart';
import '../models/order_model.dart';
import '../providers/currency_provider.dart';
import 'pdf_generator_parcel_order_receipt.dart';

class OrderDetailParcelRiverpod extends ConsumerStatefulWidget {
  final OrderModel2 orderModel;
  const OrderDetailParcelRiverpod({
    super.key,
    required this.orderModel,
  });
  @override
  ConsumerState<OrderDetailParcelRiverpod> createState() =>
      _OrderDetailParcelRiverpodState();
}

class _OrderDetailParcelRiverpodState
    extends ConsumerState<OrderDetailParcelRiverpod> {
  String notificationID = '';
  int _index = 0;
  String orderStatus = '';
  bool loading = false;
  num vendorCharge = 0;
  getVendorCharge() {
    FirebaseFirestore.instance
        .collection('Vendor Charge')
        .doc('Vendor Charge')
        .snapshots()
        .listen((event) {
      setState(() {
        vendorCharge = event['Vendor Charge'];
      });
    });
  }

  @override
  void initState() {
    // getVendorCharge();
    var uuid = const Uuid();
    notificationID = uuid.v1();
    super.initState();
  }

  late CountdownTimerController controller;
  var logger = Logger();
  bool enableRiderSystem = true;
  @override
  Widget build(BuildContext context) {
    // Parse the string into a DateTime object
    final isLoading = ref.watch(loadingProviderProvider);
    final getCompanyEmail = ref.watch(getEmailDetailsProvider).valueOrNull;
    DateTime dateTime =
        DateTime.parse(widget.orderModel.timeCreated.toString());
    // final enableRiderSystem =
    //     ref.watch(getEnableRiderStatusDetailsProvider).valueOrNull ?? false;
    // logger.d('message $enableRiderSystem');
    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    final order = ref.watch(fetchOrderDetailProvider(widget.orderModel.uid));
    final currencySymbol = ref.watch(currencySymbolProvider).valueOrNull ?? '';
    var emailDetail = ref.watch(emailSettingsNotifierProvider);
    var sender = ref.read(emailSettingsNotifierProvider.notifier);
    return order.when(data: (v) {
      final userDetail = ref
              .watch(getUserDetailsProvider(widget.orderModel.userID))
              .valueOrNull ??
          UserModel();
      var riderDetail = v.deliveryBoyID.isNotEmpty
          ? ref.watch(getRiderDetailProvider(v)).valueOrNull
          : UserModel();
      var riders = ref.watch(getRidersProvider);
      num selectedPriceRiverpod = v.orders!.fold(0,
          (price, product) => price + product.selectedPrice * product.quantity);
      // num quantityRiverpod =
      //     v.orders!.fold(0, (amount, product) => amount + product.quantity);
      // var commission = ref.watch(getAdminCommissionProvider).value;
      // var riderCharge = ref.watch(getRiderChargeProvider).value;
      var ridersAuto = ref.watch(getRidersForAutoProvider).value;
      return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Order Tracking Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel, color: Colors.black)),
                    )
                  ],
                ),
              ),
              Stepper(
                physics: const BouncingScrollPhysics(),
                onStepTapped: (step) {
                  if (step > _index) {
                    setState(() {
                      _index = step;
                    });
                  }
                },
                type: StepperType.vertical,
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return const SizedBox();
                },
                currentStep: _index,
                steps: <Step>[
                  if (v.deliveryAddress!.isEmpty)
                    Step(
                      isActive: true,
                      title: const Text('Pickup'),
                      content: Container(),
                    ),
                  Step(
                    isActive: v.status == 'Pending' ? true : false,
                    title: const Text('Pending'),
                    content: Container(),
                  ),
                  if (v.status == 'Cancelled')
                    Step(
                      isActive: true,
                      title: const Text('Cancelled'),
                      content: Container(),
                    ),
                  // Step(
                  //   isActive: widget.orderModel.accept == true ? true : false,
                  //   title: const Text('Pending'),
                  //   content: Container(),
                  // ),
                  Step(
                    isActive: v.accept == true && v.status == 'Confirmed'
                        ? true
                        : false,
                    title: const Text('Confirmed'),
                    content: Container(),
                  ),
                  if (v.deliveryAddress!.isNotEmpty)
                    Step(
                      isActive: v.accept == true && v.status == 'Processing'
                          ? true
                          : false,
                      title: const Text('Processing'),
                      content: Container(),
                    ),
                  if (v.deliveryAddress!.isNotEmpty)
                    Step(
                      isActive:
                          v.acceptDelivery == true && v.status == 'On the way'
                              ? true
                              : false,
                      title: const Text('On the way'),
                      content: Container(),
                    ),

                  Step(
                    isActive: v.status == 'Delivered' ? true : false,
                    title: const Text('Delivered'),
                    content: Container(),
                  )
                ],
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: MapWithPolylines(
                    originLatitude: widget.orderModel.senderLat!,
                    originLongitude: widget.orderModel.senderLong!,
                    destLatitude: widget.orderModel.receiverLat!,
                    destLongitude: widget.orderModel.receiverLong!,
                    address: widget.orderModel.senderAddress!),
              ),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order n° ${v.orderID}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(5),
                  Text('Parcel type: ${v.parcelCategory}'),
                  const Gap(5),
                  Text('Placed on $formattedDate'),
                  const Gap(5),
                  Text(
                      'Total $currencySymbol${CurrencyFormatter().converter(v.total.toDouble())}'),
                  const Gap(10),
                  const Divider(
                    color: Color.fromARGB(255, 237, 235, 235),
                    thickness: 1,
                  ),
                  const Gap(10),
                  // const Text(
                  //   'ITEM TO BE DELIVERED',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ).tr(),
                  // const Gap(10),
                  // // const Divider(
                  // //   color: Color.fromARGB(255, 237, 235, 235),
                  // //   thickness: 1,
                  // // ),
                  // // const Gap(10),
                  // ListView.builder(
                  //   physics: const BouncingScrollPhysics(),
                  //   shrinkWrap: true,
                  //   itemCount: v.orders!.length,
                  //   itemBuilder: (context, index) {
                  //     OrdersList cartModel = v.orders![index];
                  //     return Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             borderRadius:
                  //                 const BorderRadius.all(Radius.circular(2)),
                  //             border: Border.all(
                  //                 color: const Color.fromARGB(
                  //                     255, 237, 235, 235))),
                  //         // height: MediaQuery.of(context).size.width >= 1100
                  //         //     ? 200
                  //         //     : 200,
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             children: [
                  //               Expanded(
                  //                   flex: 2,
                  //                   child: Image.network(
                  //                     cartModel.image,
                  //                     fit: BoxFit.cover,
                  //                   )),
                  //               const Gap(20),
                  //               Expanded(
                  //                   flex: 5,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       Text(
                  //                         cartModel.productName,
                  //                         maxLines: 2,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: const TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w200),
                  //                       ),
                  //                       const Gap(10),
                  //                       Text(
                  //                         v.parcelCategory!,
                  //                         maxLines: 2,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: const TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.w200),
                  //                       ),
                  //                       const Gap(10),
                  //                       Text(
                  //                         '$currencySymbol${CurrencyFormatter().converter(cartModel.selectedPrice.toDouble())}',
                  //                         maxLines: 1,
                  //                         overflow: TextOverflow.ellipsis,
                  //                         style: const TextStyle(
                  //                             fontSize: 12,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ],
                  //                   ))
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   // separatorBuilder:
                  //   //     (BuildContext context, int index) {
                  //   //   return const Divider(
                  //   //       color:
                  //   //           Color.fromARGB(255, 236, 227, 227));
                  //   // },
                  // ),
                  // const Gap(20),
                  const Text(
                    'PARCEL INSTRUCTION',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).tr(),
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
                              text: 'Instruction: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.instruction),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(10),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Payment Method: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.paymentType),
                          ],
                        ),
                      ),
                      // const Gap(5),
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       const TextSpan(
                      //         text: 'Items Total: ',
                      //         style: TextStyle(fontWeight: FontWeight.bold),
                      //       ),
                      //       TextSpan(
                      //           text:
                      //               '$currencySymbol${CurrencyFormatter().converter(selectedPriceRiverpod.toDouble())}'),
                      //     ],
                      //   ),
                      // ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Delivery Fee: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    '$currencySymbol${CurrencyFormatter().converter(widget.orderModel.deliveryFee!.toDouble())}'),
                          ],
                        ),
                      ),
                      if (widget.orderModel.useCoupon == true) const Gap(5),
                      if (widget.orderModel.useCoupon == true)
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Discount: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text:
                                      '$currencySymbol${CurrencyFormatter().converter(((selectedPriceRiverpod + widget.orderModel.deliveryFee!) * widget.orderModel.couponPercentage! / 100).toDouble())} at ${widget.orderModel.couponPercentage}% Discount'),
                            ],
                          ),
                        ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Payer: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.parcelPayer),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Total: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text:
                                    '$currencySymbol${CurrencyFormatter().converter(widget.orderModel.total.toDouble())}'),
                          ],
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                  // if (widget.orderModel.deliveryAddress!.isNotEmpty)

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PICKUP INFORMATION',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr(),
                      const Gap(5),
                      const Divider(
                        color: Color.fromARGB(255, 237, 235, 235),
                        thickness: 1,
                      ),
                      const Gap(10),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Sender Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderName),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Sender Email: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderEmail),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Sender Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderPhone),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Sender Address: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderAddress),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Sender Street Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: widget.orderModel.senderStreetNumber),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Sender Floor Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderFloorNumber),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Sender House Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.senderHouseNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DELIVERY INFORMATION',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr(),
                      const Gap(5),
                      const Divider(
                        color: Color.fromARGB(255, 237, 235, 235),
                        thickness: 1,
                      ),
                      const Gap(10),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Receiver's Name: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.receiverName),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Receiver Email: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.receiverEmail),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "Receiver's Phone: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.receiverPhone),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Receiver Address: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: widget.orderModel.receiverAddress),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Receiver Street Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: widget.orderModel.receiverStreetNumber),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Receiver Floor Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: widget.orderModel.receiverFloorNumber),
                          ],
                        ),
                      ),
                      const Gap(5),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Receiver House Number: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: widget.orderModel.receiverHouseNumber),
                          ],
                        ),
                      ),
                      if (v.acceptDelivery == true ||
                          v.deliveryBoyID.isNotEmpty)
                        const Gap(5),
                      if (enableRiderSystem == true)
                        if (riderDetail != null)
                          if (v.acceptDelivery == true ||
                              v.deliveryBoyID.isNotEmpty)
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Rider name: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: '${riderDetail.displayName}'),
                                ],
                              ),
                            ),
                      if (enableRiderSystem == true)
                        if (riderDetail != null)
                          if (v.acceptDelivery == true ||
                              v.deliveryBoyID.isNotEmpty)
                            const Gap(5),
                      if (enableRiderSystem == true)
                        if (riderDetail != null)
                          if (v.acceptDelivery == true ||
                              v.deliveryBoyID.isNotEmpty)
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Rider phone: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: '${riderDetail.phonenumber}'),
                                ],
                              ),
                            ),
                      const Gap(20),
                      if (MediaQuery.of(context).size.width >= 1100)
                        if (enableRiderSystem == true)
                          if (v.acceptDelivery == false &&
                              v.deliveryBoyID.isNotEmpty &&
                              v.accept == true &&
                              v.status == 'Processing')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Waiting for Rider to acept order...',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(20),
                                AssignCountdown(
                                  acceptDelivery: v.acceptDelivery,
                                  orderModel2: widget.orderModel,
                                ),
                                // CountdownTimer(
                                //   endTime: v.acceptDelivery == true
                                //       ? null
                                //       : DateTime.now()
                                //               .millisecondsSinceEpoch +
                                //           1000 * 60,
                                //   textStyle: const TextStyle(
                                //       fontWeight: FontWeight.bold),
                                //   onEnd: () {
                                //     if (v.acceptDelivery == false) {
                                //       ref.read(cancelRiderProvider(
                                //           widget.orderModel, context));
                                //     }
                                //   },
                                // ),
                                const Gap(20),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor),
                                    onPressed: () {
                                      ref.read(cancelRiderProvider(
                                          widget.orderModel, context));
                                    },
                                    child: const Text(
                                      'Cancel wait',
                                      style: TextStyle(color: Colors.white),
                                    ).tr())
                              ],
                            ),
                      if (MediaQuery.of(context).size.width <= 1100)
                        if (enableRiderSystem == true)
                          if (v.acceptDelivery == false &&
                              v.deliveryBoyID.isNotEmpty &&
                              v.accept == true &&
                              v.status == 'Processing')
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Waiting for Rider to aacept order...',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Gap(20),
                                AssignCountdown(
                                  acceptDelivery: v.acceptDelivery,
                                  orderModel2: widget.orderModel,
                                ),
                                const Gap(20),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonColor),
                                    onPressed: () {
                                      ref.read(cancelRiderProvider(
                                          widget.orderModel, context));
                                    },
                                    child: const Text(
                                      'Cancel wait',
                                      style: TextStyle(color: Colors.white),
                                    ).tr())
                              ],
                            ),
                      if (enableRiderSystem == true)
                        if (v.acceptDelivery == false &&
                            v.deliveryBoyID.isEmpty &&
                            v.accept == true &&
                            v.status == 'Processing')
                          // if (riders.isNotEmpty)
                          Row(children: [
                            const Text('Assign Rider:').tr(),
                          ]),
                      if (enableRiderSystem == true)
                        if (v.acceptDelivery == false &&
                            v.deliveryBoyID.isEmpty &&
                            v.accept == true &&
                            v.status == 'Processing')
                          const Gap(10),
                      if (enableRiderSystem == true)
                        if (v.acceptDelivery == false &&
                            v.deliveryBoyID.isEmpty &&
                            v.accept == true &&
                            v.status == 'Processing')
                          riders.when(data: (v) {
                            return DropdownSearch<UserModel>(
                              compareFn: (i1, i2) =>
                                  i1.displayName == i2.displayName,
                              popupProps: const PopupProps.menu(
                                  // showSelectedItems: true,
                                  // showSearchBox: true
                                  ),
                              items: (e, r) => v,
                              itemAsString: (item) {
                                return item.displayName!;
                              },
                              // validator: (v) => v == null ? "Required field".tr() : null,
                              decoratorProps: DropDownDecoratorProps(
                                  decoration: InputDecoration(
                                hintText: 'Select An Available Rider'.tr(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                              )),
                              onChanged: (value) {
                                // setState(() {
                                //   assignRider(value!.uid!);
                                // });
                                ref.read(assignRiderProvider(
                                    value!.uid!, widget.orderModel, context));
                              },
                            );
                          }, error: (e, er) {
                            return Center(
                              child: Text(e.toString()),
                            );
                          }, loading: () {
                            return const Center(
                                child: CircularProgressIndicator());
                          })
                    ],
                  ),
                  if (enableRiderSystem == true)
                    if (v.acceptDelivery == false &&
                        v.deliveryBoyID.isEmpty &&
                        v.accept == true &&
                        v.status == 'Processing')
                      const Gap(10),
                  if (enableRiderSystem == true)
                    if (v.acceptDelivery == false &&
                        v.deliveryBoyID.isEmpty &&
                        v.accept == true &&
                        v.status == 'Processing')
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor),
                            onPressed: () {
                              final random = Random();
                              // Get a random item from the list
                              String randomItem = ridersAuto![
                                  random.nextInt(ridersAuto.length)];
                              ref.read(assignRiderProvider(
                                  randomItem, widget.orderModel, context));
                            },
                            child: const Text(
                              'Auto Assign A Rider',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),

                  const SizedBox(height: 20),
                  Row(children: [
                    const Text('Update Order Status:').tr(),
                  ]),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: DropdownSearch<String>(
                      enabled:
                          v.status == 'Delivered' || v.status == 'Cancelled'
                              ? false
                              : true,
                      selectedItem: v.status,
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                      ),
                      items: (r, e) => [
                        // 'Cancel',
                        // if (widget.orderModel.status == 'Pending')
                        //   'Pending',
                        if (v.accept == false) 'Pending',
                        if (v.accept == false) 'Confirmed',
                        if (v.accept == false) 'Cancel',
                        if (v.accept == true &&
                            v.deliveryAddress!.isNotEmpty &&
                            v.acceptDelivery == false)
                          'Processing',
                        if (v.accept == true &&
                            v.deliveryAddress!.isNotEmpty &&
                            v.acceptDelivery == true)
                          'On the way',
                        if (v.accept == true && v.deliveryAddress!.isEmpty)
                          'Delivered',
                        if (v.accept == true &&
                            v.deliveryAddress!.isNotEmpty &&
                            v.acceptDelivery == true)
                          'Delivered',
                      ],
                      validator: (v) =>
                          v == null ? "Required field".tr() : null,
                      decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintText: 'Status',
                      )),
                      onChanged: (value) {
                        if (enableRiderSystem == true) {
                          if (widget.orderModel.deliveryAddress!.isNotEmpty) {
                            if (v.accept == false && v.status == 'Pending') {
                              setState(() {
                                orderStatus = value!;
                              });
                            } else if (v.accept == true &&
                                v.status == 'Pending' &&
                                v.acceptDelivery == false) {
                              Fluttertoast.showToast(
                                  msg: "Select a delivery person to continue"
                                      .tr(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            } else {
                              setState(() {
                                orderStatus = value!;
                              });
                            }
                          } else {
                            setState(() {
                              orderStatus = value!;
                            });
                          }
                        } else {
                          if (widget.orderModel.deliveryAddress!.isNotEmpty) {
                            if (widget.orderModel.accept == false &&
                                widget.orderModel.status == 'Pending') {
                              setState(() {
                                orderStatus = value!;
                              });
                            } else {
                              setState(() {
                                orderStatus = value!;
                              });
                            }
                          } else {
                            setState(() {
                              orderStatus = value!;
                            });
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  loading == true
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: null,
                          child: const Text('Please wait...'))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: v.status == 'Delivered' ||
                                  isLoading == true ||
                                  orderStatus.isEmpty
                              ? null
                              : () {
                                  // updateStatus(orderStatus!);

                                  ref.read(updateStatusProvider(
                                      orderStatus,
                                      v,
                                      context,
                                      userDetail.token!,
                                      notificationID));
                                  if (orderStatus == 'Delivered') {
                                    logger.d(
                                        'delivery Boy id from orders page is ${v.deliveryBoyID}');
                                    deliveredTimeCreatedFuncForParcel(
                                      v,
                                    );
                                  }
                                  if (emailDetail.disableEmail == false) {
                                    if (emailDetail.selectedPlatform ==
                                        'Mailgun') {
                                      sender.sendBulkEmailWithMailGunEmail(
                                          getCompanyEmail!,
                                          emailDetail.mailGunDomain,
                                          emailDetail.mailGunDomain,
                                          [userDetail.email!],
                                          postEmailSubject(v.orderID),
                                          postEmailContent(
                                              orderStatus, v.orderID),
                                          context);
                                    } else {
                                      sender.sendBulkEmailWithSendGridEmail(
                                          getCompanyEmail!,
                                          emailDetail.sendGridApi,
                                          [userDetail.email!],
                                          postEmailSubject(v.orderID),
                                          postEmailContent(
                                              orderStatus, v.orderID),
                                          context);
                                    }
                                  }
                                },
                          child: const Text(
                            'Update Status',
                            style: TextStyle(color: Colors.white),
                          )),
                  //  if (orderDetail!.status == "Delivered")
                  const SizedBox(
                    height: 20,
                  ),
                  //  if (orderDetail!.status == 'Delivered')
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: PdfGeneratorParcelOrderReceipt(
                                  orderModel2: v,
                                  fullName: userDetail.displayName!,
                                ),
                              );
                            });
                      },
                      child: const Text(
                        'Print Receipt',
                        style: TextStyle(color: Colors.white),
                      ).tr()),
                  const SizedBox(height: 50),
                ],
              )
            ],
          )));
    }, error: (ee, eer) {
      return Center(
        child: Text(ee.toString()),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
