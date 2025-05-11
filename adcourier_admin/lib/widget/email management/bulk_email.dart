// ignore_for_file: avoid_print

import 'package:admin/constance.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/widget/email%20management/send_bulk_email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../models/email_model.dart';

class BulkEmailDataTable extends ConsumerStatefulWidget {
  const BulkEmailDataTable({super.key});

  @override
  ConsumerState<BulkEmailDataTable> createState() => _BulkEmailDataTableState();
}

class _BulkEmailDataTableState extends ConsumerState<BulkEmailDataTable> {
  bool isLoaded = false;
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  final bool _sortAscending = true;

  @override
  void initState() {
    getBulkEmails();
    super.initState();
  }

  List<EmailModel> bulkEmails = [];
  getBulkEmails() {
    setState(() {
      isLoaded = true;
    });
    FirebaseFirestore.instance
        .collection('Bulk Email')
        .snapshots()
        .listen((event) {
      setState(() {
        isLoaded = false;
      });
      bulkEmails.clear();
      for (var element in event.docs) {
        var bulks = EmailModel.fromMap(element, element.id);
        setState(() {
          bulkEmails.add(bulks);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool themeListener = ref.watch(themeListenerProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoaded == true
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                shrinkWrap: true,
                children: [
                  PaginatedDataTable(
                    header: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Bulk Email',
                                style: TextStyle(fontWeight: FontWeight.bold))
                            .tr(),
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
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Send bulk email',
                                              style: TextStyle(fontSize: 15.sp),
                                            ).tr(),
                                            InkWell(
                                                onTap: () {
                                                  context.pop();
                                                },
                                                child: const Icon(Icons.close))
                                          ],
                                        ),
                                        content: const SizedBox(
                                          height: 500,
                                          width: 400,
                                          child: BulkEMailForm(),
                                        ),
                                      );
                                    });
                              },
                              child: const Text('Send bulk email',
                                      style: TextStyle(color: Colors.white))
                                  .tr())
                      ],
                    ),
                    rowsPerPage: _rowsPerPage,
                    onRowsPerPageChanged: (int? value) {
                      setState(() {
                        _rowsPerPage = value!;
                      });
                    },
                    source:
                        VendorDataSource(bulkEmails, context, themeListener),
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    columns: <DataColumn>[
                      DataColumn(
                        label: const Text('Index',
                                style: TextStyle(fontWeight: FontWeight.bold))
                            .tr(),
                      ),
                      DataColumn(
                        label: const Text('Title',
                                style: TextStyle(fontWeight: FontWeight.bold))
                            .tr(),
                      ),
                      DataColumn(
                        label: const Text('Message',
                                style: TextStyle(fontWeight: FontWeight.bold))
                            .tr(),
                      ),
                      DataColumn(
                        label: const Text('Time Created',
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
              ));
  }
}

int numberOfdelivery = 0;

List<int> categoriesAmount = [];

class VendorDataSource extends DataTableSource {
  final List<EmailModel> vendor;
  VendorDataSource(this.vendor, this.context, this.themeListener);
  final BuildContext context;
  final int _selectedCount = 0;
  final bool themeListener;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= vendor.length) return null;
    final EmailModel result = vendor[index];
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
          DataCell(Text(result.message)),
          DataCell(Text(result.timeCreated)),
          DataCell(ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Bulk Email')
                    .doc(result.uid)
                    .delete();
              },
              child: const Text(
                'Delete Email',
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

