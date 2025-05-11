import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/user.dart';

class PdfGenerator extends StatefulWidget {
  final String collection;
  const PdfGenerator({super.key, required this.collection});

  @override
  State<PdfGenerator> createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
  List<UserModel> users = [];
  final databaseReference = FirebaseFirestore.instance;

  Future<List<UserModel>> fetchAllUsers() async {
    return FirebaseFirestore.instance
        .collection(widget.collection)
        .get()
        .then((event) {
      return event.docs.map((e) {
        setState(() {
          users.add(UserModel.fromMap(e.data(), e.id));
        });
        return UserModel.fromMap(e.data(), e.id);
      }).toList();
    });
  }

  @override
  void initState() {
    fetchAllUsers();
    getPhoneDetails();
    getAddressDetails();
    getBusinessDetails();
    getEmailDetails();
    getCurrencyDetails();
    super.initState();
  }

  String getcurrencySymbol = '';
  String businessName = '';
  String email = '';
  String address = '';
  String phone = '';

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
        widget.collection,
        users,
        context,
        businessName,
        email,
        address,
        phone,
        getcurrencySymbol,
      );

      // Generate a filename with timestamp
      final fileName =
          'Users_Report_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // Share or download the PDF
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
      // Show error message if something goes wrong
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
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: ElevatedButton(
                onPressed: _downloadPdf,
                child: const Text('Download Users Report'),
              ),
            ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format,
      String title,
      List<UserModel> users,
      BuildContext context,
      String business,
      String email,
      String address,
      String phone,
      String getcurrencySymbol) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final ByteData bytes =
        await rootBundle.load(logo); // Update with your image path
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
                  color: PdfColors.grey300, // Grey background color
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Company Logo Placeholder
                    pw.Image(logonn, height: 100, width: 120),
                    // Company Details
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
              pw.Text(title == 'users' ? 'Users Report' : 'Drivers Report',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Index      ', 'Name', 'Address', 'Wallet Balance'],
                data: List<List<dynamic>>.generate(users.length, (index) {
                  UserModel userModel = users[index];
                  return <dynamic>[
                    1 + index,
                    userModel.displayName,
                    userModel.address,
                    '$getcurrencySymbol${CurrencyFormatter().converter(userModel.wallet!.toDouble())}'
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
          }),
    );

    return pdf.save();
  }
}
