import 'package:admin/constance.dart';
import 'package:admin/models/user.dart';
import 'package:admin/widget/order_detail_parcel_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../models/currency_formatter.dart';
import '../models/order_model.dart';
import '../widget/license_image.dart';

class RiderDetail extends StatefulWidget {
  final UserModel userModel;
  const RiderDetail({super.key, required this.userModel});

  @override
  State<RiderDetail> createState() => _RiderDetailState();
}

class _RiderDetailState extends State<RiderDetail> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  String deliveryBoyID = '';
  Stream<QuerySnapshot>? yourStream;
  @override
  void initState() {
    getLincense();
    getCurrencySymbol();
    getCurrencyDetails();
    getApprovalStatus();
    fetAllOrders();
    // yourStream = FirebaseFirestore.instance.collection('Products').snapshots();
    super.initState();
  }

  Future<List<OrderModel2>> fetAllOrders() async {
    FirebaseFirestore.instance
        .collection('Orders')
        .where('deliveryBoyID', isEqualTo: widget.userModel.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      orders.clear();
      for (var doc in data.docs) {
        if (mounted) {
          setState(() {
            orders.add(OrderModel2(
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
              orders: [
                ...(doc.data()['orders']).map((items) {
                  return OrdersList.fromMap(items);
                })
              ],
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
            ));
          });
        }
      }
      orders.sort((a, b) => b.timeCreated.compareTo(a.timeCreated));
    });
    return orders;
  }

  int numberOfdelivery = 0;

  List<OrderModel2> orders = [];
  List<int> deliveryBoyAmount = [];
  String currencySymbol = '';

  getCurrencySymbol() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        currencySymbol = value['Currency symbol'];
      });
    });
  }

  List<OrderModel2> ordersFilter = [];
  String displayName = '';
  void onSearchTextChanged(String text) {
    setState(() {
      displayName = text;
      ordersFilter = orders
          .where((user) => user.orderID
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toList();
    });
  }

  bool approval = false;
  getApprovalStatus() {
    FirebaseFirestore.instance
        .collection('riders')
        .doc(widget.userModel.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        approval = event['approval'];
      });
    });
  }

  String getcurrencySymbol = '';

  getCurrencyDetails() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        // getcurrencyName = value['Currency name'];
        // getcurrencyCode = value['Currency code'];
        getcurrencySymbol = value['Currency symbol'];
      });
    });
  }

  String? license = '';

  getLincense() {
    FirebaseFirestore.instance
        .collection('riders')
        .doc(widget.userModel.uid)
        .snapshots()
        .listen((event) {
      setState(() {
        license = event.data()!['license'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(child: CircularProgressIndicator(color: Colors.blue))
            : ListView(
                shrinkWrap: true,
                children: [
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  const Gap(10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Name: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.userModel.displayName}'),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Phone: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.userModel.phonenumber}'),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Email Address: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.userModel.email}'),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Address: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '${widget.userModel.address}'),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Wallet: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text: '$currencySymbol${widget.userModel.wallet}'),
                      ],
                    ),
                  ),
                  if (license != null)
                    if (license!.isNotEmpty) const Gap(20),
                  if (license != null)
                    if (license!.isNotEmpty)
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LicenseImage(prescriptionPic: license!);
                            }));
                          },
                          child: const Text(
                            'View License / Document Picture',
                            style: TextStyle(color: Colors.white),
                          )),
                  const Gap(10),
                  CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text(
                        'Approval Status',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: approval,
                      onChanged: (v) {
                        setState(() {
                          approval = !approval;

                          FirebaseFirestore.instance
                              .collection('riders')
                              .doc(widget.userModel.uid)
                              .update({'approval': approval});
                        });
                      }),
                  Text(
                    '${widget.userModel.displayName} Orders',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ).tr(),
                  const Gap(10),
                  PaginatedDataTable(
                      showCheckboxColumn: false,
                      header: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width >= 1100
                                  ? MediaQuery.of(context).size.width / 2
                                  : MediaQuery.of(context).size.width / 1.5,
                              child: TextField(
                                  onChanged: onSearchTextChanged,
                                  style: const TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    focusColor: Colors.grey,
                                    hintText:
                                        'Search for Orders by Oder ID'.tr(),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: buttonColor,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      // header: const Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Orders'),
                      //   ],
                      // ),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int? value) {
                        setState(() {
                          _rowsPerPage = value!;
                        });
                      },
                      sortColumnIndex: _sortColumnIndex,
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text('Order ID',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        DataColumn(
                          label: const Text('Order status',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        DataColumn(
                          label: const Text('Time created',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        // DataColumn(
                        //   label: const Text('User name'),
                        // ),
                        DataColumn(
                          label: const Text(
                            'Total price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                          numeric: true,
                        ),
                        DataColumn(
                          label: const Text('Address',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                          numeric: true,
                        ),
                        DataColumn(
                          label: const Text('View Orders',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                          numeric: true,
                        ),
                      ],
                      source: ResultsDataSource(
                          displayName.isEmpty ? orders : ordersFilter,
                          getcurrencySymbol,
                          context)),
                ],
              ));
  }
}

class ResultsDataSource extends DataTableSource {
  final List<OrderModel2> orders;
  final String getcurrencySymbol;
  final BuildContext context;
  ResultsDataSource(this.orders, this.getcurrencySymbol, this.context);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= orders.length) return null;
    final OrderModel2 result = orders[index];
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('#${result.orderID}')),
      DataCell(Center(
          child: result.status == "Pending"
              ? Row(
                  children: [
                    RippleAnimation(
                      color: Colors.green,
                      delay: const Duration(milliseconds: 300),
                      repeat: true,
                      minRadius: 10,
                      ripplesCount: 4,
                      duration: const Duration(milliseconds: 6 * 300),
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                    const Gap(5),
                    const Text('Pending',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold))
                        .tr(),
                  ],
                )
              : result.status == "Confirmed"
                  ? Row(
                      children: [
                        RippleAnimation(
                          color: Colors.green,
                          delay: const Duration(milliseconds: 300),
                          repeat: true,
                          minRadius: 10,
                          ripplesCount: 4,
                          duration: const Duration(milliseconds: 6 * 300),
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                                color: Colors.blue, shape: BoxShape.circle),
                          ),
                        ),
                        const Gap(5),
                        const Text('Confirmed',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold))
                            .tr(),
                      ],
                    )
                  : result.status == "Processing"
                      ? Row(
                          children: [
                            RippleAnimation(
                              color: Colors.yellow,
                              delay: const Duration(milliseconds: 300),
                              repeat: true,
                              minRadius: 10,
                              ripplesCount: 4,
                              duration: const Duration(milliseconds: 6 * 300),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    shape: BoxShape.circle),
                              ),
                            ),
                            const Gap(5),
                            const Text('Processing',
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold))
                                .tr(),
                          ],
                        )
                      : result.status == "Pickup"
                          ? Row(
                              children: [
                                RippleAnimation(
                                  color: Colors.purple,
                                  delay: const Duration(milliseconds: 300),
                                  repeat: true,
                                  minRadius: 10,
                                  ripplesCount: 4,
                                  duration:
                                      const Duration(milliseconds: 6 * 300),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                const Gap(5),
                                const Text('Pickup',
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold))
                                    .tr(),
                              ],
                            )
                          : result.status == "On the way"
                              ? Row(
                                  children: [
                                    RippleAnimation(
                                      color: Colors.deepOrange,
                                      delay: const Duration(milliseconds: 300),
                                      repeat: true,
                                      minRadius: 10,
                                      ripplesCount: 4,
                                      duration:
                                          const Duration(milliseconds: 6 * 300),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                            color: Colors.deepOrange,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                    const Gap(5),
                                    const Text('On the way',
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold))
                                        .tr(),
                                  ],
                                )
                              : result.status == "Delivered"
                                  ? Row(
                                      children: [
                                        RippleAnimation(
                                          color: Colors.blue.shade800,
                                          delay:
                                              const Duration(milliseconds: 300),
                                          repeat: true,
                                          minRadius: 10,
                                          ripplesCount: 4,
                                          duration: const Duration(
                                              milliseconds: 6 * 300),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade800,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Gap(5),
                                        Text('Delivered',
                                                style: TextStyle(
                                                    color: Colors.blue.shade800,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .tr(),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        RippleAnimation(
                                          color: Colors.red,
                                          delay:
                                              const Duration(milliseconds: 300),
                                          repeat: true,
                                          minRadius: 10,
                                          ripplesCount: 4,
                                          duration: const Duration(
                                              milliseconds: 6 * 300),
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Gap(5),
                                        const Text('Cancelled',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .tr(),
                                      ],
                                    ))),
      DataCell(Text('${result.timeCreated}')),
      // DataCell(Text('${result.userID}')),
      DataCell(Text(
        '$getcurrencySymbol${CurrencyFormatter().converter(result.total.toDouble())}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      DataCell(result.deliveryAddress == ''
          ? Align(
              alignment: Alignment.center,
              child: const Text(
                'Pick Up',
                textAlign: TextAlign.center,
              ).tr(),
            )
          : SizedBox(
              width: 150,
              child: Text(
                result.deliveryAddress!,
                overflow: TextOverflow.ellipsis,
              ))),
      DataCell(ElevatedButton(
          style: ButtonStyle(
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all<Color>(
              buttonColor,
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return OrderDetailParcelRiverpod(orderModel: result);
            }));
          },
          child: const Text(
            'View Detail',
            style: TextStyle(color: Colors.white),
          ).tr())),
    ]);
  }

  @override
  int get rowCount => orders.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
