import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:user_web/model/parcel_category.dart';
import 'package:user_web/model/parcel_model.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/parcel_checkout.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/parcel_receiver_form.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/parcel_sender_form.dart';

import '../../constant.dart';

class ParcelCart extends StatefulWidget {
  final ParcelCategoriesModel parcelCategoriesModel;
  const ParcelCart({super.key, required this.parcelCategoriesModel});

  @override
  State<ParcelCart> createState() => _ParcelCartState();
}

class _ParcelCartState extends State<ParcelCart> {
  int _currentStep = 0;
  ParcelModel? _senderDetails;
  var logger = Logger();

  // Method to update sender details from the first form
  void updateSenderDetails(ParcelModel details) {
    setState(() {
      _senderDetails = details;

      if (_senderDetails != null) {
        steps();
        logger.d(_senderDetails!.senderPhone);
      }
    });
  }

  void _stepContinue() {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
        logger.d('Step Continued: $_currentStep');
        steps();
      }
    });
  }

  void _stepCancel() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
        steps();
      }
    });
  }

  late List<Step> _steps;

  @override
  void initState() {
    super.initState();
    // Initialize steps in initState to avoid using instance variables in initialization
    steps();
  }

  steps() {
    if (_senderDetails != null) {
      logger.d(_senderDetails!.receiverName);
    }
    setState(() {
      _steps = [
        Step(
          title: const Text(
            "Sender",
            softWrap: true,
          ),
          content: ParcelSenderForm(
            onSenderDetailsSubmitted: updateSenderDetails,
            onStepComplete: _stepContinue,
          ),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text(
            "Receiver",
            softWrap: true,
          ),
          content: _senderDetails != null
              ? ParcelReceiverForm(
                  onSenderDetailsSubmitted: updateSenderDetails,
                  onStepComplete: _stepContinue,
                  senderDetails: _senderDetails!,
                )
              : const SizedBox(),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text(
            'Checkout',
            softWrap: true,
          ),
          content: _senderDetails != null
              ? ParcelCheckout(
                parcelCategoriesModel: widget.parcelCategoriesModel,
                  senderDetails: _senderDetails!,
                )
              : const SizedBox(),
          isActive: _currentStep == 2,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parcelCategoriesModel.category),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          )
        ],
      ),
      body: Stepper(
        physics: const BouncingScrollPhysics(),
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _stepContinue,
        onStepCancel: _stepCancel,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                if (_currentStep > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      shape: const BeveledRectangleBorder(),
                    ),
                    onPressed: _stepCancel,
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                // const SizedBox(width: 12),
                // ElevatedButton(
                //   onPressed: _stepContinue,
                //   child: Text(_currentStep == _steps.length - 1
                //       ? 'Submit'
                //       : 'Continue'),
                // ),
              ],
            ),
          );
        },
        steps: _steps,
      ),
    );
  }
}
