import 'package:admin/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../models/currency_formatter.dart';
import '../providers/home_main_provider.dart';

class OrdersDatatable extends ConsumerWidget {
  final String getcurrencySymbol;

  const OrdersDatatable({
    super.key,
    required this.getcurrencySymbol,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsyncValue = ref.watch(ordersDatatableProvider);
    bool themeListener = ref.watch(themeListenerProvider);
    return ordersAsyncValue.when(
      data: (orders) {
        return SingleChildScrollView(
          scrollDirection: MediaQuery.of(context).size.width >= 1100
              ? Axis.vertical
              : Axis.horizontal,
          child: DataTable(
            dividerThickness: 2,
            columns: <DataColumn>[
              DataColumn(
                label: const Text('Order ID',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    .tr(),
              ),
              DataColumn(
                label: const Text('Amount',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    .tr(),
              ),
              DataColumn(
                label: const Text('Order time',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    .tr(),
              ),
              DataColumn(
                label: const Text('Status',
                        style: TextStyle(fontWeight: FontWeight.bold))
                    .tr(),
              ),
            ],
            rows: orders.asMap().entries.map((entry) {
              int index = entry.key;
              var e = entry.value;

              return DataRow(
                color: WidgetStateColor.resolveWith((states) {
                  // Alternate row colors based on index
                  return themeListener == false
                      ? Colors.transparent
                      : index.isEven
                          ? Colors.grey.shade200
                          : Colors.white;
                }),
                cells: [
                  DataCell(Text('#${e.orderID.toString()}',
                      style: const TextStyle())),
                  DataCell(Text(
                      '$getcurrencySymbol${CurrencyFormatter().converter(e.total.toDouble())}',
                      style: const TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(
                      Text(e.timeCreated.toString(), style: const TextStyle())),
                  DataCell(Center(
                      child: e.status == "Pending"
                          ? Row(
                              children: [
                                RippleAnimation(
                                  color: Colors.green,
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
                                        color: Colors.green,
                                        shape: BoxShape.circle),
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
                          : e.status == "Confirmed"
                              ? Row(
                                  children: [
                                    RippleAnimation(
                                      color: Colors.green,
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
                                            color: Colors.blue,
                                            shape: BoxShape.circle),
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
                              : e.status == "Processing"
                                  ? Row(
                                      children: [
                                        RippleAnimation(
                                          color: Colors.yellow,
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
                                                color: Colors.yellow,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Gap(5),
                                        const Text('Processing',
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontWeight:
                                                        FontWeight.bold))
                                            .tr(),
                                      ],
                                    )
                                  : e.status == "Pickup"
                                      ? Row(
                                          children: [
                                            RippleAnimation(
                                              color: Colors.purple,
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
                                                    color: Colors.purple,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                            const Gap(5),
                                            const Text('Pickup',
                                                    style: TextStyle(
                                                        color: Colors.purple,
                                                        fontWeight:
                                                            FontWeight.bold))
                                                .tr(),
                                          ],
                                        )
                                      : e.status == "On the way"
                                          ? Row(
                                              children: [
                                                RippleAnimation(
                                                  color: Colors.deepOrange,
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
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .deepOrange,
                                                            shape: BoxShape
                                                                .circle),
                                                  ),
                                                ),
                                                const Gap(5),
                                                const Text('On the way',
                                                        style: TextStyle(
                                                            color: Colors.deepOrange,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                    .tr(),
                                              ],
                                            )
                                          : e.status == "Delivered"
                                              ? Row(
                                                  children: [
                                                    RippleAnimation(
                                                      color:
                                                          Colors.blue.shade800,
                                                      delay: const Duration(
                                                          milliseconds: 300),
                                                      repeat: true,
                                                      minRadius: 10,
                                                      ripplesCount: 4,
                                                      duration: const Duration(
                                                          milliseconds:
                                                              6 * 300),
                                                      child: Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .blue
                                                                    .shade800,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                    const Gap(5),
                                                     Text('Delivered',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue.shade800,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
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
                                                          milliseconds:
                                                              6 * 300),
                                                      child: Container(
                                                        height: 10,
                                                        width: 10,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                    const Gap(5),
                                                    const Text('Cancelled',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold))
                                                        .tr(),
                                                  ],
                                                ))),
                ],
              );
            }).toList(),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        var logger = Logger();
        logger.e(error);
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
