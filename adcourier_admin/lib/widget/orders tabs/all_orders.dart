import 'package:admin/constance.dart';
import 'package:admin/providers/currency_provider.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:admin/providers/orders_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../models/currency_formatter.dart';
import '../../models/order_model.dart';
import '../order_detail_parcel_riverpod.dart';

class AllOrders extends ConsumerStatefulWidget {
  final String status;
  const AllOrders({super.key, required this.status});

  @override
  ConsumerState<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends ConsumerState<AllOrders> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;

  List<OrderModel2> ordersFilter = [];
  List<OrderModel2> ordersFilterByModule = [];
  String displayName = '';
  String module = 'All';
  void onSearchTextChanged(String text, List<OrderModel2> orders) {
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

  void onSearchByModule(String text, List<OrderModel2> orders) {
    setState(() {
      ordersFilterByModule =
          orders.where((user) => user.module == text).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(ordersStreamProvider(widget.status));
    final currencySymbol = ref.watch(currencySymbolProvider).valueOrNull ?? '';
    bool themeListener = ref.watch(themeListenerProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            orders.when(data: (v) {
              return v.isEmpty
                  ? Center(
                      child: Align(
                          alignment: Alignment.center,
                          child: const Text('No Order').tr()))
                  : PaginatedDataTable(
                      header: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width >= 1100
                                    ? MediaQuery.of(context).size.width / 2
                                    : MediaQuery.of(context).size.width / 1.5,
                                child: TextField(
                                    onChanged: (value) {
                                      onSearchTextChanged(value, v);
                                    },
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
                          ),
                        ],
                      ),
                      showCheckboxColumn: false,
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
                          displayName.isEmpty
                              ? module != 'All'
                                  ? ordersFilterByModule
                                  : v
                              : ordersFilter,
                          currencySymbol,
                          context,
                          themeListener));
            }, error: (e, err) {
              return Text(err.toString());
            }, loading: () {
              return const CircularProgressIndicator();
            })
          ],
        ),
      ),
    );
  }
}

class ResultsDataSource extends DataTableSource {
  final List<OrderModel2> orders;
  final String getcurrencySymbol;
  final BuildContext context;
  ResultsDataSource(
      this.orders, this.getcurrencySymbol, this.context, this.themeListener);
  final bool themeListener;
  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= orders.length) return null;
    final OrderModel2 result = orders[index];
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
                                  duration:
                                      const Duration(milliseconds: 6 * 300),
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
                                                color: Colors.deepOrange,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Gap(5),
                                        const Text('On the way',
                                                style: TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .tr(),
                                      ],
                                    )
                                  : result.status == "Delivered"
                                      ? Row(
                                          children: [
                                            RippleAnimation(
                                              color: Colors.blue.shade800,
                                              delay: const Duration(
                                                  milliseconds: 300),
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
                                                        color: Colors
                                                            .blue.shade800,
                                                        fontWeight:
                                                            FontWeight.bold))
                                                .tr(),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            RippleAnimation(
                                              color: Colors.red,
                                              delay: const Duration(
                                                  milliseconds: 300),
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
          DataCell(SizedBox(
              width: 100,
              child: Text(
                '${result.timeCreated}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ))),
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
                  child: Tooltip(
                    message: result.deliveryAddress,
                    child: Text(
                      result.deliveryAddress!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))),
          DataCell(ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all<Color>(
                  buttonColor,
                ),
              ),
              onPressed: () {
                if (MediaQuery.of(context).size.width >= 1100) {
                  // showDialog(
                  //     context: context,
                  //     builder: (builder) {
                  //       return AlertDialog(
                  //           content: SizedBox(
                  //               width: MediaQuery.of(context).size.width / 1.5,
                  //               child: OrderDetail(orderModel: result)));
                  //     });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OrderDetailParcelRiverpod(orderModel: result);
                  }));
                } else {
                  // showDialog(
                  //     context: context,
                  //     builder: (builder) {
                  //       return Material(child: OrderDetail(orderModel: result));
                  //     });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return OrderDetailParcelRiverpod(orderModel: result);
                  }));
                }
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
