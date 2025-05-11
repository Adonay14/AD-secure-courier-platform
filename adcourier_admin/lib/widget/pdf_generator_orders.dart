// ignore_for_file: avoid_print

import 'dart:async';
import 'package:admin/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/order_model.dart';

class PdfGeneratorOrders extends StatefulWidget {
  const PdfGeneratorOrders({
    super.key,
  });

  @override
  State<PdfGeneratorOrders> createState() => _PdfGeneratorOrdersState();
}

class _PdfGeneratorOrdersState extends State<PdfGeneratorOrders> {
  DocumentReference? userRef;
  String userID = '';
  List<OrderModel2> orders = [];
  String getcurrencySymbol = '';
  String businessName = '';
  String email = '';
  String address = '';
  String phone = '';

  @override
  initState() {
    super.initState();
    getCurrencyDetails();
    getPhoneDetails();
    getAddressDetails();
    getBusinessDetails();
    getEmailDetails();
    fetchOrders();
  }

  Future<StreamSubscription<QuerySnapshot<Map<String, dynamic>>>>
      fetchOrders() async {
    return FirebaseFirestore.instance
        .collection('Orders')
        .snapshots()
        .listen((data) {
      orders.clear();
      for (var doc in data.docs) {
        if (mounted) {
          setState(() {
            orders.add(OrderModel2(
              scheduleDate: doc.data()['scheduleDate'],
              scheduleTime: doc.data()['scheduleTime'],
              vendorId: doc.data()['vendorId'],
              senderName: doc.data()['senderName'],
              receiverName: doc.data()['receiverName'],
              parcelCategory: doc.data()['parcelCategory'],
              senderEmail: doc.data()['senderEmail'],
              senderPhone: doc.data()['senderPhone'],
              senderAddress: doc.data()['senderAddress'],
              senderHouseNumber: doc.data()['senderHouseNumber'],
              senderStreetNumber: doc.data()['senderStreetNumber'],
              senderFloorNumber: doc.data()['senderFloorNumber'],
              receiverPhone: doc.data()['receiverPhone'],
              receiverEmail: doc.data()['receiverEmail'],
              receiverAddress: doc.data()['receiverAddress'],
              receiverHouseNumber: doc.data()['receiverHouseNumber'],
              receiverStreetNumber: doc.data()['receiverStreetNumber'],
              receiverFloorNumber: doc.data()['receiverFloorNumber'],
              parcelAdminCommission: doc.data()['parcelAdminCommission'],
              parcelPayer: doc.data()['parcelPayer'],
              prescription: doc.data()['prescription'],
              prescriptionPic: doc.data()['prescriptionPic'],
              module: doc.data()['module'],
              orders: [
                ...(doc.data()['orders']).map((items) {
                  return OrdersList.fromMap(items);
                })
              ],
              pickupStorename: doc.data()['pickupStorename'],
              pickupPhone: doc.data()['pickupPhone'],
              pickupAddress: doc.data()['pickupAddress'],
              instruction: doc.data()['instruction'],
              couponPercentage: doc.data()['couponPercentage'],
              couponTitle: doc.data()['couponTitle'],
              useCoupon: doc.data()['useCoupon'],
              confirmationStatus: doc.data()['confirmationStatus'],
              uid: doc.data()['uid'],
              // marketID: doc.data()['marketID'],
              vendorIDs: [
                ...(doc.data()['vendorIDs']).map((items) {
                  return items;
                })
              ],
              userID: doc.data()['userID'],
              deliveryAddress: doc.data()['deliveryAddress'],
              houseNumber: doc.data()['houseNumber'],
              closesBusStop: doc.data()['closesBusStop'],
              deliveryBoyID: doc.data()['deliveryBoyID'],
              status: doc.data()['status'],
              accept: doc.data()['accept'],
              orderID: doc.data()['orderID'],
              timeCreated: doc.data()['timeCreated'].toDate(),
              total: doc.data()['total'],
              deliveryFee: doc.data()['deliveryFee'],
              acceptDelivery: doc.data()['acceptDelivery'],
              paymentType: doc.data()['paymentType'],
            ));
          });
        }
      }
    });
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

  Future<void> _downloadPdf() async {
    try {
      final bytes = await _generatePdf(
        PdfPageFormat.a4,
        'Orders Report',
        orders,
        context,
        getcurrencySymbol,
        businessName,
        email,
        address,
        phone,
      );

      // Generate filename with timestamp
      final fileName =
          'Orders_Report_${DateTime.now().millisecondsSinceEpoch}.pdf';

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
    }
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
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close)),
          )
        ],
      ),
      body: orders.isEmpty && getcurrencySymbol.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                onPressed: _downloadPdf,
                child: const Text('Download Orders Report'),
              ),
            ),
    );
  }

  Future<Uint8List> _generatePdf(
    PdfPageFormat format,
    String title,
    List<OrderModel2> users,
    BuildContext context,
    String currencySymbol,
    String business,
    String email,
    String address,
    String phone,
  ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
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
            pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.TableHelper.fromTextArray(
              headers: ['Index      ', 'Order ID', 'Status', 'Total'],
              data: List<List<dynamic>>.generate(users.length, (index) {
                OrderModel2 userModel = users[index];
                return <dynamic>[
                  1 + index,
                  '#${userModel.orderID}',
                  userModel.status,
                  '\$${userModel.total}'
                ];
              }),
              headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColors.grey,
              ),
              rowDecoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColors.grey,
                    width: .5,
                  ),
                ),
              ),
              cellAlignment: pw.Alignment.topLeft,
              cellAlignments: {0: pw.Alignment.topLeft},
            )
          ];
        },
      ),
    );

    return pdf.save();
  }
}
