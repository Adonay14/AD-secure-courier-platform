import 'package:admin/constance.dart';
import 'package:admin/providers/email_settings_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:logger/logger.dart';

class BulkEMailForm extends ConsumerStatefulWidget {
  const BulkEMailForm({super.key});

  @override
  ConsumerState<BulkEMailForm> createState() => _BulkEMailFormState();
}

class _BulkEMailFormState extends ConsumerState<BulkEMailForm> {
  String message = '';
  String title = '';
  String getemail = '';
  var logger = Logger();
  getEmailDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('email')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getemail = value['email'];
        });
      }
    });
  }

  @override
  void initState() {
    getEmailDetails();
    super.initState();
  }

  String collection = 'Users';
  @override
  Widget build(BuildContext context) {
    var emailDetail = ref.watch(emailSettingsNotifierProvider);
    var sender = ref.read(emailSettingsNotifierProvider.notifier);
    logger.d(emailDetail.selectedPlatform);
    var emails = collection.isEmpty
        ? null
        : ref.watch(fetchEmailsFromFirestoreProvider(collection));
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(20),
          Text('Selected Platform ${emailDetail.selectedPlatform}'),
          const Gap(20),
          DropdownSearch<String>(
            selectedItem: collection,
            validator: (v) => v == null ? "required field".tr() : null,
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
            ),
            decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
              hintText: "Select a user".tr(),
              // labelText: "Module *",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
            )),
            items:(e,r)=> userCollection,
            onChanged: (value) {
              setState(() {
                collection = value!;
              });
              // form.updateCategory(value!);
            },
          ),
          if (collection.isNotEmpty)
            emails!.when(data: (v) {
              return Column(
                children: [
                  const Gap(20),
                  TextFormField(
                    //  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.name,
                    onChanged: (v) {
                      setState(() {
                        title = v;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter title'.tr(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLines: 5,
                    onChanged: (v) {
                      setState(() {
                        message = v;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Message'.tr(),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(0),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          buttonColor,
                        ),
                      ),
                      onPressed: emailDetail.disableEmail == true
                          ? null
                          : () {
                              if (message == '' || title == '') {
                                Fluttertoast.showToast(
                                    msg: "All fields are required",
                                    backgroundColor:
                                        const Color.fromARGB(255, 47, 37, 37),
                                    textColor: Colors.white);
                              } else {
                                if (emailDetail.selectedPlatform == 'Mailgun') {
                                  sender.sendBulkEmailWithMailGunEmail(
                                      getemail,
                                      emailDetail.mailGunApi,
                                      emailDetail.mailGunDomain,
                                      v,
                                      title,
                                      message,
                                      context);
                                } else if (emailDetail.selectedPlatform ==
                                    'Sendgrid') {
                                  sender.sendBulkEmailWithSendGridEmail(
                                      getemail,
                                      emailDetail.sendGridApi,
                                      v,
                                      title,
                                      message,
                                      context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Platform not selected",
                                      backgroundColor:
                                          const Color.fromARGB(255, 47, 37, 37),
                                      textColor: Colors.white);
                                }
                              }
                            },
                      child: Text(
                        emailDetail.disableEmail == true
                            ? 'Disabled'
                            : 'Send Email',
                        style: const TextStyle(color: Colors.white),
                      ))
                ],
              );
            }, error: (error, t) {
              return Text(error.toString());
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
        ],
      ),
    );
  }
}
