import 'package:admin/constance.dart';
import 'package:admin/widget/sms%20management/add_sms.dart';
import 'package:admin/widget/sms%20management/bulk_sms_datatable.dart';
import 'package:flutter/material.dart';

class BulkSmsPage extends StatefulWidget {
  const BulkSmsPage({super.key});

  @override
  State<BulkSmsPage> createState() => _BulkSmsPageState();
}

class _BulkSmsPageState extends State<BulkSmsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  floatingActionButtonLocation:MediaQuery.of(context).size.width >= 1100? FloatingActionButtonLocation.endTop:FloatingActionButtonLocation.endDocked,
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
                        return const AddSms();
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
              child: BulkSmsDatatable(),
            ),
          ],
        ),
      ),
    );
  }
}
