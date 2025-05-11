import 'package:admin/constance.dart';
import 'package:admin/providers/sms_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class SmsSettings extends ConsumerStatefulWidget {
  const SmsSettings({super.key});

  @override
  ConsumerState<SmsSettings> createState() => _SmsSettingsState();
}

class _SmsSettingsState extends ConsumerState<SmsSettings> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final smsSettingsState = ref.watch(smsSettingsNotifierProvider);
    final smsSettingsNotifier = ref.read(smsSettingsNotifierProvider.notifier);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            CheckboxListTile(
              title: Text(
                'Disable sms service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              value: smsSettingsState.enableSms,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      // setState(() {
                      //   enableSmsBool = !enableSmsBool;
                      //   enableSms(enableSmsBool);

                      // });
                      smsSettingsNotifier
                          .enableSms(!smsSettingsState.enableSms);
                    },
            ),
            const Gap(20),
            CheckboxListTile(
              title: Text(
                'Disable whatsapp service',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              value: smsSettingsState.enableWhatsapp,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      smsSettingsNotifier
                          .enableWhatsapp(!smsSettingsState.enableWhatsapp);
                    },
            ),
            const Gap(20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Twilio',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Enable Twilio'),
              value:
                  smsSettingsState.selectedPlatform == 'Twilio' ? true : false,
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
                      smsSettingsNotifier.updateSelectedPlatform('Twilio');
                    },
            ),
            const Gap(20),
            Image.asset(
              'assets/image/twilio.png',
              height: 150,
              width: 300,
              fit: BoxFit.cover,
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
                            child: Text('Twilio Number:',
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
                                        smsSettingsNotifier.addTwilioDetails(
                                            value,
                                            smsSettingsState.authToken,
                                            smsSettingsState.accountSID);
                                      },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: smsSettingsState.twilioNumber,
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
                            child: Text('Account SID:',
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
                                        smsSettingsNotifier.addTwilioDetails(
                                            smsSettingsState.twilioNumber,
                                            smsSettingsState.authToken,
                                            value);
                                      },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: smsSettingsState.accountSID,
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
                            child: Text('Auth Token:',
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
                                        smsSettingsNotifier.addTwilioDetails(
                                            smsSettingsState.twilioNumber,
                                            value,
                                            smsSettingsState.accountSID);
                                      },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: smsSettingsState.authToken,
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
                          ? () {
                              Fluttertoast.showToast(
                                  msg: "Sorry this is in demo mode",
                                  backgroundColor: buttonColor,
                                  textColor: Colors.white);
                            }
                          : () {
                              // if (_formKey.currentState!.validate()) {
                              smsSettingsNotifier.addTwilioDetails(
                                  smsSettingsState.twilioNumber,
                                  smsSettingsState.authToken,
                                  smsSettingsState.accountSID);
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
                    'Nexmo',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Enable Nexmo'),
              value:
                  smsSettingsState.selectedPlatform == 'Nexmo' ? true : false,
              onChanged: demo == true
                  ? (v) {
                      Fluttertoast.showToast(
                          msg: "Sorry this is in demo mode",
                          backgroundColor: buttonColor,
                          textColor: Colors.white);
                    }
                  : (bool? value) {
                      setState(() {
                        smsSettingsNotifier.updateSelectedPlatform('Nexmo');
                      });
                    },
            ),
            const Gap(20),
            Image.asset(
              'assets/image/nexmo.png',
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
                          child: Text('Nexmo Number:',
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
                                      smsSettingsNotifier.addNexmoApiKeyDetails(
                                          smsSettingsState.nexmoApiKey,
                                          value,
                                          smsSettingsState.nexmoSecretKey);
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: smsSettingsState.nexmoNumber,
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
                          child: Text('Api key:',
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
                                      smsSettingsNotifier.addNexmoApiKeyDetails(
                                          value,
                                          smsSettingsState.nexmoNumber,
                                          smsSettingsState.nexmoSecretKey);
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: smsSettingsState.nexmoApiKey,
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
                          child: Text('Api Secret Key:',
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
                                      smsSettingsNotifier.addNexmoApiKeyDetails(
                                          smsSettingsState.nexmoApiKey,
                                          smsSettingsState.nexmoNumber,
                                          value);
                                    },
                              decoration: InputDecoration(
                                hintText: smsSettingsState.nexmoSecretKey,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
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
                        ? () {
                            Fluttertoast.showToast(
                                msg: "Sorry this is in demo mode",
                                backgroundColor: buttonColor,
                                textColor: Colors.white);
                          }
                        : () {
                            smsSettingsNotifier.addNexmoApiKeyDetails(
                                smsSettingsState.nexmoApiKey,
                                smsSettingsState.nexmoSecretKey,
                                smsSettingsState.nexmoSecretKey);
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Telesign',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Enable Telesign'),
              value: smsSettingsState.selectedPlatform == 'Telesign'
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
                        smsSettingsNotifier.updateSelectedPlatform('Telesign');
                      });
                    },
            ),
            const Gap(20),
            Image.asset(
              'assets/image/telesign.png',
              fit: BoxFit.cover,
              height: 150,
              width: 300,
            ),
            const Gap(20),
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
                          child: Text('Customer ID:',
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
                                      smsSettingsNotifier.addTelesignDetails(
                                        smsSettingsState.telesignApiKey,
                                        value,
                                      );
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                hintText: smsSettingsState.telesignCustomerID,
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
                          child: Text('Api Key:',
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
                                      smsSettingsNotifier.addTelesignDetails(
                                        value,
                                        smsSettingsState.telesignCustomerID,
                                      );
                                    },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                                focusColor: Colors.grey,
                                hintText: smsSettingsState.telesignApiKey,
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
                        ? () {
                            Fluttertoast.showToast(
                                msg: "Sorry this is in demo mode",
                                backgroundColor: buttonColor,
                                textColor: Colors.white);
                          }
                        : () {
                            //  if (_formKey3.currentState!.validate()) {
                            smsSettingsNotifier.addTelesignDetails(
                              smsSettingsState.telesignApiKey,
                              smsSettingsState.telesignCustomerID,
                            );
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
      ),
    );
  }
}
