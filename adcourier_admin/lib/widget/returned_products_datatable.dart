import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:admin/models/return_request_model.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/utils/push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ReturnedProductsData extends ConsumerStatefulWidget {
  const ReturnedProductsData({super.key});

  @override
  ConsumerState<ReturnedProductsData> createState() =>
      _ReturnedProductsDataState();
}

class _ReturnedProductsDataState extends ConsumerState<ReturnedProductsData> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int sortColumnIndex = 2;
  bool _sortAscending = true;

  Stream<QuerySnapshot>? yourStream;

  List<ReturnRequestModel> users = [];
  List<ReturnRequestModel> usersFilter = [];
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

  getUsersData() async {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance
        .collection('Returned Products')
        // .orderBy('timeCreated', descending: true)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      users.clear();
      for (var element in event.docs) {
        var prods = ReturnRequestModel.fromMap(element.data(), element.id);
        // ignore: avoid_print
        print('Users are $prods');
        setState(() {
          users.add(prods);
          // ignore: avoid_print
          print('User length is ${users.length}');
        });
      }
    });
  }

  String displayName = '';
  void onSearchTextChanged(String text) {
    setState(() {
      displayName = text;
      usersFilter = users
          .where(
              (user) => user.orderID.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    getUsersData();
    getCurrencySymbol();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    PaginatedDataTable(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ).tr(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width >= 1100
                                  ? MediaQuery.of(context).size.width / 2
                                  : MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                  onChanged: onSearchTextChanged,
                                  style: const TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    focusColor: Colors.grey,
                                    hintText: 'Search by Order id'.tr(),
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
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int? value) {
                        setState(() {
                          _rowsPerPage = value!;
                        });
                      },
                      source: VendorDataSource(
                          displayName == '' ? users : usersFilter,
                          context,
                          currencySymbol,
                          themeListener),
                      sortColumnIndex: sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text(
                            'Index',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text('Returned',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              sortColumnIndex = columnIndex;
                              _sortAscending = ascending;
                              users.sort((a, b) {
                                if (a.returned == b.returned) {
                                  return 0;
                                } else if (a.returned && !b.returned) {
                                  return _sortAscending ? 1 : -1;
                                } else {
                                  return _sortAscending ? -1 : 1;
                                }
                              });
                            });
                          },
                        ),
                        DataColumn(
                          label: const Text('OrderId',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        // DataColumn(
                        //   label: const Text('Image',
                        //           style: TextStyle(fontWeight: FontWeight.bold))
                        //       .tr(),
                        // ),
                        DataColumn(
                          label: const Text('Product Name',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        DataColumn(
                          label: const Text('Product to be refunded',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        DataColumn(
                          label: const Text('Price',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                        DataColumn(
                          label: const Text('Manage',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .tr(),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}

int numberOfdelivery = 0;

List<int> categoriesAmount = [];

class VendorDataSource extends DataTableSource {
  final List<ReturnRequestModel> vendor;
  final BuildContext context;
  final String currency;
  final bool themeListener;
  VendorDataSource(
      this.vendor, this.context, this.currency, this.themeListener);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final ReturnRequestModel result = vendor[index];
    return DataRow.byIndex(
        index: index,
        color: WidgetStateColor.resolveWith((states) {
          // Alternate row colors based on index
          return themeListener == false
              ? Colors.transparent
              : index.isEven
                  ? Colors.grey.shade200
                  : Colors.white;
        }),
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(Text(result.returned.toString())),
          DataCell(Text('#${result.orderID}')),
          // DataCell(Padding(
          //   padding: const EdgeInsets.all(2.0),
          //   child: Image.network(
          //     result.image,
          //     height: 50,
          //     width: 50,
          //   ),
          // )),
          DataCell(SizedBox(
              width: 100,
              child: Tooltip(
                message: result.productName,
                child: Text(
                  result.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ))),
          DataCell(SizedBox(
              width: 100,
              child: Tooltip(
                message: result.selected,
                child: Text(
                  result.selected,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ))),
          DataCell(Text(
              '$currency${CurrencyFormatter().converter(result.selectedPrice.toDouble())}')),
          DataCell(Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            MediaQuery.of(context).size.width >= 1100
                                ? AlertDialog(
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: ReturnDialog(
                                        currency: currency,
                                        requestModel: result,
                                      ),
                                    ),
                                  )
                                : ReturnDialog(
                                    currency: currency,
                                    requestModel: result,
                                  ));
                  },
                  child: const Text('Manage',
                          style: TextStyle(color: Colors.white))
                      .tr()),
            ],
          )),
        ]);
  }

  @override
  int get rowCount => vendor.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class ReturnDialog extends StatefulWidget {
  final ReturnRequestModel requestModel;
  final String currency;
  const ReturnDialog(
      {super.key, required this.requestModel, required this.currency});

  @override
  State<ReturnDialog> createState() => _ReturnDialogState();
}

class _ReturnDialogState extends State<ReturnDialog> {
  num wallet = 0;
  String token = '';
  bool isLoading = true;
  num vendorWallet = 0;
  String vendorToken = '';

  getUserWallet() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.requestModel.userID)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoading = false;
        wallet = event['wallet'];
        token = event['tokenID'];
      });
    });
  }

  getVendorWallet() {
    if (widget.requestModel.vendorID.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(widget.requestModel.vendorID)
          .snapshots()
          .listen((event) {
        setState(() {
          isLoading = false;
          vendorWallet = event['wallet'];
          vendorToken = event['tokenID'];
        });
      });
    }
  }

  num commission = 0;
  getAdminCommission() {
    FirebaseFirestore.instance
        .collection('Admin')
        .doc('Admin')
        .snapshots()
        .listen((event) {
      setState(() {
        commission = event['commission'];
      });
    });
  }

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
    getUserWallet();
    getVendorWallet();
    getAdminCommission();
    getVendorCharge();
    super.initState();
  }

  updateVendorAndAdminWallet() {
    if (widget.requestModel.vendorID.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(widget.requestModel.vendorID)
          .update({
        'wallet': vendorWallet -
            ((widget.requestModel.quantity *
                    widget.requestModel.selectedPrice) -
                ((widget.requestModel.quantity *
                        widget.requestModel.selectedPrice *
                        vendorCharge) /
                    100))
      });
      FirebaseFirestore.instance.collection('Admin').doc('Admin').update({
        'commission': commission -
            ((widget.requestModel.quantity *
                    widget.requestModel.selectedPrice *
                    vendorCharge) /
                100)
      });
      PushNotificationFunction.sendPushNotification(
          'Product Refund',
          'Debit alert of ${widget.currency}${CurrencyFormatter().converter(((widget.requestModel.quantity * widget.requestModel.selectedPrice) - ((widget.requestModel.quantity * widget.requestModel.selectedPrice * vendorCharge) / 100)).toDouble())}',
          vendorToken);
    } else {
      FirebaseFirestore.instance.collection('Admin').doc('Admin').update({
        'commission': commission -
            (widget.requestModel.quantity * widget.requestModel.selectedPrice)
      });
    }
  }

  updateUserWallet() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.requestModel.userID)
        .update({
      'wallet': wallet +
          (widget.requestModel.quantity * widget.requestModel.selectedPrice)
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      PushNotificationFunction.sendPushNotification(
          'Product Refund',
          'Your refund just arrived ${widget.currency}${CurrencyFormatter().converter((widget.requestModel.quantity * widget.requestModel.selectedPrice).toDouble())}',
          token);
      updateReturnProduct();
      updateVendorAndAdminWallet();
    });
  }

  updateReturnProduct() {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('Returned Products')
        .doc(widget.requestModel.uid)
        .update({'returned': true}).then((value) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading == true
            ? Center(
                child: const Text('Loading please wait...').tr(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(''),
                        const Text(
                          'Refund Detail',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    const Gap(20),
                    Text(
                      'Order n° ${widget.requestModel.orderID}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Gap(5),
                    Text('${widget.requestModel.quantity} items'),
                    const Gap(5),
                    Text('Product name: ${widget.requestModel.productName}'),
                    const Gap(5),
                    Text(
                        'Selected Product: ${widget.requestModel.productName}'),
                    const Gap(5),
                    Text(
                        'Return Duration: ${widget.requestModel.returnDuration}days'),
                    const Gap(5),
                    Text(
                        'Total ${widget.currency}${CurrencyFormatter().converter((widget.requestModel.selectedPrice * widget.requestModel.quantity).toDouble())}'),
                    const Gap(10),
                    const Divider(
                      color: Color.fromARGB(255, 237, 235, 235),
                      thickness: 1,
                    ),
                    const Gap(10),
                    Image.network(
                      widget.requestModel.image,
                      height: 100,
                      width: 100,
                    ),
                    const Gap(10),
                    const Text('Reason for returning',
                            style: TextStyle(fontWeight: FontWeight.bold))
                        .tr(),
                    const Gap(5),
                    Text(widget.requestModel.reason),
                    const Gap(20),
                    Center(
                        child: ElevatedButton(
                            onPressed: widget.requestModel.returned == true ||
                                    isLoading == true
                                ? null
                                : () {
                                    updateUserWallet();
                                  },
                            child: const Text('Transaction Completed').tr()))
                  ],
                ),
              ),
      ),
    );
  }
}
