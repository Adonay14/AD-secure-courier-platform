import 'package:admin/constance.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:random_string/random_string.dart';
import 'package:sizer/sizer.dart';

import '../models/coupon.dart';

class CouponData extends ConsumerStatefulWidget {
  const CouponData({super.key});

  @override
  ConsumerState<CouponData> createState() => _CouponDataState();
}

class _CouponDataState extends ConsumerState<CouponData> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;

  Stream<QuerySnapshot>? yourStream;
  @override
  void initState() {
    getFeeds();
    super.initState();
  }

  List<CouponModel> feeds = [];
  List<CouponModel> feedsFilter = [];
  getFeeds() {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance.collection('Coupons').snapshots().listen((v) {
      setState(() {
        isLoaded = false;
      });
      feeds.clear();
      for (var e in v.docs) {
        var c = CouponModel.fromMap(e.data(), e.id);
        setState(() {
          feeds.add(c);
        });
        // ignore: avoid_print
        print(isLoaded = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(child: CircularProgressIndicator(color: Colors.blue))
            : SingleChildScrollView(
                child: Column(
                  // shrinkWrap: true,
                  children: [
                    PaginatedDataTable(
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Coupons'),
                          if (MediaQuery.of(context).size.width >= 1100)
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Generate Coupon',
                                                style:
                                                    TextStyle(fontSize: 15.sp),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    context.pop();
                                                  },
                                                  icon: const Icon(Icons.close))
                                            ],
                                          ),
                                          content: const SizedBox(
                                            height: 500,
                                            width: 400,
                                            child: GenerateCoupon(),
                                          ),
                                        );
                                      });
                                },
                                child: const Text(
                                  'Create A Coupon',
                                  style: TextStyle(color: Colors.white),
                                ))
                        ],
                      ),
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (int? value) {
                        setState(() {
                          _rowsPerPage = value!;
                        });
                      },
                      source: VendorDataSource(feeds, context, themeListener),
                      sortColumnIndex: _sortColumnIndex,
                      sortAscending: _sortAscending,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Index',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Title',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Coupon',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Time Created',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Percentage %',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Delete',
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

List<int> categoriesAmount = [];

class VendorDataSource extends DataTableSource {
  final List<CouponModel> vendor;
  final bool themeListener;
  VendorDataSource(this.vendor, this.context, this.themeListener);
  final BuildContext context;
  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final CouponModel result = vendor[index];
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
          DataCell(Text(result.title)),
          DataCell(Text(result.coupon)),
          DataCell(Text('${result.timeCreated}')),
          DataCell(Text('${result.percentage}%')),
          DataCell(ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: demo == true
                  ? () {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : () {
                      FirebaseFirestore.instance
                          .collection('Coupons')
                          .doc(result.uid)
                          .delete();
                    },
              child: const Text(
                'Delete Coupon',
                style: TextStyle(color: Colors.white),
              ))),
        ]);
  }

  @override
  int get rowCount => vendor.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class GenerateCoupon extends StatefulWidget {
  const GenerateCoupon({super.key});

  @override
  State<GenerateCoupon> createState() => _GenerateCouponState();
}

class _GenerateCouponState extends State<GenerateCoupon> {
  String coupon = '';
  num percentage = 0;
  String title = '';

  generateCoupon() {
    setState(() {
      coupon = randomAlphaNumeric(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            //  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.name,
            onChanged: (v) {
              setState(() {
                title = v;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter title',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            onChanged: (v) {
              setState(() {
                percentage = int.parse(v);
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter Percentage',
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Coupon Code: $coupon'),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                generateCoupon();
              },
              child: const Text(
                'Generate Coupon',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(height: 40),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                if (coupon == '' || percentage == 0 || title == '') {
                  Fluttertoast.showToast(
                      msg: "All fields are required",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                } else {
                  FirebaseFirestore.instance.collection('Coupons').add({
                    'title': title,
                    'percentage': percentage,
                    'coupon': coupon,
                    'timeCreated': DateFormat.yMMMMEEEEd()
                        .format(DateTime.now())
                        .toString(),
                  }).then((value) {
                    if (context.mounted) {
                      context.pop();
                    }
                    Fluttertoast.showToast(
                        msg: "Coupon Successfully Created",
                        backgroundColor: buttonColor,
                        textColor: Colors.white);
                  });
                }
              },
              child: const Text(
                'Upload Coupon',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
