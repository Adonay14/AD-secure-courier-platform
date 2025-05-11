import 'package:admin/constance.dart';
import 'package:flutter/material.dart';

import '../pdf_generator.dart';

class RidersReportWidget extends StatefulWidget {
  const RidersReportWidget({super.key});

  @override
  State<RidersReportWidget> createState() => _RidersReportWidgetState();
}

class _RidersReportWidgetState extends State<RidersReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0),
              backgroundColor: WidgetStateProperty.all<Color>(
                buttonColor,
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Dialog(
                      child: PdfGenerator(
                        collection: 'drivers',
                      ),
                    );
                  });
            },
            child: const Text('Download Riders Report'))
      ],
    );
  }
}
