import 'package:admin/constance.dart';
import 'package:admin/models/top_customers.dart';
import 'package:admin/providers/dashboard_provider.dart';
import 'package:admin/providers/home_main_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class TopVendors extends ConsumerStatefulWidget {
  const TopVendors({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TopVendorsState();
}

class _TopVendorsState extends ConsumerState<TopVendors> {
  @override
  Widget build(BuildContext context) {
    final prods = ref.watch(vendorOrdersCountProvider);
    bool themeListener = ref.watch(themeListenerProvider);
    return prods.when(
      data: (v) {
        if (v.length > 10) {
          v = v.sublist(0, 10); // Ensure only 10 items are shown
        }

        return Card(
          elevation: 5,
          child: Center(
            child: Column(
              children: [
                const Gap(20),
                const Text(
                  'Top Riders',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ).tr(),
                const Divider(
                  thickness: 2,
                  color: Color.fromARGB(255, 231, 225, 225),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    columns: [
                      DataColumn(
                          label: const Text(
                        'Image',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr()),
                      DataColumn(
                          label: const Text(
                        'Vendor Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr()),
                      DataColumn(
                          label: const Text(
                        'Orders',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr()),
                    ],
                    rows: v.asMap().entries.map((entry) {
                      int index = entry.key;
                      UserOrderCount productsModel = entry.value;

                      return DataRow(
                        color: WidgetStateColor.resolveWith((states) {
                          // Alternate row colors
                          return themeListener == false
                              ? Colors.transparent
                              : index.isEven
                                  ? Colors.grey.shade200
                                  : Colors.white;
                        }),
                        cells: [
                          DataCell(Icon(
                            Icons.person,
                            color: buttonColor,
                          )),
                          DataCell(Text(productsModel.userName)),
                          DataCell(Text(productsModel.orderCount.toString())),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, er) {
        return Text(error.toString());
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
