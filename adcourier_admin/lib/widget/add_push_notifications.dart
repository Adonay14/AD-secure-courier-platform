import 'package:admin/constance.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../models/push_notifications.dart';
import '../utils/push_notification.dart';

class AddPushNotification extends StatefulWidget {
  const AddPushNotification({super.key});

  @override
  State<AddPushNotification> createState() => _AddPushNotificationState();
}

class _AddPushNotificationState extends State<AddPushNotification> {
  String uid = '';
  String title = '';
  String category = '';
  String detail = '';

  Future<void> addPushNotification(
      PushNotificationsModel categoriesModel) async {
    FirebaseFirestore.instance
        .collection('Push Notifications')
        .doc(uid)
        .set(categoriesModel.toMap())
        .then((value) {
      if (category == 'Users') {
        FirebaseFirestore.instance.collection('users').get().then((value) {
          for (var element in value.docs) {
            PushNotificationFunction.sendPushNotification(
                title, detail, element['tokenID']);
          }
        });
      } else if (category == 'Vendors') {
        FirebaseFirestore.instance.collection('vendors').get().then((value) {
          for (var element in value.docs) {
            PushNotificationFunction.sendPushNotification(
                title, detail, element['tokenID']);
          }
        });
      } else if (category == 'Riders') {
        FirebaseFirestore.instance.collection('riders').get().then((value) {
          for (var element in value.docs) {
            PushNotificationFunction.sendPushNotification(
                title, detail, element['tokenID']);
          }
        });
      }
      if (mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: "Push Notification has been sent",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    var uuid = const Uuid();
    uid = uuid.v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add a new push notification',
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                DropdownSearch<String>(
                  selectedItem: category,
                  validator: (v) => v == null ? "required field" : null,
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                    hintText: "Category",
                    // labelText: "Categories *",
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
                      category = value!;
                    });
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              category.isNotEmpty) {
                            addPushNotification(PushNotificationsModel(
                                    uid: uid,
                                    timeCreated: DateTime.now(),
                                    title: title,
                                    category: category,
                                    detail: detail))
                                .then((value) {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          } else {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              title: "Notification",
                              message: "Some fields are missing",
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          }
                        },
                        child: const Text(
                          'Send Notification',
                          style: TextStyle(color: Colors.white),
                        ).tr()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
