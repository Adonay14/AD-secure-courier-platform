import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'all_orders.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});
  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
          centerTitle: true,
          title: Row(
            children: [
              Text(
                'Orders',
                style: TextStyle(
                    color: Theme.of(context).indicatorColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: 'All'.tr(),
              ),
              Tab(text: 'Pending'.tr()),
              Tab(text: 'Scheduled'.tr()),
              Tab(text: 'Confirmed'.tr()),
              Tab(text: 'Processing'.tr()),
              Tab(text: 'Pick up'.tr()),
              Tab(text: 'On the way'.tr()),
              Tab(text: 'Delivered'.tr()),
              Tab(text: 'Cancelled'.tr()),
              // Tab(text: 'Cancelled'.tr()),
            ],
            // unselectedLabelColor: Colors.black,
            // labelColor: Colors.black,
            // indicator: DotIndicator(
            //   // color: Colors.black,
            //   distanceFromCenter: 16,
            //   radius: 3,
            //   paintingStyle: PaintingStyle.fill,
            // ),
          ),
        ),
        body: const TabBarView(
          children: [
            AllOrders(
              status: 'All',
            ),
            AllOrders(
              status: 'Pending',
            ),
            AllOrders(
              status: 'Scheduled',
            ),
            AllOrders(
              status: 'Confirmed',
            ),
            AllOrders(
              status: 'Processing',
            ),
            AllOrders(
              status: 'Pickup',
            ),
            AllOrders(
              status: 'On the way',
            ),
            AllOrders(
              status: 'Delivered',
            ),
            AllOrders(
              status: 'Cancelled',
            ),
          ],
        ),
      ),
    );
  }
}
