import 'package:admin/constance.dart';
import 'package:admin/utils/database/social_info_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class SocialSettings extends StatefulWidget {
  const SocialSettings({super.key});

  @override
  State<SocialSettings> createState() => _SocialSettingsState();
}

class _SocialSettingsState extends State<SocialSettings> {
  @override
  void initState() {
    getInstagramDetails();
    getFacebookDetails();
    getTwitterDetails();
    super.initState();
  }

  String facebook = '';
  String instagram = '';
  String twitter = '';
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  String getfacebbok = '';
  String getinstagram = '';
  String gettwitter = '';

  getFacebookDetails() {
    FirebaseFirestore.instance
        .collection('Social Details')
        .doc('facebook')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getfacebbok = value['facebook'];
        });
      }
    });
  }

  getInstagramDetails() {
    FirebaseFirestore.instance
        .collection('Social Details')
        .doc('instagram')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          getinstagram = value['instagram'];
        });
      }
    });
  }

  getTwitterDetails() {
    FirebaseFirestore.instance
        .collection('Social Details')
        .doc('twitter')
        .snapshots()
        .listen((value) {
      if (mounted) {
        setState(() {
          gettwitter = value['twitter'];
        });
      }
    });
  }

  whenfacebookisNull() {
    if (facebook == '') {
      return getfacebbok;
    } else {
      return facebook;
    }
  }

  whenInstagramisNull() {
    if (instagram == '') {
      return getinstagram;
    } else {
      return instagram;
    }
  }

  whenTwitterisNull() {
    if (twitter == '') {
      return gettwitter;
    } else {
      return twitter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'facebook',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Gap(20),
                Image.asset(
                  'assets/image/Facebook-Logo.png',
                  height: 150,
                  width: 300,
                  // fit: BoxFit.cover,
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                          flex: 1,
                          child: Text('Facebook:',
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
                              onChanged: demo == true
                                  ? (v) {
                                      Fluttertoast.showToast(
                                          msg: "Sorry this is in demo mode",
                                          backgroundColor: buttonColor,
                                          textColor: Colors.white);
                                    }
                                  : (value) {
                                      setState(() {
                                        facebook = value;
                                      });
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: whenfacebookisNull(),
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
                    onPressed: demo == true
                        ? null
                        : () {
                            // if (_formKey.currentState!.validate()) {

                            SocialInfoDatabase()
                                .updateFacebook(whenfacebookisNull());
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
                  'Instagram',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey2,
            child: Column(children: [
              const Gap(20),
              Image.asset(
                'assets/image/instagram.jpg',
                height: 150,
                width: 300,
                // fit: BoxFit.cover,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Text('Instagram:',
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
                            onChanged: demo == true
                                ? (v) {
                                    Fluttertoast.showToast(
                                        msg: "Sorry this is in demo mode",
                                        backgroundColor: buttonColor,
                                        textColor: Colors.white);
                                  }
                                : (value) {
                                    setState(() {
                                      instagram = value;
                                    });
                                  },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              hintText: whenInstagramisNull(),
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
                  onPressed: demo == true
                      ? null
                      : () {
                          // if (_formKey2.currentState!.validate()) {
                          SocialInfoDatabase()
                              .updateInstagram(whenInstagramisNull());
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
                  'Twitter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey3,
            child: Column(children: [
              const Gap(20),
              Image.asset(
                'assets/image/twitter.png',
                height: 150,
                width: 300,
                // fit: BoxFit.cover,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                        flex: 1,
                        child: Text('Twitter:',
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
                            onChanged: demo == true
                                ? (v) {
                                    Fluttertoast.showToast(
                                        msg: "Sorry this is in demo mode",
                                        backgroundColor: buttonColor,
                                        textColor: Colors.white);
                                  }
                                : (value) {
                                    setState(() {
                                      twitter = value;
                                    });
                                  },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              focusColor: Colors.grey,
                              hintText: whenTwitterisNull(),
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
                  onPressed: demo == true
                      ? null
                      : () {
                          //  if (_formKey3.currentState!.validate()) {
                          SocialInfoDatabase()
                              .updateTwitter(whenTwitterisNull());
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
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
