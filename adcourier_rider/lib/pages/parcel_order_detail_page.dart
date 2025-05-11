import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/parcel_order_detail_widget.dart';

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
      //                 context.push('/orders');
      //               },
      //               child: Icon(Icons.arrow_back)),
      //         ),
      //         centerTitle: true,
      //         automaticallyImplyLeading: true,
      //         title: Text('Order Detail').tr(),
      //       ),
      appBar: AppBar(
        title: Text('Parcel Detail').tr(),
      ),
      backgroundColor: AdaptiveTheme.of(context).mode.isDark == true
          ? null
          : const Color.fromARGB(255, 247, 240, 240),
      body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ParcelOrderDetailWidget(
                uid: widget.uid,
              ),
            ),
    );
  }
}
