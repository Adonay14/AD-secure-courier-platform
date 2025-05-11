import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user_web/model/parcel_model.dart';
import 'package:user_web/widgets/parcel_delivery_module_widget/open_street.dart';

import '../../constant.dart';

class ParcelReceiverForm extends StatefulWidget {
  final Function(ParcelModel)? onSenderDetailsSubmitted;
  final VoidCallback? onStepComplete; // Add this callback
  final ParcelModel senderDetails;

  const ParcelReceiverForm(
      {super.key,
      required this.senderDetails,
      this.onSenderDetailsSubmitted,
      this.onStepComplete});

  @override
  State<ParcelReceiverForm> createState() => _ParcelReceiverFormState();
}

class _ParcelReceiverFormState extends State<ParcelReceiverForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _streetNumberController = TextEditingController();
  final _floorNumberController = TextEditingController();
  String address = '';
  double lat = 0;
  double long = 0;

  @override
  void dispose() {
    // Clean up controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _houseNumberController.dispose();
    _streetNumberController.dispose();
    _floorNumberController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter receiver name';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{10,14}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateOthers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter field';
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && address.isNotEmpty) {
      // Create final ParcelModel with both sender and receiver details
      final finalParcelModel = widget.senderDetails.copyWith(
        receiverLat: lat,
        receiverLong: long,
        receiverName: _nameController.text,
        receiverEmail:
            _emailController.text.isNotEmpty ? _emailController.text : null,
        receiverPhone: '+${_phoneController.text}',
        receiverAddress: address,
        receiverHouseNumber: _houseNumberController.text,
        receiverStreetNumber: _streetNumberController.text,
        receiverFloorNumber: _floorNumberController.text,
      );
      // If callback is provided, use it
      if (widget.onSenderDetailsSubmitted != null) {
        widget.onSenderDetailsSubmitted!(finalParcelModel);
      }
      // Invoke the callback to indicate step completion
      if (widget.onStepComplete != null) {
        widget.onStepComplete!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Receiver Name',
              border: OutlineInputBorder(),
            ),
            validator: _validateName,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: _validateEmail,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              prefixText: '+',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: _validatePhone,
          ),
          const SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            // controller: _addressController,
            decoration: InputDecoration(
              prefix: IconButton(
                  onPressed: () async {
                    var result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const OpenStreetProfile();
                    }));
                    // _navigateAndDisplaySelection(context);
                    setState(() {
                      address = result['address'];
                      lat = result['lat'];
                      long = result['long'];
                    });
                  },
                  icon: const Icon(Icons.add)),
              labelText: address.isNotEmpty ? null : 'Address',
              hintText: address,
              border: const OutlineInputBorder(),
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: _validateOthers,
                  controller: _houseNumberController,
                  decoration: const InputDecoration(
                    labelText: 'House Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  validator: _validateOthers,
                  controller: _streetNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Street Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            validator: _validateOthers,
            controller: _floorNumberController,
            decoration: const InputDecoration(
              labelText: 'Floor Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor,
              shape: const BeveledRectangleBorder(),
            ),
            onPressed: _submitForm,
            child: const Text(
              'Submit Parcel Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
