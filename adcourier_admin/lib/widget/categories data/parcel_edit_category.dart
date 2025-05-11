import 'package:admin/constance.dart';
import 'package:admin/models/currency_formatter.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import '../../models/parcel_category.dart';

class ParcelEditCategories extends StatefulWidget {
  final ParcelCategoriesModel categoriesModel;
  const ParcelEditCategories({super.key, required this.categoriesModel});

  @override
  State<ParcelEditCategories> createState() => _ParcelEditCategoriesState();
}

class _ParcelEditCategoriesState extends State<ParcelEditCategories> {
  String category = '';
  String firestoreImage = '';
  dynamic image;
  bool loading = false;
  num? adminCommission;
  num? chargePerKm;
  String description = '';

  Future<void> addCategory(ParcelCategoriesModel categoriesModel) async {
    FirebaseFirestore.instance
        .collection('Parcel Categories')
        .doc(widget.categoriesModel.uid)
        .update(categoriesModel.toMap())
        .then((value) {
      if (mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: "Category has been updated successfully!!!",
          duration: const Duration(seconds: 3),
        ).show(context);
      }
    });
  }

  getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      //String fileName = result.files.first.name;
      setState(() {
        image = fileBytes;
        loading = true;
      });
      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes!);
      String url = await upload.ref.getDownloadURL();
      //print(url);
      setState(() {
        firestoreImage = url;
        if (firestoreImage != '') {
          loading = false;
        }
      });
    }
  }

  whenCategoryIsEmpty() {
    if (category == '') {
      return widget.categoriesModel.category;
    } else {
      return category;
    }
  }

  whenImageIsEmpty() {
    if (firestoreImage == '') {
      return widget.categoriesModel.image;
    } else {
      return firestoreImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Edit Parcel Category').tr(),
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
              TextFormField(
                initialValue: widget.categoriesModel.category,
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                },
                decoration: InputDecoration(hintText: "Category name".tr()),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: widget.categoriesModel.description,
                maxLines: 2,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Category description".tr(),
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
              const SizedBox(height: 20),
              TextFormField(
                initialValue:
                    '${CurrencyFormatter().converter(widget.categoriesModel.chargePerKm.toDouble())}',
                onChanged: (value) {
                  setState(() {
                    chargePerKm = int.parse(value);
                  });
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Charge per Km".tr(),
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
              const SizedBox(height: 20),
              TextFormField(
                initialValue: '${widget.categoriesModel.adminCommission}',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    adminCommission = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Admin Commission in percentage".tr(),
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
              image == '' || image == null
                  ? Image.network(
                      widget.categoriesModel.image,
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    )
                  : Image.memory(
                      image,
                      height: 300,
                      width: 300,
                      fit: BoxFit.fill,
                    ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  getImage();
                },
                icon: const Icon(Icons.add_a_photo),
                iconSize: 50,
                color: buttonColor,
              ),
              const SizedBox(height: 20),
              loading == true
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: null,
                          child: const Text('Update category').tr()))
                  : SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: () {
                            addCategory(ParcelCategoriesModel(
                                    description: description.isEmpty
                                        ? widget.categoriesModel.description
                                        : description,
                                    // module: module,
                                    adminCommission: adminCommission == null
                                        ? widget.categoriesModel.adminCommission
                                        : adminCommission!,
                                    chargePerKm: chargePerKm == null
                                        ? widget.categoriesModel.chargePerKm
                                        : chargePerKm!,
                                    category: whenCategoryIsEmpty(),
                                    image: whenImageIsEmpty()))
                                .then((value) {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          child: const Text('Update category').tr()))
            ],
          ),
        ),
      ),
    );
  }
}
