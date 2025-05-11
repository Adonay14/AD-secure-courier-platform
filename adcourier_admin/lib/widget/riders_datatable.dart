import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/user.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../pages/rider_detail.dart';

class RidersData extends ConsumerStatefulWidget {
  const RidersData({super.key});

  @override
  ConsumerState<RidersData> createState() => _RidersDataState();
}

class _RidersDataState extends ConsumerState<RidersData> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;
  String deliveryBoyID = '';

  List<UserModel> users = [];
  List<UserModel> usersFilter = [];
  getUsers() {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance.collection('riders').snapshots().listen((event) {
      users.clear();
      setState(() {
        isLoaded = false;
      });
      for (var element in event.docs) {
        var user = UserModel.fromMap(element.data(), element.id);
        setState(() {
          users.add(user);
          // ignore: avoid_print
          print('Riders are $users');
        });
      }
    });
  }

  @override
  void initState() {
    getUsers();
    getCurrencySymbol();
    super.initState();
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
      usersFilter = users
          .where((user) =>
              user.displayName!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(child: CircularProgressIndicator(color: Colors.blue))
            : ListView(
                shrinkWrap: true,
                children: [
                  PaginatedDataTable(
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Riders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
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
                                  hintText: 'Search'.tr(),
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
                          'Approval Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                      DataColumn(
                        label: const Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                      DataColumn(
                        label: const Text(
                          'Wallet',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                      const DataColumn(
                        label: Text(
                          'Phone number',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        numeric: true,
                      ),
                      const DataColumn(
                        label: Text(
                          'Manage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        numeric: true,
                      ),
                    ],
                  ),
                ],
              ));
  }
}

int numberOfdelivery = 0;

List<int> deliveryBoyAmount = [];

class VendorDataSource extends DataTableSource {
  final List<UserModel> vendor;
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
    final UserModel result = vendor[index];
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
        selected: result.selected,
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(Text('${result.approval}')),
          DataCell(Text('${result.displayName}')),
          DataCell(Text(
              '$currencySymbol${CurrencyFormatter().converter(result.wallet!.toDouble())}')),
          DataCell(result.phonenumber == null
              ? Container()
              : Text('${result.phonenumber}')),
          DataCell(ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RiderDetail(userModel: result);
              }));
            },
            child: const Text('View Details',
                style: TextStyle(color: Colors.white)),
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
