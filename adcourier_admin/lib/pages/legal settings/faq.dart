import 'dart:convert';

import 'package:admin/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  void initState() {
    getFaqDetails();
    super.initState();
  }

  String faq = '';
  final _formKey = GlobalKey<FormState>();
  String getFaq = '';
  final QuillController _controller = QuillController.basic();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getFaqDetails() {
    FirebaseFirestore.instance
        .collection('FAQ')
        .doc('FAQ')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getFaq = value['FAQ'];
        });
        _controller.document = Document.fromJson(jsonDecode(value['FAQ']));
      }
    });
  }

  updateFaqDetails() {
    FirebaseFirestore.instance.collection('FAQ').doc('FAQ').set({
      'FAQ': jsonEncode(_controller.document.toDelta().toJson()),
    });
  }

  whenFaqisNull() {
    if (faq == '') {
      return getFaq;
    } else {
      return faq;
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
              'FAQ',
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
                          updateFaqDetails();
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
