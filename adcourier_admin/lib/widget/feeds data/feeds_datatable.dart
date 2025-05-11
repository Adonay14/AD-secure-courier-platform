// import 'package:another_flushbar/flushbar.dart';
// import 'package:another_flushbar/flushbar.dart';
import 'package:admin/constance.dart';
import 'package:admin/providers/feed_provider.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/widget/cat_image_widget.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/feeds.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'add_feeds.dart';
import 'view_feeds.dart';

class FeedsData extends ConsumerStatefulWidget {
  const FeedsData({super.key});

  @override
  ConsumerState<FeedsData> createState() => _FeedsDataState();
}

class _FeedsDataState extends ConsumerState<FeedsData> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    var feeds = ref.watch(getFeedsProvider);
    bool themeListener = ref.watch(themeListenerProvider);
    return feeds.when(data: (v) {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              PaginatedDataTable(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sliders',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ).tr(),
                    if (MediaQuery.of(context).size.width >= 1100)
                      ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            backgroundColor: WidgetStateProperty.all<Color>(
                              buttonColor,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return const AddFeed();
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
                          child: const Text(
                            'Add new feed',
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
                source: VendorDataSource(v, context, themeListener),
                sortColumnIndex: _sortColumnIndex,
                sortAscending: _sortAscending,
                columns: <DataColumn>[
                  DataColumn(
                    label: const Text(
                      'Index',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Module',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Banner',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Slider',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                  DataColumn(
                    label: const Text(
                      'Manage',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ).tr(),
                  ),
                ],
              ),
            ],
          ));
    }, error: (error, r) {
      return Text(error.toString());
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}

int numberOfdelivery = 0;

List<int> categoriesAmount = [];

class VendorDataSource extends DataTableSource {
  final List<FeedsModel> vendor;
  final bool themeListener;
  final BuildContext context;
  VendorDataSource(this.vendor, this.context, this.themeListener);

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final FeedsModel result = vendor[index];
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
          DataCell(Text(result.module)),
          DataCell(Text(result.title)),
          DataCell(result.image == ''
              ? Container()
              : SizedBox(
                  height: 50,
                  width: 50,
                  child: CatImageWidget(
                    url: result.image,
                    boxFit: 'cover',
                  ),
                )),
          DataCell(Text(result.category)),
          DataCell(Text(result.slider.toString())),
          DataCell(Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      buttonColor,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (builder) {
                          return ViewFeed(
                            categoriesModel: result,
                          );
                        });
                  },
                  child: const Text(
                    'View details',
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
                          FirebaseFirestore.instance
                              .collection('Sliders')
                              .doc(result.uid)
                              .delete()
                              .then((value) {
                            if (context.mounted) {
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Notification",
                                message:
                                    "Sub category collection deleted successfully!!!",
                                duration: const Duration(seconds: 3),
                              ).show(context);
                            }
                          });
                          // Fluttertoast.showToast(
                          //     msg: "You can't delete this because its a test mode".tr(),
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.TOP,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Theme.of(context).primaryColor,
                          //     textColor: Colors.white,
                          //     fontSize: 14.0);
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
