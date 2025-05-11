import 'package:admin/constance.dart';
import 'package:admin/utils/database/business_info_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessInfo extends StatefulWidget {
  const BusinessInfo({super.key});

  @override
  State<BusinessInfo> createState() => _BusinessInfoState();
}

class _BusinessInfoState extends State<BusinessInfo> {
  @override
  void initState() {
    getEmailDetails();
    getBusinessDetails();
    getAddressDetails();
    getPhoneDetails();
    super.initState();
  }

  String businessName = '';
  String email = '';
  String address = '';
  String phone = '';
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  String getbusinessName = '';
  String getemail = '';
  String getphone = '';
  String getAddress = '';

  getBusinessDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('business name')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getbusinessName = value['business name'];
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
          getAddress = value['address'];
        });
      }
    });
  }

  whenBusinessNameisNull() {
    if (businessName == '') {
      return getbusinessName;
    } else {
      return businessName;
    }
  }

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

  whenemailisNull() {
    if (email == '') {
      return getemail;
    } else {
      return email;
    }
  }

  getPhoneDetails() {
    FirebaseFirestore.instance
        .collection('Business Details')
        .doc('phone')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getphone = value['phone'];
        });
      }
    });
  }

  whenPhoneisNull() {
    if (phone == '') {
      return getphone;
    } else {
      return phone;
    }
  }

  whenAddressisNull() {
    if (address == '') {
      return getAddress;
    } else {
      return address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Business name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Text('Business name:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ))),
                    Flexible(
                        flex: 4,
                        child: TextFormField(
                            // readOnly: true,
                            // onTap: () {
                            //   Fluttertoast.showToast(
                            //       msg:
                            //           "This is a test version you can't change the key",
                            //       backgroundColor: buttonColor,
                            //       textColor: Colors.white);
                            // },
                            onChanged: (value) {
                              setState(() {
                                businessName = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              hintText: whenBusinessNameisNull(),
                              focusColor: Colors.grey,
                              filled: true,
                              fillColor: Colors.white10,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                            )))
                  ],
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

                    BusinessInfoDatabase()
                        .updateBusinessName(whenBusinessNameisNull());
                    _formKey.currentState!.reset();
                    Fluttertoast.showToast(
                        msg: "Update completed",
                        backgroundColor: buttonColor,
                        textColor: Colors.white);
                    //      }
                  },
                  child: const Text('Update',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Email Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey2,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                      flex: 1,
                      child: Text('Email Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  Flexible(
                      flex: 4,
                      child: TextFormField(
                          // readOnly: true,
                          // onTap: () {
                          //   Fluttertoast.showToast(
                          //       msg:
                          //           "This is a test version you can't change the key",
                          //       backgroundColor: buttonColor,
                          //       textColor: Colors.white);
                          // },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            hintText: whenemailisNull(),
                            focusColor: Colors.grey,
                            filled: true,
                            fillColor: Colors.white10,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          )))
                ],
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
                  // if (_formKey2.currentState!.validate()) {
                  BusinessInfoDatabase().updateEmail(whenemailisNull());
                  _formKey2.currentState!.reset();
                  Fluttertoast.showToast(
                      msg: "Update completed",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                  //   }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Phone number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey3,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                      flex: 1,
                      child: Text('Phone number:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  Flexible(
                      flex: 4,
                      child: TextFormField(
                          // readOnly: true,
                          // onTap: () {
                          //   Fluttertoast.showToast(
                          //       msg:
                          //           "This is a test version you can't change the key",
                          //       backgroundColor: buttonColor,
                          //       textColor: Colors.white);
                          // },
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusColor: Colors.grey,
                            hintText: whenPhoneisNull(),
                            filled: true,
                            fillColor: Colors.white10,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          )))
                ],
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
                  //  if (_formKey3.currentState!.validate()) {
                  BusinessInfoDatabase().updatePhone(whenPhoneisNull());
                  _formKey3.currentState!.reset();
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
          ]),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        Form(
          key: _formKey4,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                      flex: 1,
                      child: Text('Address:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                  Flexible(
                      flex: 4,
                      child: TextFormField(
                          // readOnly: true,
                          // onTap: () {
                          //   Fluttertoast.showToast(
                          //       msg:
                          //           "This is a test version you can't change the key",
                          //       backgroundColor: buttonColor,
                          //       textColor: Colors.white);
                          // },
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusColor: Colors.grey,
                            hintText: whenAddressisNull(),
                            filled: true,
                            fillColor: Colors.white10,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                          )))
                ],
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
                  //  if (_formKey3.currentState!.validate()) {
                  BusinessInfoDatabase().updateAddress(whenAddressisNull());
                  _formKey4.currentState!.reset();
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
          ]),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
