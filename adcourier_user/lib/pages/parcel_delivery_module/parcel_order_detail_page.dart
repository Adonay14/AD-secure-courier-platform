import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:user_web/widgets/footer_widget.dart';
import 'package:user_web/widgets/web_menu.dart';

import '../../widgets/parcel_delivery_module_widget/parcel_order_detail_widget.dart';

class ParcelOrderDetail extends StatefulWidget {
  final String uid;
  const ParcelOrderDetail({super.key, required this.uid});

  @override
  State<ParcelOrderDetail> createState() => _ParcelOrderDetailState();
}

class _ParcelOrderDetailState extends State<ParcelOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MediaQuery.of(context).size.width >= 1100
      //     ? null
      //     : AppBar(
      //         leading: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: InkWell(
      //               hoverColor: Colors.transparent,
      //               onTap: () {
      //                 context.go('/orders');
      //               },
      //               child: Icon(Icons.arrow_back)),
      //         ),
      //         centerTitle: true,
      //         automaticallyImplyLeading: true,
      //         title: Text('Order Detail').tr(),
      //       ),
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: MediaQuery.of(context).size.width >= 1100
                  ? const EdgeInsets.only(left: 60, right: 50)
                  : const EdgeInsets.all(0),
              child: Column(
                children: [
                  if (MediaQuery.of(context).size.width >= 1100) const Gap(20),
                  if (MediaQuery.of(context).size.width >= 1100)
                    Align(
                      alignment: MediaQuery.of(context).size.width >= 1100
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              context.go('/parcel-delivery');
                            },
                            child: const Text(
                              'Home',
                              style: TextStyle(fontSize: 10),
                            ).tr(),
                          ),
                          const Text(
                            '/ My Orders',
                            style: TextStyle(fontSize: 10),
                          ).tr(),
                        ],
                      ),
                    ),
                  // Align(
                  //   alignment: MediaQuery.of(context).size.width >= 1100
                  //       ? Alignment.centerLeft
                  //       : Alignment.center,
                  //   child: const Text(
                  //     'Orders',
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  //   ).tr(),
                  // ),
                  const Gap(20),
                ],
              ),
            ),
            MediaQuery.of(context).size.width >= 1100
                ? Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                              shape: const BeveledRectangleBorder(),
                              color:
                                  AdaptiveTheme.of(context).mode.isDark == true
                                      ? Colors.black87
                                      : Colors.white,
                              surfaceTintColor: Colors.white,
                              child: const WebMenu(path: '/orders')),
                        ),
                        const Gap(20),
                        Expanded(
                            flex: 6,
                            child: Card(
                              shape: const BeveledRectangleBorder(),
                              color:
                                  AdaptiveTheme.of(context).mode.isDark == true
                                      ? Colors.black87
                                      : Colors.white,
                              surfaceTintColor: Colors.white,
                              child: SingleChildScrollView(
                                child: ParcelOrderDetailWidget(
                                  uid: widget.uid,
                                ),
                              ),
                            ))
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ParcelOrderDetailWidget(
                      uid: widget.uid,
                    ),
                  ),
            const Gap(20),
            const FooterWidget()
          ],
        ),
      ),
    );
  }
}
