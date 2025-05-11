import 'package:admin/models/bank_model.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'withdrawal_approval_widget.dart';

class WithdrawalRequestDatatable extends ConsumerStatefulWidget {
  const WithdrawalRequestDatatable({super.key});

  @override
  ConsumerState<WithdrawalRequestDatatable> createState() =>
      _WithdrawalRequestDatatableState();
}

class _WithdrawalRequestDatatableState
    extends ConsumerState<WithdrawalRequestDatatable> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;
  String deliveryBoyID = '';
  // Stream<QuerySnapshot>? yourStream;
  @override
  void initState() {
    getCurrencySymbol();

    getProducts();
    // yourStream = FirebaseFirestore.instance.collection('Products').snapshots();
    super.initState();
  }

  List<BankModel> products = [];
  List<BankModel> productsFilter = [];

  getProducts() async {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance
        .collection('Withdrawal Request')
        .where('paymentStatus', isEqualTo: false)
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      products.clear();
      for (var element in event.docs) {
        var prods = BankModel.fromMap(element, element.id);

        setState(() {
          products.add(prods);
        });
      }
    });
  }

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

  String displayName = '';
  void onSearchTextChanged(String text) {
    setState(() {
      displayName = text;
      productsFilter = products
          .where((user) =>
              user.accountNumber.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    var vendorData = VendorDataSource(
        displayName == '' ? products : productsFilter,
        context,
        currencySymbol,
        themeListener);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(child: CircularProgressIndicator(color: Colors.blue))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    PaginatedDataTable(
                      columnSpacing: 30,
                      showFirstLastButtons: true,
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Withdrawal Request',
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
                                    hintText:
                                        'Search for withdrawal by account number'
                                            .tr(),
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 25,
                                      color: Colors.blue.shade800,
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
                      source: vendorData,
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: <DataColumn>[
                        DataColumn(
                          label: const Text(
                            'Index',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Bank Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Account',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Time Created',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        const DataColumn(
                          label: Text(
                            'Manage',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}

int numberOfdelivery = 0;

List<int> deliveryBoyAmount = [];

class VendorDataSource extends DataTableSource {
  final List<BankModel> vendor;
  final String currencySymbol;
  final BuildContext context;
  final bool themeListener;
  VendorDataSource(
      this.vendor, this.context, this.currencySymbol, this.themeListener);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final BankModel result = vendor[index];
    return DataRow.byIndex(
        color: WidgetStateColor.resolveWith((states) {
          // Alternate row colors based on index
          return themeListener == false
              ? Colors.transparent
              : index.isEven
                  ? Colors.grey.shade200
                  : Colors.white;
        }),
        index: index,
        //  selected: result.selected,
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(Text(result.bankName)),
          DataCell(Text(
            result.accountNumber,
            // overflow: TextOverflow.ellipsis,
          )),
          DataCell(Text(
            '$currencySymbol${CurrencyFormatter().converter(result.amount!.toDouble())}',
          )),
          DataCell(Text(
            result.timeCreated.toString(),
          )),
          DataCell(ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all<Color>(
                  Colors.blue.shade800,
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => MediaQuery.of(context).size.width >=
                            1100
                        ? AlertDialog(
                            content: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: WithdrawalApprovalWidget(
                                  currency: currencySymbol,
                                  bankModel: result,
                                )),
                          )
                        : WithdrawalApprovalWidget(
                            currency: currencySymbol,
                            bankModel: result,
                          ));
              },
              child: const Text('View Detail').tr())),
        ]);
  }

  @override
  int get rowCount => vendor.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
