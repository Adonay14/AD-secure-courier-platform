import 'package:admin/providers/currency_provider.dart';
import 'package:admin/providers/dashboard_provider.dart';
import 'package:admin/providers/order_detail_provider.dart';
import 'package:admin/widget/top_customers.dart';
import 'package:admin/widget/top_vendors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:admin/Widget/orders_datatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shimmer/shimmer.dart';
import '../models/currency_formatter.dart';
import '../Widget/chart.dart';
import '../widget/order_status_dashboard.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    // final ordersListFromOrder =
    //     ref.watch(ordersListFromOrdersProvider).valueOrNull ?? [];
    // logger.d(ordersListFromOrder);
    final allOrdersFunc = ref.watch(allOrdersFuncProvider).valueOrNull ?? 0;
    // final fetchOrders = ref.watch(fetchOrdersProvider).valueOrNull ?? 0;
    // final getNumberofProducts =
    //     ref.watch(getNumberofProductsProvider).valueOrNull ?? 0;
    final getNumberofVendors =
        ref.watch(getNumberofVendorsProvider).valueOrNull ?? 0;
    final fetchOrdersDelivered =
        ref.watch(fetchOrdersDeliveredProvider).valueOrNull ?? 0;
    final fetchOrdersPending =
        ref.watch(fetchOrdersPendingProvider).valueOrNull ?? 0;
    final fetchOrdersConfirm =
        ref.watch(fetchOrdersConfirmProvider).valueOrNull ?? 0;
    final fetchOrdersCancelled =
        ref.watch(fetchOrdersCancelledProvider).valueOrNull ?? 0;
    final fetchOrdersOntheway =
        ref.watch(fetchOrdersOnthewayProvider).valueOrNull ?? 0;
    final fetchOrdersProcessing =
        ref.watch(fetchOrdersProcessingProvider).valueOrNull ?? 0;
    final fetchOrdersPickup =
        ref.watch(fetchOrdersPickupProvider).valueOrNull ?? 0;
    final getTotalSales = ref.watch(getTotalSalesProvider).valueOrNull ?? 0;
    final currencySymbol = ref.watch(currencySymbolProvider).valueOrNull ?? '';
    final getNumberofUsers =
        ref.watch(getNumberofUsersProvider).valueOrNull ?? 0;
    final getOrdersByMondayToday =
        ref.watch(getOrdersByMondayTodayProvider).valueOrNull ?? 0;
    final getOrdersByTuesdayToday =
        ref.watch(getOrdersByTuesdayTodayProvider).valueOrNull ?? 0;
    final getOrdersByWednessdayToday =
        ref.watch(getOrdersByWednessdayTodayProvider).valueOrNull ?? 0;
    final getOrdersByThursdayToday =
        ref.watch(getOrdersByThursdayTodayProvider).valueOrNull ?? 0;
    final getOrdersByFridayToday =
        ref.watch(getOrdersByFridayTodayProvider).valueOrNull ?? 0;
    final getOrdersBySaturdayToday =
        ref.watch(getOrdersBySaturdayTodayProvider).valueOrNull ?? 0;
    final getOrdersBySundayToday =
        ref.watch(getOrdersBySundayTodayProvider).valueOrNull ?? 0;
    final getOrdersByMonday = ref.watch(getOrdersByMondayProvider);
    final getOrdersByTuesday =
        ref.watch(getOrdersByTuesdayProvider).valueOrNull ?? 0;
    final getOrdersByWednessday =
        ref.watch(getOrdersByWednessdayProvider).valueOrNull ?? 0;
    final getOrdersByThursday =
        ref.watch(getOrdersByThursdayProvider).valueOrNull ?? 0;
    final getOrdersByFriday =
        ref.watch(getOrdersByFridayProvider).valueOrNull ?? 0;
    final getOrdersBySaturday =
        ref.watch(getOrdersBySaturdayProvider).valueOrNull ?? 0;
    final getOrdersBySunday =
        ref.watch(getOrdersBySundayProvider).valueOrNull ?? 0;
    var commission = ref.watch(getAdminCommissionProvider).value;
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ).tr(),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: MediaQuery.of(context).size.width >= 1100
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.orange,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          Icons.monetization_on,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Transactions',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ).tr(),
                                            Text(
                                              '$currencySymbol${CurrencyFormatter().converter(getTotalSales.toDouble())}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.blue,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Orders',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ).tr(),
                                            Text(
                                              '$allOrdersFunc',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.blue.shade900,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          Icons.people_alt,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Riders',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ).tr(),
                                            Text(
                                              '$getNumberofVendors',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const Gap(20),
                            Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.amberAccent,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          Icons.people,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Users',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ).tr(),
                                            Text(
                                              '${CurrencyFormatter().converter(getNumberofUsers.toDouble())}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            // // const Gap(20),
                            // Flexible(
                            //   flex: 5,
                            //   child: SizedBox(
                            //     height: 100,
                            //     child: Card(
                            //       elevation: 0,
                            //       color: Colors.blueAccent,
                            //       child: Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.start,
                            //           children: [
                            //             const Gap(10),
                            //             const Icon(
                            //               Icons.shopping_bag,
                            //               color: Colors.white,
                            //               size: 50,
                            //             ),
                            //             const Gap(10),
                            //             Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.center,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 const Text(
                            //                   'Total Products',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 12),
                            //                 ).tr(),
                            //                 Text(
                            //                   getNumberofProducts.toString(),
                            //                   style: const TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 15,
                            //                       fontWeight: FontWeight.bold),
                            //                 )
                            //               ],
                            //             )
                            //           ]),
                            //     ),
                            //   ),
                            // ),
                            // const Gap(20),
                            Flexible(
                              flex: 5,
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.blue.shade800,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        const Icon(
                                          Icons.money,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                        const Gap(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Commission',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ).tr(),
                                            Text(
                                              commission == null
                                                  ? '0'
                                                  : '$currencySymbol${double.parse(commission.toStringAsFixed(2))}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const Gap(20),
                            const Flexible(flex: 5, child: SizedBox()),
                            const Gap(20),
                            const Flexible(flex: 5, child: SizedBox()),
                            const Gap(20),
                            const Flexible(flex: 5, child: SizedBox())
                          ],
                        ),
                      ],
                    )
                  : GridView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 2,
                              crossAxisCount: 2),
                      children: [
                        SizedBox(
                          child: Card(
                            elevation: 0,
                            color: Colors.orange,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Icon(
                                    Icons.monetization_on,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Transactions',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ).tr(),
                                      Text(
                                        '$currencySymbol${CurrencyFormatter().converter(getTotalSales.toDouble())}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          child: Card(
                            elevation: 0,
                            color: Colors.blue,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Orders',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ).tr(),
                                      Text(
                                        '$allOrdersFunc',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          child: Card(
                            elevation: 0,
                            color: Colors.blue.shade900,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Icon(
                                    Icons.people,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Riders',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ).tr(),
                                      Text(
                                        '$getNumberofVendors',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          child: Card(
                            elevation: 0,
                            color: Colors.amberAccent,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Icon(
                                    Icons.people,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Users',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ).tr(),
                                      Text(
                                        '${CurrencyFormatter().converter(getNumberofUsers.toDouble())}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                        // SizedBox(
                        //   child: Card(
                        //     elevation: 0,
                        //     color: Colors.blueAccent,
                        //     child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         children: [
                        //           const Gap(10),
                        //           const Icon(
                        //             Icons.shopping_bag,
                        //             color: Colors.white,
                        //             size: 50,
                        //           ),
                        //           const Gap(10),
                        //           Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               const Text(
                        //                 'Total Products',
                        //                 style: TextStyle(
                        //                     color: Colors.white, fontSize: 12),
                        //               ).tr(),
                        //               Text(
                        //                 getNumberofProducts.toString(),
                        //                 style: const TextStyle(
                        //                     color: Colors.white,
                        //                     fontSize: 15,
                        //                     fontWeight: FontWeight.bold),
                        //               )
                        //             ],
                        //           )
                        //         ]),
                        //   ),
                        // ),
                        SizedBox(
                          child: Card(
                            elevation: 0,
                            color: Colors.blue.shade800,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  const Icon(
                                    Icons.money,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  const Gap(10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Commission',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ).tr(),
                                      Text(
                                        '$currencySymbol$commission',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      ],
                    )),
          const SizedBox(height: 20),
          // Start
          MediaQuery.of(context).size.width >= 1100
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 5,
                        child: SizedBox(
                          // height: MediaQuery.of(context).size.height / 1.5,
                          // width: MediaQuery.of(context).size.width / 2.3,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            elevation: 5,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Gap(20),
                                    const Text(
                                      'Weekly report',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: Color.fromARGB(255, 231, 225, 225),
                                ),
                                getOrdersByMonday.when(data: (v) {
                                  return BarChartSample2(
                                    monday: v,
                                    tuesday: getOrdersByTuesday,
                                    wednessday: getOrdersByWednessday,
                                    thursday: getOrdersByThursday,
                                    friday: getOrdersByFriday,
                                    saturday: getOrdersBySaturday,
                                    sunday: getOrdersBySunday,
                                    mondayToday: getOrdersByMondayToday,
                                    tuesdayToday: getOrdersByTuesdayToday,
                                    wednessdayToday: getOrdersByWednessdayToday,
                                    thursdayToday: getOrdersByThursdayToday,
                                    fridayToday: getOrdersByFridayToday,
                                    saturdayToday: getOrdersBySaturdayToday,
                                    sundayToday: getOrdersBySundayToday,
                                  );
                                }, error: (e, r) {
                                  return Text(e.toString());
                                }, loading: () {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: double
                                            .infinity, // Set the width as needed
                                        height:
                                            400.0, // Set the height as needed
                                        color: Colors
                                            .grey, // Set the color as needed
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(10),
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          // height: MediaQuery.of(context).size.height / 1.5,
                          // width: MediaQuery.of(context).size.width / 2,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            elevation: 5,
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Gap(20),
                                    const Text(
                                      'Order summary',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ).tr(),
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                  color: Color.fromARGB(255, 231, 225, 225),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  // height:
                                  //     MediaQuery.of(context).size.height / 2,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: PieChart(
                                    dataMap: {
                                      'Pending'.tr():
                                          fetchOrdersPending.toDouble(),
                                      'Confirm'.tr():
                                          fetchOrdersConfirm.toDouble(),
                                      'Processing'.tr():
                                          fetchOrdersProcessing.toDouble(),
                                      'Pickup'.tr():
                                          fetchOrdersPickup.toDouble(),
                                      'On the way'.tr():
                                          fetchOrdersOntheway.toDouble(),
                                      'Delivered'.tr():
                                          fetchOrdersDelivered.toDouble(),
                                      'Cancelled'.tr():
                                          fetchOrdersCancelled.toDouble(),
                                    },
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 1.7,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.disc,
                                    ringStrokeWidth: 32,
                                    centerText:
                                        ('Order Statistics'.tr()).toString(),
                                    legendOptions: const LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: true,
                                      legendShape: BoxShape.circle,
                                      legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions:
                                        const ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        // height: 400,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                          color: Theme.of(context).cardColor,
                          elevation: 5,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Gap(20),
                                  const Text(
                                    'Weekly report',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ).tr(),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                                color: Color.fromARGB(255, 231, 225, 225),
                              ),
                              getOrdersByMonday.when(data: (v) {
                                return BarChartSample2(
                                  monday: v,
                                  tuesday: getOrdersByTuesday,
                                  wednessday: getOrdersByWednessday,
                                  thursday: getOrdersByThursday,
                                  friday: getOrdersByFriday,
                                  saturday: getOrdersBySaturday,
                                  sunday: getOrdersBySunday,
                                  mondayToday: getOrdersByMondayToday,
                                  tuesdayToday: getOrdersByTuesdayToday,
                                  wednessdayToday: getOrdersByWednessdayToday,
                                  thursdayToday: getOrdersByThursdayToday,
                                  fridayToday: getOrdersByFridayToday,
                                  saturdayToday: getOrdersBySaturdayToday,
                                  sundayToday: getOrdersBySundayToday,
                                );
                              }, error: (e, r) {
                                return Text(e.toString());
                              }, loading: () {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: double
                                          .infinity, // Set the width as needed
                                      height: 400.0, // Set the height as needed
                                      color: Colors
                                          .grey, // Set the color as needed
                                    ),
                                  ),
                                );
                              })
                            ],
                          ),
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        // height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                          color: Theme.of(context).cardColor,
                          elevation: 5,
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Gap(20),
                                  const Text('Order summary,',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                      .tr(),
                                ],
                              ),
                              const Divider(
                                thickness: 2,
                                color: Color.fromARGB(255, 231, 225, 225),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: PieChart(
                                  dataMap: {
                                    'Pending'.tr():
                                        fetchOrdersPending.toDouble(),
                                    'Confirm'.tr():
                                        fetchOrdersConfirm.toDouble(),
                                    'Processing'.tr():
                                        fetchOrdersProcessing.toDouble(),
                                    'Pickup'.tr(): fetchOrdersPickup.toDouble(),
                                    'On the way'.tr():
                                        fetchOrdersOntheway.toDouble(),
                                    'Delivered'.tr():
                                        fetchOrdersDelivered.toDouble(),
                                    'Cancelled'.tr():
                                        fetchOrdersCancelled.toDouble(),
                                  },
                                  animationDuration:
                                      const Duration(milliseconds: 800),
                                  chartLegendSpacing: 32,
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 1.7,
                                  colorList: colorList,
                                  initialAngleInDegree: 0,
                                  chartType: ChartType.disc,
                                  ringStrokeWidth: 32,
                                  centerText:
                                      ('Order Statistics'.tr()).toString(),
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: false,
                                    legendPosition: LegendPosition.right,
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: false,
                                    showChartValuesOutside: false,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
          // const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              // color: Theme.of(context).cardColor,
              elevation: 5,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Gap(20),
                      const Text(
                        'New Orders',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).tr(),
                    ],
                  ),
                  const Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 231, 225, 225),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: OrdersDatatable(
                                  getcurrencySymbol: currencySymbol)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          const Gap(20),
          if (MediaQuery.of(context).size.width >= 1100)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(flex: 5, child: TopCustomers()),
                  Gap(50),
                  Flexible(flex: 5, child: OrderStatusDashboard()),
                ],
              ),
            ),

          if (MediaQuery.of(context).size.width <= 1100)
            const SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TopCustomers(),
            )),
          if (MediaQuery.of(context).size.width <= 1100)
            const SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: OrderStatusDashboard(),
            )),
          const SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: TopVendors(),
          )),
          const Gap(50),
        ],
      ),
    );
  }
}
