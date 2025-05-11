import 'package:admin/constance.dart';
import 'package:admin/widget/whatsapp%20management/add_whatsapp.dart';
import 'package:admin/widget/whatsapp%20management/bulk_whatsapp_datatable.dart';
import 'package:flutter/material.dart';


class BulkWhatsappPage extends StatefulWidget {
  const BulkWhatsappPage({super.key});

  @override
  State<BulkWhatsappPage> createState() => _BulkWhatsappPageState();
}

class _BulkWhatsappPageState extends State<BulkWhatsappPage> {
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
                        return const AddWhatsapp();
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
              child: BulkWhatsappDatatable(),
            ),
          ],
        ),
      ),
    );
  }
}
