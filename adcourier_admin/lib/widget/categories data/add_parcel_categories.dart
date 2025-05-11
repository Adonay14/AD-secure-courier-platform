import 'package:admin/constance.dart';
import 'package:admin/models/parcel_category.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

class AddParcelCategory extends StatefulWidget {
  const AddParcelCategory({super.key});

  @override
  State<AddParcelCategory> createState() => _AddParcelCategoryState();
}

class _AddParcelCategoryState extends State<AddParcelCategory> {
  String category = '';
  String firestoreImage = '';
  dynamic image;
  num adminCommission = 0;
  num chargePerKm = 0;
  String description = '';

  Future<void> addCategory(ParcelCategoriesModel categoriesModel) async {
    FirebaseFirestore.instance
        .collection('Parcel Categories')
        .add(categoriesModel.toMap())
        .then((value) {
      if (mounted) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: "Notification",
          message: "Category has been added successfully!!!",
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
      });
      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes!);
      String url = await upload.ref.getDownloadURL();
      //print(url);
      setState(() {
        firestoreImage = url;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Add a new parcel category').tr(),
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
                onChanged: (value) {
                  setState(() {
                    category = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Category name".tr(),
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
              image == null
                  ? const Icon(Icons.image, size: 300, color: Colors.grey)
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
              firestoreImage == '' ||
                      description.isEmpty ||
                      category.isEmpty ||
                      adminCommission == 0 ||
                      chargePerKm == 0
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: null,
                          child: const Text('Add new category').tr()))
                  : SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: () {
                            addCategory(ParcelCategoriesModel(
                                    description: description,
                                    adminCommission: adminCommission,
                                    chargePerKm: chargePerKm,
                                    // module: module,
                                    category: category,
                                    image: firestoreImage))
                                .then((value) {
                              if (context.mounted) {
                                Navigator.of(context).pop();
                              }
                            });
                          },
                          child: const Text('Add new parcel category').tr()))
            ],
          ),
        ),
      ),
    );
  }
}
