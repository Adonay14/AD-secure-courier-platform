import 'package:admin/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

import '../../providers/email_settings_provider.dart';

class MailSettings extends ConsumerStatefulWidget {
  const MailSettings({super.key});

  @override
  ConsumerState<MailSettings> createState() => _MailSettingsState();
}

class _MailSettingsState extends ConsumerState<MailSettings> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailSettingsState = ref.watch(emailSettingsNotifierProvider);
    final emailSettingsNotifier =
        ref.read(emailSettingsNotifierProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            CheckboxListTile(
              title: Text(
                'Disable email service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              value: emailSettingsState.disableEmail,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      // setState(() {
                      //   enableEmailBool = !enableEmailBool;
                      //   enableEmail(enableEmailBool);

                      // });
                      emailSettingsNotifier
                          .enableEmail(!emailSettingsState.disableEmail);
                    },
            ),
            // const Gap(20),
            // CheckboxListTile(
            //   title: Text(
            //     'Disable whatsapp service',
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            //   ),
            //   value: emailSettingsState.enableWhatsapp,
            //   onChanged: (bool? value) {
            //     emailSettingsNotifier
            //         .enableWhatsapp(!emailSettingsState.enableWhatsapp);
            //   },
            // ),
            const Gap(20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Mailgun',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Enable Mailgun'),
              value: emailSettingsState.selectedPlatform == 'Mailgun'
                  ? true
                  : false,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      // setState(() {
                      //   updateSelectedPlatform('Twilio');
                      // });
                      emailSettingsNotifier.updateSelectedPlatform('Mailgun');
                    },
            ),
            const Gap(20),
            Image.asset(
              'assets/image/mailgun.png',
              height: 150,
              width: 300,
              // fit: BoxFit.cover,
            ),
            const Gap(20),
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
                            child: Text('Mailgun Api Key:',
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
                                        emailSettingsNotifier.addMailGunDetails(
                                          value,
                                          emailSettingsState.mailGunDomain,
                                        );
                                      },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: emailSettingsState.mailGunApi,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                            flex: 1,
                            child: Text('Mailgun Domain:',
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
                                        emailSettingsNotifier.addMailGunDetails(
                                            emailSettingsState.mailGunApi,
                                            value);
                                      },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: emailSettingsState.mailGunDomain,
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       const Flexible(
                  //           flex: 1,
                  //           child: Text('Auth Token:',
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //               ))),
                  //       Flexible(
                  //           flex: 4,
                  //           child: TextFormField(
                  //               // readOnly: true,
                  //               // onTap: () {
                  //               //   Fluttertoast.showToast(
                  //               //       msg:
                  //               //           "This is a test version you can't change the key",
                  //               //       backgroundColor: buttonColor,
                  //               //       textColor: Colors.white);
                  //               // },
                  //               onChanged: (value) {
                  //                 emailSettingsNotifier.addTwilioDetails(
                  //                     emailSettingsState.twilioNumber,
                  //                     value,
                  //                     emailSettingsState.accountSID);
                  //               },
                  //               decoration: InputDecoration(
                  //                 border: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: const BorderSide(
                  //                       color: Colors.grey, width: 1.0),
                  //                 ),
                  //                 hintText: emailSettingsState.authToken,
                  //                 focusColor: Colors.grey,
                  //                 filled: true,
                  //                 fillColor: Colors.white10,
                  //                 focusedBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(10),
                  //                   borderSide: const BorderSide(
                  //                       color: Colors.grey, width: 1.0),
                  //                 ),
                  //                 enabledBorder: OutlineInputBorder(
                  //                   borderRadius: BorderRadius.circular(8),
                  //                   borderSide: const BorderSide(
                  //                       color: Colors.grey, width: 1.0),
                  //                 ),
                  //               )))
                  //     ],
                  //   ),
                  // ),
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
                          ? () {
                              Fluttertoast.showToast(
                                  msg: "Sorry this is in demo mode",
                                  backgroundColor: buttonColor,
                                  textColor: Colors.white);
                            }
                          : () {
                              // if (_formKey.currentState!.validate()) {
                              emailSettingsNotifier.addMailGunDetails(
                                emailSettingsState.mailGunApi,
                                emailSettingsState.mailGunDomain,
                              );
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sendgrid',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Enable Sendgrid'),
              value: emailSettingsState.selectedPlatform == 'Sendgrid'
                  ? true
                  : false,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      setState(() {
                        emailSettingsNotifier
                            .updateSelectedPlatform('Sendgrid');
                      });
                    },
            ),
            const Gap(20),
            Image.asset(
              'assets/image/sendgrid.png',
              height: 150,
              width: 300,
              // fit: BoxFit.cover,
            ),
            const Gap(20),
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
                          child: Text('Sendgrid Api Key:',
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
                                      emailSettingsNotifier.addSendGridDetails(
                                        value,
                                      );
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: emailSettingsState.sendGridApi,
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Flexible(
                //           flex: 1,
                //           child: Text('Api key:',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //               ))),
                //       Flexible(
                //           flex: 4,
                //           child: TextFormField(
                //               // readOnly: true,
                //               // onTap: () {
                //               //   Fluttertoast.showToast(
                //               //       msg:
                //               //           "This is a test version you can't change the key",
                //               //       backgroundColor: buttonColor,
                //               //       textColor: Colors.white);
                //               // },
                //               onChanged: (value) {
                //                 emailSettingsNotifier.addNexmoApiKeyDetails(
                //                     value,
                //                     emailSettingsState.nexmoNumber,
                //                     emailSettingsState.nexmoSecretKey);
                //               },
                //               decoration: InputDecoration(
                //                 border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //                 hintText: emailSettingsState.nexmoApiKey,
                //                 focusColor: Colors.grey,
                //                 filled: true,
                //                 fillColor: Colors.white10,
                //                 focusedBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //                 enabledBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //               )))
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Flexible(
                //           flex: 1,
                //           child: Text('Api Secret Key:',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.bold,
                //               ))),
                //       Flexible(
                //           flex: 4,
                //           child: TextFormField(
                //               // readOnly: true,
                //               // onTap: () {
                //               //   Fluttertoast.showToast(
                //               //       msg:
                //               //           "This is a test version you can't change the key",
                //               //       backgroundColor: buttonColor,
                //               //       textColor: Colors.white);
                //               // },
                //               onChanged: (value) {
                //                 emailSettingsNotifier.addNexmoApiKeyDetails(
                //                     emailSettingsState.nexmoApiKey,
                //                     emailSettingsState.nexmoNumber,
                //                     value);
                //               },
                //               decoration: InputDecoration(
                //                 hintText: emailSettingsState.nexmoSecretKey,
                //                 border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //                 focusColor: Colors.grey,
                //                 filled: true,
                //                 fillColor: Colors.white10,
                //                 focusedBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(10),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //                 enabledBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide: const BorderSide(
                //                       color: Colors.grey, width: 1.0),
                //                 ),
                //               )))
                //     ],
                //   ),
                // ),
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
                        ? () {
                            Fluttertoast.showToast(
                                msg: "Sorry this is in demo mode",
                                backgroundColor: buttonColor,
                                textColor: Colors.white);
                          }
                        : () {
                            emailSettingsNotifier.addSendGridDetails(
                                emailSettingsState.sendGridApi);
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
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Text(
            //         'Telesign',
            //         style:
            //             TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            //       ),
            //     ),
            //   ],
            // ),
            // CheckboxListTile(
            //   title: const Text('Enable Telesign'),
            //   value:
            //       emailSettingsState.selectedPlatform == 'Telesign' ? true : false,
            //   onChanged: (bool? value) {
            //     setState(() {
            //       emailSettingsNotifier.updateSelectedPlatform('Telesign');
            //     });
            //   },
            // ),
            // const Gap(20),
            // Image.asset(
            //   'assets/image/telesign.png',
            //   fit: BoxFit.cover,
            //   height: 150,
            //   width: 300,
            // ),
            // const Gap(20),
            // Form(
            //   key: _formKey3,
            //   child: Column(children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Flexible(
            //               flex: 1,
            //               child: Text('Customer ID:',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                   ))),
            //           Flexible(
            //               flex: 4,
            //               child: TextFormField(
            //                   // readOnly: true,
            //                   // onTap: () {
            //                   //   Fluttertoast.showToast(
            //                   //       msg:
            //                   //           "This is a test version you can't change the key",
            //                   //       backgroundColor: buttonColor,
            //                   //       textColor: Colors.white);
            //                   // },
            //                   onChanged: (value) {
            //                     emailSettingsNotifier.addTelesignDetails(
            //                       emailSettingsState.telesignApiKey,
            //                       value,
            //                     );
            //                   },
            //                   decoration: InputDecoration(
            //                     border: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                     hintText: emailSettingsState.telesignCustomerID,
            //                     focusColor: Colors.grey,
            //                     filled: true,
            //                     fillColor: Colors.white10,
            //                     focusedBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(10),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                     enabledBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                   )))
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           const Flexible(
            //               flex: 1,
            //               child: Text('Api Key:',
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                   ))),
            //           Flexible(
            //               flex: 4,
            //               child: TextFormField(
            //                   // readOnly: true,
            //                   // onTap: () {
            //                   //   Fluttertoast.showToast(
            //                   //       msg:
            //                   //           "This is a test version you can't change the key",
            //                   //       backgroundColor: buttonColor,
            //                   //       textColor: Colors.white);
            //                   // },
            //                   onChanged: (value) {
            //                     emailSettingsNotifier.addTelesignDetails(
            //                       value,
            //                       emailSettingsState.telesignCustomerID,
            //                     );
            //                   },
            //                   decoration: InputDecoration(
            //                     border: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                     focusColor: Colors.grey,
            //                     hintText: emailSettingsState.telesignApiKey,
            //                     filled: true,
            //                     fillColor: Colors.white10,
            //                     focusedBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(10),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                     enabledBorder: OutlineInputBorder(
            //                       borderRadius: BorderRadius.circular(8),
            //                       borderSide: const BorderSide(
            //                           color: Colors.grey, width: 1.0),
            //                     ),
            //                   )))
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ElevatedButton(
            //         style: ButtonStyle(
            //           elevation: WidgetStateProperty.all(0),
            //           backgroundColor: WidgetStateProperty.all<Color>(
            //             buttonColor,
            //           ),
            //         ),
            //         onPressed: () {
            //           //  if (_formKey3.currentState!.validate()) {
            //           emailSettingsNotifier.addTelesignDetails(
            //             emailSettingsState.telesignApiKey,
            //             emailSettingsState.telesignCustomerID,
            //           );
            //           _formKey3.currentState!.reset();
            //           Fluttertoast.showToast(
            //               msg: "Update completed",
            //               backgroundColor: buttonColor,
            //               textColor: Colors.white);
            //           // }
            //         },
            //         child: const Text(
            //           'Update',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ]),
            // ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
