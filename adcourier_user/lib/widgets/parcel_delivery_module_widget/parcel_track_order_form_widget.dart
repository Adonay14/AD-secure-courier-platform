// ignore_for_file: avoid_print

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:user_web/constant.dart';
import 'package:user_web/providers/track_order_provider.dart';

class ParcelTrackOrderFormWidget extends ConsumerStatefulWidget {
  const ParcelTrackOrderFormWidget({super.key});

  @override
  ConsumerState<ParcelTrackOrderFormWidget> createState() =>
      _ParcelTrackOrderFormWidgetState();
}

class _ParcelTrackOrderFormWidgetState
    extends ConsumerState<ParcelTrackOrderFormWidget> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  String email = '';

  // getToken() async {
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   setState(() {
  //     tokenID = token!;
  //   });
  // }

  @override
  void initState() {
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            "Track your Delivery",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Gap(5),
          SizedBox(
            width: MediaQuery.of(context).size.width >= 1100
                ? MediaQuery.of(context).size.width / 2
                : MediaQuery.of(context).size.width / 1.2,
            child: FormBuilderTextField(
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode.isDark == true
                    ? Colors.black
                    : null,
              ),
              onChanged: (v) {
                setState(() {
                  email = v!;
                });
              },
              key: _emailFieldKey,
              name: 'email',
              decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4,top: 4,bottom: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const BeveledRectangleBorder(),
                          backgroundColor: appColor,
                          textStyle: const TextStyle(color: Colors.white)),
                      // color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(trackParcelOrderProviderProvider(email, context));
                        }
                      },
                      child: const Text(
                        'TRACK',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ).tr(),
                    ),
                  ),
                  filled: true,
                  border: InputBorder.none,
                  fillColor: const Color.fromARGB(255, 236, 234, 234),
                  hintText: 'Your Order Id'.tr(),
                  //border: OutlineInputBorder()
                  hintStyle: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark == true
                        ? Colors.black
                        : null,
                  )),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.integer(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
