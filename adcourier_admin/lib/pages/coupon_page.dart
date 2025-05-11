import 'package:admin/constance.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../Widget/coupon_datatable.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MediaQuery.of(context).size.width >= 1100
          ? null
          : FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Generate Coupon',
                              style: TextStyle(fontSize: 15.sp),
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
              child: const Icon(
                Icons.add,
                color: Colors.white,
              )),
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: CouponData(),
            ),
          ],
        ),
      ),
    );
  }
}
