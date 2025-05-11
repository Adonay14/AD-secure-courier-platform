import 'package:admin/constance.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/feeds.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewFeed extends StatefulWidget {
  final FeedsModel categoriesModel;
  const ViewFeed({super.key, required this.categoriesModel});

  @override
  State<ViewFeed> createState() => _ViewFeedState();
}

class _ViewFeedState extends State<ViewFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Add a new feed').tr(),
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
              TextFormField(
                readOnly: true,
                initialValue: widget.categoriesModel.title,
                decoration: InputDecoration(
                  hintText: "Feed title".tr(),
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                  initialValue: widget.categoriesModel.detail,
                  readOnly: true,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Feed detail".tr(),
                    fillColor: Colors.white,
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
                  )),
              const SizedBox(height: 20),
              DropdownSearch<String>(
                enabled: false,
                validator: (v) => v == null ? "required field".tr() : null,
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                  hintText: "Select a category".tr(),
                  labelText: "Categories*",
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
                )),
                items:(r,e)=> const [],
                selectedItem: widget.categoriesModel.category,
              ),
              // DropdownSearch<String>(
              //   validator: (v) => v == null ? "required field".tr() : null,
              //   popupProps: const PopupProps.menu(
              //     showSelectedItems: true,
              //   ),
              //   decoratorProps: DropDownDecoratorProps(
              //       decoration: InputDecoration(
              //     hintText: "Select a sub category".tr(),
              //     labelText: "Sub Categories*",
              //     border: const UnderlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF01689A)),
              //     ),
              //   )),
              //   items: const [],
              //   selectedItem: widget.categoriesModel.subCategory,
              // ),
              // DropdownSearch<String>(
              //   validator: (v) => v == null ? "required field".tr() : null,
              //   popupProps: const PopupProps.menu(
              //     showSelectedItems: true,
              //   ),
              //   decoratorProps: DropDownDecoratorProps(
              //       decoration: InputDecoration(
              //     hintText: "Select a sub category collections".tr(),
              //     labelText: "Sub categories collections *",
              //     border: const UnderlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF01689A)),
              //     ),
              //   )),
              //   items: const [],
              //   selectedItem: widget.categoriesModel.subCategoryCollections,
              // ),
              const SizedBox(height: 10),
              Image.network(
                widget.categoriesModel.image,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: null,
                icon: const Icon(Icons.add_a_photo),
                iconSize: 50,
                color: buttonColor,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor),
                      onPressed: null,
                      child: const Text(
                        'Add new feed',
                        style: TextStyle(color: Colors.white),
                      ).tr()))
            ],
          ),
        ),
      ),
    );
  }
}
