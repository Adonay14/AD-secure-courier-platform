// ignore_for_file: avoid_print
import 'package:admin/constance.dart';
import 'package:admin/widget/email%20management/send_bulk_email.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import '../../widget/email management/bulk_email.dart';

class BulkEmailPage extends StatefulWidget {
  const BulkEmailPage({super.key});

  @override
  State<BulkEmailPage> createState() => _BulkEmailPageState();
}

class _BulkEmailPageState extends State<BulkEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MediaQuery.of(context).size.width >= 1100
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: buttonColor,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            content: const BulkEMailForm());
                      });
                },
                child: const Icon(Icons.add),
              ),
            ),
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: BulkEmailDataTable(),
            ),
          ],
        ),
      ),
    );
  }
}
