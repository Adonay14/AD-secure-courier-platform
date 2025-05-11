import 'package:flutter/material.dart';

class LicenseImage extends StatefulWidget {
  final String prescriptionPic;
  const LicenseImage({super.key, required this.prescriptionPic});

  @override
  State<LicenseImage> createState() => _LicenseImageState();
}

class _LicenseImageState extends State<LicenseImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('License / Document Picture'),
      ),
      body: Image.network(widget.prescriptionPic),
    );
  }
}
