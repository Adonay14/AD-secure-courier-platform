import 'dart:convert';

import 'package:admin/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    getAboutUsDetails();
    super.initState();
  }

  String aboutUs = '';
  final _formKey = GlobalKey<FormState>();
  String getAboutUs = '';
  final QuillController _controller = QuillController.basic();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getAboutUsDetails() {
    FirebaseFirestore.instance
        .collection('Terms & Conditions')
        .doc('Terms & Conditions')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getAboutUs = value['Terms & Conditions'];
        });
        _controller.document =
            Document.fromJson(jsonDecode(value['Terms & Conditions']));
      }
    });
  }

  updateAboutUsDetails() {
    FirebaseFirestore.instance
        .collection('Terms & Conditions')
        .doc('Terms & Conditions')
        .set({
      'Terms & Conditions': jsonEncode(_controller.document.toDelta().toJson()),
    });
  }

  whenaboutUsisNull() {
    if (aboutUs == '') {
      return getAboutUs;
    } else {
      return aboutUs;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            const Text(
              'Terms & Conditions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    QuillSimpleToolbar(
                      controller: _controller,
                      configurations: const QuillSimpleToolbarConfigurations(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: QuillEditor.basic(
                            controller: _controller,
                            configurations: const QuillEditorConfigurations(),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(0),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            buttonColor,
                          ),
                        ),
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {
                          updateAboutUsDetails();
                          _formKey.currentState!.reset();
                          Fluttertoast.showToast(
                              msg: "Update completed",
                              backgroundColor: buttonColor,
                              textColor: Colors.white);
                          // }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
