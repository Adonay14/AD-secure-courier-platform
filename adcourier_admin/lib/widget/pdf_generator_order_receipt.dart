// ignore_for_file: avoid_print

import 'dart:async';
import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/order_model.dart';

class PdfGeneratorOrderReceipt extends StatefulWidget {
  final OrderModel2 orderModel2;
  final bool isPos;
  final String fullName;
  const PdfGeneratorOrderReceipt({
    super.key,
    required this.orderModel2,
    required this.fullName,
    required this.isPos,
  });

  @override
  State<PdfGeneratorOrderReceipt> createState() =>
      _PdfGeneratorOrderReceiptState();
}

class _PdfGeneratorOrderReceiptState extends State<PdfGeneratorOrderReceipt> {
  String userID = '';
  String getcurrencySymbol = '';
  String businessName = '';
  String email = '';
  String address = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    getCurrencyDetails();
    getPhoneDetails();
    getAddressDetails();
    getBusinessDetails();
    getEmailDetails();
  }

  getCurrencyDetails() {
    FirebaseFirestore.instance
        .collection('Currency Settings')
        .doc('Currency Settings')
        .get()
        .then((value) {
      setState(() {
        getcurrencySymbol = value['Currency symbol'];
      });
    });
  }

  getPhoneDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('phone')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          phone = value['phone'];
        });
      }
    });
  }

  getEmailDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('email')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          email = value['email'];
        });
      }
    });
  }

  getBusinessDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('business name')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          businessName = value['business name'];
        });
      }
    });
  }

  getAddressDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('address')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          address = value['address'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                color: Colors.black,
                onPressed: () {
                  if (widget.isPos == true) {
                    Navigator.pop(context, true);
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.close)),
          )
        ],
      ),
      body: businessName.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                onPressed: _isDownloading ? null : _downloadPdf,
                child: Text(_isDownloading
                    ? 'Downloading, please wait...'
                    : 'Download Receipt'),
              ),
            ),
    );
  }

  bool _isDownloading = false;

  Future<void> _downloadPdf() async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final bytes = await _generatePdf(
        PdfPageFormat.a4,
        'Order Receipt',
        widget.orderModel2,
        context,
        getcurrencySymbol,
        widget.fullName,
        businessName,
        email,
        address,
        phone,
      );

      // Generate filename using order ID and timestamp
      final fileName =
          'Order_${widget.orderModel2.orderID}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Download the PDF
      await Printing.sharePdf(bytes: bytes, filename: fileName);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF downloaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading PDF: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    String title,
    OrderModel2 users,
    BuildContext context,
    String currencySymbol,
    String fullname,
    String business,
    String email,
    String address,
    String phone,
  ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    // Load the image from assets
    final ByteData bytes = await rootBundle.load(logo);
    final Uint8List imageData = bytes.buffer.asUint8List();
    final logonn = pw.MemoryImage(imageData);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        build: (context) {
          return [
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey300,
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(logonn, height: 100, width: 120),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(business,
                          style: pw.TextStyle(
                              fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.Text(address),
                      pw.Text('Email: $email'),
                      pw.Text('Phone: $phone'),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            pw.SizedBox(height: 10),
            pw.Center(
              child: pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Order ID: ${users.orderID}',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(
                  'Date: ${users.timeCreated.toLocal()}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.Divider(),
            pw.Text("Customer's Name: $fullname",
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 5),
            if (users.deliveryAddress!.isEmpty)
              pw.Text("Pickup: ${users.pickupAddress}",
                  style: const pw.TextStyle(fontSize: 12)),
            if (users.deliveryAddress!.isNotEmpty)
              pw.Text("Delivery Address: ${users.deliveryAddress}",
                  style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 5),
            pw.Divider(),
            pw.TableHelper.fromTextArray(
              headers: [
                'No.',
                'Product',
                'Selected Product',
                'Quantity',
                'Price'
              ],
              headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey800,
              ),
              data: List<List<dynamic>>.generate(users.orders!.length, (index) {
                OrdersList userModel = users.orders![index];
                return <dynamic>[
                  1 + index,
                  (userModel.selectedExtra1!.isNotEmpty) ||
                          (userModel.selectedExtra2!.isNotEmpty) ||
                          (userModel.selectedExtra3!.isNotEmpty) ||
                          (userModel.selectedExtra4!.isNotEmpty) ||
                          (userModel.selectedExtra5!.isNotEmpty)
                      ? pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                              pw.Text(userModel.productName),
                              pw.Text('Extras:',
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              if (userModel.selectedExtra1!.isNotEmpty)
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(userModel.selectedExtra1!),
                                      pw.Text(
                                          '${userModel.quantity} x $currencySymbol${CurrencyFormatter().converter(userModel.selectedExtraPrice1!.toDouble())}'),
                                    ]),
                              if (userModel.selectedExtra2!.isNotEmpty)
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(userModel.selectedExtra2!),
                                      pw.Text(
                                          '${userModel.quantity} x $currencySymbol${CurrencyFormatter().converter(userModel.selectedExtraPrice2!.toDouble())}'),
                                    ]),
                              if (userModel.selectedExtra3!.isNotEmpty)
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(userModel.selectedExtra3!),
                                      pw.Text(
                                          '${userModel.quantity} x $currencySymbol${CurrencyFormatter().converter(userModel.selectedExtraPrice3!.toDouble())}'),
                                    ]),
                              if (userModel.selectedExtra4!.isNotEmpty)
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(userModel.selectedExtra4!),
                                      pw.Text(
                                          '${userModel.quantity} x $currencySymbol${CurrencyFormatter().converter(userModel.selectedExtraPrice4!.toDouble())}'),
                                    ]),
                              if (userModel.selectedExtra5!.isNotEmpty)
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(userModel.selectedExtra5!),
                                      pw.Text(
                                          '${userModel.quantity} x $currencySymbol${CurrencyFormatter().converter(userModel.selectedExtraPrice5!.toDouble())}'),
                                    ])
                            ])
                      : userModel.productName,
                  userModel.selected,
                  CurrencyFormatter().converter(userModel.quantity.toDouble()),
                  '$currencySymbol${CurrencyFormatter().converter(userModel.selectedPrice.toDouble())}',
                ];
              }),
              cellStyle: const pw.TextStyle(fontSize: 10),
              cellAlignment: pw.Alignment.centerLeft,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerLeft,
                3: pw.Alignment.center,
                4: pw.Alignment.centerRight,
              },
              rowDecoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColors.grey300,
                    width: .5,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 40),
            if (users.deliveryAddress!.isNotEmpty)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Delivery Fee:',
                      style: const pw.TextStyle(fontSize: 12)),
                  pw.Text(
                      '$currencySymbol${CurrencyFormatter().converter(users.deliveryFee!.toDouble())}',
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 14)),
                ],
              ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Payment Type: ${users.paymentType}',
                    style: const pw.TextStyle(fontSize: 12)),
                pw.Text(
                    'Total: $currencySymbol${CurrencyFormatter().converter(users.total.toDouble())}',
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 14)),
              ],
            ),
            pw.SizedBox(height: 40),
            pw.SizedBox(height: 40),
            pw.Text('Signature: ____________________________',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(height: 5),
            pw.Text('(Customer Signature)',
                style:
                    pw.TextStyle(fontSize: 10, fontStyle: pw.FontStyle.italic)),
          ];
        },
      ),
    );

    return pdf.save();
  }
}
