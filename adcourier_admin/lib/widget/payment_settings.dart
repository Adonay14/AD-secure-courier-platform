import 'package:admin/constance.dart';
import 'package:admin/providers/payment_setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:sizer/sizer.dart';

class PaymentSettings extends ConsumerStatefulWidget {
  const PaymentSettings({super.key});

  @override
  ConsumerState<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends ConsumerState<PaymentSettings> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var paymentProvider = ref.watch(paymentSettingsProviderProvider);
    var paymentProviderNotifier =
        ref.read(paymentSettingsProviderProvider.notifier);
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Stripe Payment (Visa and MasterCards card)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Enable Stripe payment'),
          value: paymentProvider.enableStripe,
          onChanged: demo == true
              ? (v) {
                  Fluttertoast.showToast(
                      msg: "Sorry this is in demo mode",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                }
              : (bool? value) {
                  // enableStripe = !enableStripe;
                  var r = paymentProviderNotifier.updateEnebleStripe();
                  paymentProviderNotifier.enableStripe(r);
                },
        ),
        const Gap(20),
        Image.asset(
          'assets/image/image_processing20210904-7932-1eyochb.gif',
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
                        child: Text('Secret Key:',
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
                                    // setState(() {
                                    //   publishableKey = value;
                                    // });
                                    // paymentProviderNotifier.updateStripe(
                                    //     value, paymentProvider.getSecretKey);
                                    paymentProvider.getSecretKey = value;
                                  },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              hintText: paymentProvider.getSecretKey,
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
                        child: Text('Publishable Key:',
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
                                    // paymentProviderNotifier.updateStripe(
                                    //     value, paymentProvider.getPublishableKey);
                                    paymentProvider.getPublishableKey = value;
                                  },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1.0),
                              ),
                              hintText: paymentProvider.getPublishableKey,
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
                    paymentProviderNotifier.updateStripe(
                        paymentProvider.getPublishableKey,
                        paymentProvider.getSecretKey);
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
                'Paystack Payment (Visa and MasterCards card)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Enable Paystack payment'),
          value: paymentProvider.enablePaystack,
          onChanged: demo == true
              ? (v) {
                  Fluttertoast.showToast(
                      msg: "Sorry this is in demo mode",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                }
              : (bool? value) {
                  // setState(() {
                  // enablePaystack = !enablePaystack;
                  // PaymentClass().enablePaystack(enablePaystack);
                  var r = paymentProviderNotifier.updateEneblePaystack();
                  paymentProviderNotifier.enablePaystack(r);
                  // });
                },
        ),
        const Gap(20),
        Image.asset(
          'assets/image/paystack-opengraph.png',
          height: 150,
          width: 300,
          fit: BoxFit.cover,
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
                      child: Text('Public Key:',
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
                                  // setState(() {
                                  //   paystackPublicKey = value;
                                  // });
                                  // paymentProviderNotifier.updatePaystack(
                                  //     value, paymentProvider.getBackendUrl);
                                  paymentProvider.getPaystackPublicKey = value;
                                },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            hintText: paymentProvider.getPaystackPublicKey,
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
                      child: Text('Secret Key:',
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
                                  // paymentProviderNotifier.updatePaystack(
                                  //     paymentProvider.getPaystackPublicKey, value);
                                  paymentProvider.getBackendUrl = value;
                                },
                          decoration: InputDecoration(
                            hintText: paymentProvider.getBackendUrl,
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
                onPressed: () {
                  // if (_formKey2.currentState!.validate()) {
                  paymentProviderNotifier.updatePaystack(
                      paymentProvider.getPaystackPublicKey,
                      paymentProvider.getBackendUrl);
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
                'Flutterwave Payment (Visa and MasterCards card)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Enable Flutterwave payment'),
          value: paymentProvider.enableFlutterwave,
          onChanged: demo == true
              ? (v) {
                  Fluttertoast.showToast(
                      msg: "Sorry this is in demo mode",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                }
              : (bool? value) {
                  // setState(() {
                  //   enableFlutterwave = !enableFlutterwave;
                  //   PaymentClass().enableFlutterwave(enableFlutterwave);
                  // });
                  var r = paymentProviderNotifier.updateEnebleFlutterwave();
                  paymentProviderNotifier.enableFlutterwave(r);
                },
        ),
        const Gap(20),
        Image.asset(
          'assets/image/images.png',
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
                      child: Text('Secret Key:',
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
                                  // paymentProviderNotifier.updateFlutterwave(
                                  //     paymentProvider.getFlutterwaveSecretKey, value);
                                  paymentProvider.getFlutterwaveSecretKey =
                                      value;
                                },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            hintText: paymentProvider.getFlutterwaveSecretKey,
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
                      child: Text('Publishable Key:',
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
                                  // paymentProviderNotifier.updateFlutterwave(
                                  //     paymentProvider.getFlutterwavePublicKey, value);
                                  paymentProvider.getFlutterwavePublicKey =
                                      value;
                                },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusColor: Colors.grey,
                            hintText: paymentProvider.getFlutterwavePublicKey,
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
                      child: Text('Encryption Key:',
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
                                  // paymentProviderNotifier.updateFlutterwave(
                                  //     paymentProvider.getFlutterwavePublicKey, value);
                                  paymentProvider.getFlutterwaveEncriptedKey =
                                      value;
                                },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusColor: Colors.grey,
                            hintText:
                                paymentProvider.getFlutterwaveEncriptedKey,
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
                  paymentProviderNotifier.updateFlutterwave(
                      paymentProvider.getFlutterwavePublicKey,
                      paymentProvider.getFlutterwaveSecretKey,
                      paymentProvider.getFlutterwaveEncriptedKey);
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Razorpay Payment (Visa and MasterCards card)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
          ],
        ),
        CheckboxListTile(
          title: const Text('Enable Razorpay payment'),
          value: paymentProvider.enableRazorpay,
          onChanged: demo == true
              ? (v) {
                  Fluttertoast.showToast(
                      msg: "Sorry this is in demo mode",
                      backgroundColor: buttonColor,
                      textColor: Colors.white);
                }
              : (bool? value) {
                  // setState(() {
                  //   enableRazorpay = !enableRazorpay;
                  //   PaymentClass().enableRazorpay(enableFlutterwave);
                  // });
                  var r = paymentProviderNotifier.updateEnebleRazorpay();
                  paymentProviderNotifier.enableRazorpay(r);
                },
        ),
        const Gap(20),
        Image.asset(
          'assets/image/razorpay.png',
          // fit: BoxFit.cover,
          height: 150,
          width: 300,
        ),
        const Gap(20),
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
                      child: Text('Razorpay Key:',
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
                                  paymentProviderNotifier.updateRazorpay(value);
                                },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0),
                            ),
                            focusColor: Colors.grey,
                            hintText: paymentProvider.getRazorPayKey,
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
                  paymentProviderNotifier
                      .updateRazorpay(paymentProvider.getRazorPayKey);
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
        // const SizedBox(height: 20),
        // Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Text(
        //         'Yookassa Payment (Visa and MasterCards card)',
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        //       ),
        //     ),
        //   ],
        // ),
        // CheckboxListTile(
        //   title: const Text('Enable Yookassa payment'),
        //   value: paymentProvider.enableYookassa,
        //   onChanged: demo == true
        //       ? (v) {
        //           Fluttertoast.showToast(
        //               msg: "Sorry this is in demo mode",
        //               backgroundColor: buttonColor,
        //               textColor: Colors.white);
        //         }
        //       : (bool? value) {
        //           // enableStripe = !enableStripe;
        //           var r = paymentProviderNotifier.updateEnebleYookassa();
        //           paymentProviderNotifier.enableYookassa(r);
        //         },
        // ),
        // const Gap(20),
        // Image.network(
        //   'https://akaunting.com/public/assets/media/1350-enes-sacid-buker/yookassa/yookassa-logo.png',
        //   height: 150,
        //   width: 300,
        //   fit: BoxFit.cover,
        // ),
        const Gap(20),
      ],
    );
  }
}
