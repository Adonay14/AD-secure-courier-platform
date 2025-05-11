import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class LicenseAndDocumetPage extends StatefulWidget {
  const LicenseAndDocumetPage({super.key});

  @override
  State<LicenseAndDocumetPage> createState() => _LicenseAndDocumetPageState();
}

class _LicenseAndDocumetPageState extends State<LicenseAndDocumetPage> {
  String license = '';
  dynamic imageFile;

  Future<void> uploadImage(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'avif'],
    ).then((value) {
      return value;
    });

    if (result != null) {
      dynamic fileBytes = result.files.first.path;

      setState(() {
        imageFile = fileBytes;
      });
    }
  }

  postLicense() async {
    // Upload file
    TaskSnapshot upload = await FirebaseStorage.instance
        .ref('uploads/${DateTime.now()}')
        .putFile(File(imageFile!));
    String url = await upload.ref.getDownloadURL().then((value) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;
      FirebaseFirestore.instance
          .collection('riders')
          .doc(user!.uid)
          .update({'license': value});

      if (mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: "Image successfully uploded",
          duration: const Duration(seconds: 3),
        ).show(context);
      }

      return value;
    });

    setState(() {
      license = url;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('License / Document').tr(),
      ),
      body: license.isNotEmpty
          ? Center(child: Text("License is under review").tr())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        'Upload your license or document',
                        style: TextStyle(fontSize: 20),
                      ).tr(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    imageFile != null
                        ? Image.file(
                            File(imageFile),
                            height: 200,
                            width: 200,
                          )
                        : const Icon(
                            Icons.image,
                            size: 200,
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        uploadImage(context);
                      },
                      child: const Text('Pick License').tr(),
                    ),
                    if (imageFile != null)
                      const SizedBox(
                        height: 20,
                      ),
                    if (imageFile != null)
                      ElevatedButton(
                        onPressed: () {
                          postLicense();
                        },
                        child: const Text('Upload License').tr(),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
