// import 'package:another_flushbar/flushbar.dart';
import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/widget/categories%20data/add_parcel_categories.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../../models/parcel_category.dart';
import 'parcel_edit_category.dart';

class ParcelCategoryDatatable extends ConsumerStatefulWidget {
  const ParcelCategoryDatatable({super.key});

  @override
  ConsumerState<ParcelCategoryDatatable> createState() =>
      _ParcelCategoryDatatableState();
}

class _ParcelCategoryDatatableState
    extends ConsumerState<ParcelCategoryDatatable> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;
  List<ParcelCategoriesModel> categoriesFilter = [];
  List<ParcelCategoriesModel> categories = [];
  List<ParcelCategoriesModel> categoriesByModule = [];

  @override
  void initState() {
    getCategory();
    getCurrency();
    super.initState();
  }

  getCategory() {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance
        .collection('Parcel Categories')
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      categories.clear();
      for (var element in event.docs) {
        var cat = ParcelCategoriesModel.fromMap(element, element.id);
        setState(() {
          categories.add(cat);
        });
      }
    });
  }

  String displayName = '';
  void onSearchTextChanged(String text) {
    setState(() {
      displayName = text;
      categoriesFilter = categories
          .where((user) =>
              user.category.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  void onSearchByModule(String text) {
    setState(() {
      categoriesByModule =
          categories.where((user) => user.category == text).toList();
    });
  }

  String currency = '';
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
    bool themeListener = ref.watch(themeListenerProvider);
    return Scaffold(
      floatingActionButton: MediaQuery.of(context).size.width >= 1100
          ? null
          : FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) {
                      return const AddParcelCategory();
                    });
              },
              backgroundColor: buttonColor,
              child: const Icon(
                Icons.add,
              ),
            ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoaded == true
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue))
              : ListView(
                  shrinkWrap: true,
                  children: [
                    PaginatedDataTable(
                      // headingRowColor:
                      //     WidgetStateProperty.resolveWith<Color?>(
                      //   (Set<WidgetState> states) {
                      //     // Set the heading row color
                      //     return Colors.blueGrey.shade200; // Example color
                      //   },
                      // ),
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (MediaQuery.of(context).size.width >= 1100)
                            const Text(
                              'Parcel Categories',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ).tr(),
                          const Gap(20),
                          Flexible(
                            flex: 5,
                            child: Padding(
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
                          ),
                          if (MediaQuery.of(context).size.width >= 1100)
                            ElevatedButton(
                                style: ButtonStyle(
                                  elevation: WidgetStateProperty.all(0),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    buttonColor,
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return const AddParcelCategory();
                                      });
                                },
                                child: const Text(
                                  'Add a new category',
                                  style: TextStyle(color: Colors.white),
                                ).tr())
                        ],
                      ),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int? value) {
                        setState(() {
                          _rowsPerPage = value!;
                        });
                      },
                      source: VendorDataSource(
                          displayName == '' ? categories : categoriesFilter,
                          context,
                          themeListener,
                          currency),
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
                            'Image',
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
                            'Admin Commission %',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Charge per Km',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                        DataColumn(
                          label: const Text(
                            'Manage',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ],
                    ),
                  ],
                )),
    );
  }
}

int numberOfdelivery = 0;

List<int> categoriesAmount = [];

class VendorDataSource extends DataTableSource {
  final List<ParcelCategoriesModel> vendor;
  final BuildContext context;
  final bool themeListener;
  final String currency;
  VendorDataSource(
      this.vendor, this.context, this.themeListener, this.currency);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final ParcelCategoriesModel result = vendor[index];
    // Alternate row color: blueGrey for even, white for odd
    // final Color rowColor =
    //     index.isEven ? Colors.blueGrey.shade50 : Colors.white;
    return DataRow.byIndex(
        color: WidgetStateColor.resolveWith((states) {
          // Alternate row colors based on index
          return themeListener == false
              ? Colors.transparent
              : index.isEven
                  ? Colors.grey.shade200
                  : Colors.white;
        }),
        // color: WidgetStateProperty.resolveWith<Color?>(
        //   (Set<WidgetState> states) {
        //     // Set the heading row color
        //     return rowColor; // Example color
        //   },
        // ),
        index: index,
        cells: <DataCell>[
          DataCell(Text('${index + 1}')),
          DataCell(result.image == ''
              ? Container()
              : Image.network(result.image, width: 50, height: 50)),
          DataCell(Text(result.category)),
          DataCell(Text(result.adminCommission.toString())),
          DataCell(Text(
              '$currency${CurrencyFormatter().converter(result.chargePerKm.toDouble())}')),
          DataCell(Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      buttonColor,
                    ),
                  ),
                  onPressed: demo == true
                      ? () {
                          Fluttertoast.showToast(
                              msg: "Sorry this is in demo mode",
                              backgroundColor: buttonColor,
                              textColor: Colors.white);
                        }
                      : () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return ParcelEditCategories(
                                  categoriesModel: result,
                                );
                              });
                        },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ).tr()),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      buttonColor,
                    ),
                  ),
                  onPressed: demo == true
                      ? () {
                          Fluttertoast.showToast(
                              msg: "Sorry this is in demo mode",
                              backgroundColor: buttonColor,
                              textColor: Colors.white);
                        }
                      : () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: const Text(
                                          'Are you sure you want to delete this?')
                                      .tr(),
                                  actions: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel").tr()),
                                    // const Gap(10),
                                    InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('Parcel Categories')
                                              .doc(result.uid)
                                              .delete()
                                              .then((value) {
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                              Flushbar(
                                                flushbarPosition:
                                                    FlushbarPosition.TOP,
                                                title: "Notification".tr(),
                                                message:
                                                    "Category deleted successfully!!!"
                                                        .tr(),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ).show(context);
                                            }
                                          });
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You can't delete this because its a test mode"
                                          //             .tr(),
                                          //     toastLength: Toast.LENGTH_SHORT,
                                          //     gravity: ToastGravity.TOP,
                                          //     timeInSecForIosWeb: 1,
                                          //     backgroundColor:
                                          //         Theme.of(context).primaryColor,
                                          //     textColor: Colors.white,
                                          //     fontSize: 14.0);
                                        },
                                        child: const Text('Yes').tr())
                                  ],
                                );
                              });
                        },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ).tr()),
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
