import 'package:admin/constance.dart';
import 'package:admin/providers/sms_settings_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

class AddWhatsapp extends ConsumerStatefulWidget {
  const AddWhatsapp({super.key});

  @override
  ConsumerState<AddWhatsapp> createState() => _AddWhatsappState();
}

class _AddWhatsappState extends ConsumerState<AddWhatsapp> {
  String uid = '';
  String title = '';
  String detail = '';
  String phone = '';
  var logger = Logger();
  getEmailDetails() {
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

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    var uuid = const Uuid();
    getEmailDetails();
    uid = uuid.v1();
    super.initState();
  }

  String collection = 'Users';
  @override
  Widget build(BuildContext context) {
    var emailDetail = ref.watch(smsSettingsNotifierProvider);
    logger.d(emailDetail.selectedPlatform);
    var emails = collection.isEmpty
        ? null
        : ref.watch(fetchPhonesFromFirestoreProvider(collection));
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add a new WHATSAPP notification',
            style: TextStyle(fontSize: 15.sp),
          ).tr(),
          InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.clear))
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('Selected Platform ${emailDetail.selectedPlatform}'),
              const SizedBox(height: 20),
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
                )),
                items:(r,e)=> userCollection,
                onChanged: (value) {
                  setState(() {
                    collection = value!;
                  });
                  // form.updateCategory(value!);
                },
              ),
              const SizedBox(height: 20),
              if (collection.isNotEmpty)
                emails!.when(data: (v) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Notification Title".tr(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          maxLines: 5,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'Field is required';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              detail = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Notification Message".tr(),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        // DropdownSearch<String>(
                        //   selectedItem: category,
                        //   validator: (v) => v == null ? "required field" : null,
                        //   popupProps: const PopupProps.menu(
                        //     showSelectedItems: true,
                        //   ),
                        //   decoratorProps: const DropDownDecoratorProps(
                        //       decoration: InputDecoration(
                        //     hintText: "Category",
                        //     // labelText: "Categories *",
                        //     border: UnderlineInputBorder(
                        //       borderSide: BorderSide(color: Color(0xFF01689A)),
                        //     ),
                        //   )),
                        //   items: const [
                        //     'Vendors',
                        //     'Users',
                        //     "Service Providers",
                        //     "Riders",
                        //     "All"
                        //   ],
                        //   onChanged: (value) {
                        //     setState(() {
                        //       category = value!;
                        //     });
                        //   },
                        // ),
                        //  const SizedBox(height: 40),
                        SizedBox(
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: buttonColor),
                                onPressed: emailDetail.enableWhatsapp == true
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          if (emailDetail.selectedPlatform ==
                                              'Twilio') {
                                            sendBulkTwilioWhatsApp(
                                                detail,
                                                v,
                                                emailDetail.twilioNumber,
                                                title,
                                                emailDetail.accountSID,
                                                emailDetail.authToken,
                                                context);
                                          } else if (emailDetail
                                                  .selectedPlatform ==
                                              'Nexmo') {
                                            sendBulkNexmoWhatsApp(
                                                detail,
                                                v,
                                                emailDetail.nexmoNumber,
                                                title,
                                                emailDetail.nexmoSecretKey,
                                                emailDetail.nexmoApiKey,
                                                context);
                                          } else {
                                            sendBulkTelesignWhatsApp(
                                                detail,
                                                v,
                                                phone,
                                                title,
                                                emailDetail.telesignCustomerID,
                                                emailDetail.telesignApiKey,
                                                context);
                                          }
                                        }
                                      },
                                child: Text(
                                  emailDetail.enableSms == true
                                      ? "Disabled"
                                      : 'Send Notification',
                                  style: const TextStyle(color: Colors.white),
                                ).tr()))
                      ],
                    ),
                  );
                }, error: (error, e) {
                  return Text('$error');
                }, loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
