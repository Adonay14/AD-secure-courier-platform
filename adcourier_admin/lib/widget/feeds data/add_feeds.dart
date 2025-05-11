// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:admin/constance.dart';
import 'package:admin/providers/feed_provider.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/feeds.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class AddFeed extends ConsumerStatefulWidget {
  const AddFeed({super.key});

  @override
  ConsumerState<AddFeed> createState() => _AddFeedState();
}

class _AddFeedState extends ConsumerState<AddFeed> {
  String module = 'Parcel Delivery';
  @override
  Widget build(BuildContext context) {
    var cats =
        ref.watch(getCategoriesForFeedsProvider(module)).valueOrNull ?? [];
    var feedForm = ref.read(allFeedsProvider.notifier);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add a new feed',
            style: TextStyle(fontSize: 15.sp),
          ).tr(),
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
                  feedForm.updateTitle(value);
                },
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
                height: 10,
              ),
              TextFormField(
                  maxLines: 4,
                  onChanged: (value) {
                    feedForm.updateDetail(value);
                  },
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
              if (module != 'Parcel Delivery')
                const SizedBox(
                  height: 10,
                ),
              if (module != 'Parcel Delivery')
                DropdownSearch<String>(
                  validator: (v) => v == null ? "required field".tr() : null,
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                    hintText: "Select a category".tr(),
                    labelText: "Categories *",
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
                  items: (r, e) => cats,
                  onChanged: (value) {
                    feedForm.updateCategory(value!);
                  },
                ),
              // DropdownSearch<String>(
              //   validator: (v) => v == null ? "required field".tr() : null,
              //   popupProps: const PopupProps.menu(
              //     showSelectedItems: true,
              //   ),
              //   decoratorProps: DropDownDecoratorProps(
              //       decoration: InputDecoration(
              //     labelText: "Sub Categories *",
              //     hintText: "Select a sub category".tr(),
              //     border: const UnderlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF01689A)),
              //     ),
              //   )),
              //   items: subCategories,
              //   onChanged: (value) {
              //     setState(() {
              //       subcategory = value!;
              //       selected = false;
              //     });
              //   },
              // ),
              // DropdownSearch<String>(
              //   validator: (v) => v == null ? "required field" : null,
              //   popupProps: const PopupProps.menu(
              //     showSelectedItems: true,
              //   ),
              //   decoratorProps: const DropDownDecoratorProps(
              //       decoration: InputDecoration(
              //     labelText: "Sub categories collections *",
              //     hintText: "Select a sub category collections",
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Color(0xFF01689A)),
              //     ),
              //   )),
              //   items: subCategoriesCollections,
              //   onChanged: (value) {
              //     setState(() {
              //       subcategorycollection = value!;
              //     });
              //   },
              // ),
              const SizedBox(height: 20),
              Text('Enable Slider'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              AnimatedButtonBar(
                radius: 32.0,
                padding: const EdgeInsets.all(20.0),
                backgroundColor: Colors.blueGrey.shade800,
                foregroundColor: Colors.blueGrey.shade300,
                elevation: 0,
                borderColor: Colors.white,
                borderWidth: 2,
                innerVerticalPadding: 16,
                children: [
                  ButtonBarEntry(
                      onTap: () {
                        feedForm.updateSlider(true);
                      },
                      child: const Text('Yes').tr()),
                  ButtonBarEntry(
                      onTap: () {
                        feedForm.updateSlider(false);
                      },
                      child: const Text('No').tr()),
                ],
              ),
              ref.watch(allFeedsProvider).imagePicker == null
                  ? const Icon(Icons.image, size: 200, color: Colors.grey)
                  : Image.memory(
                      ref.watch(allFeedsProvider).imagePicker!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  feedForm.getImage();
                },
                icon: const Icon(Icons.add_a_photo),
                iconSize: 50,
                color: buttonColor,
              ),
              ref.watch(allFeedsProvider).image.isEmpty ||
                      (module != "Parcel Delivery" &&
                          ref.watch(allFeedsProvider).category.isEmpty) ||
                      ref.watch(allFeedsProvider).title.isEmpty ||
                      ref.watch(allFeedsProvider).detail.isEmpty ||
                      ref.watch(allFeedsProvider).isLoading == true ||
                      module.isEmpty
                  ? SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: null,
                          child: const Text(
                            'Add new feed',
                            style: TextStyle(color: Colors.white),
                          ).tr()))
                  : SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor),
                          onPressed: () {
                            feedForm
                                .addFeed(
                              FeedsModel(
                                  module: module,
                                  slider: ref.watch(allFeedsProvider).slider,
                                  title: ref.watch(allFeedsProvider).title,
                                  category:
                                      ref.watch(allFeedsProvider).category,
                                  image: ref.watch(allFeedsProvider).image,
                                  subCategoryCollections: ref
                                      .watch(allFeedsProvider)
                                      .subCategoryCollections,
                                  subCategory:
                                      ref.watch(allFeedsProvider).subCategory,
                                  detail: ref.watch(allFeedsProvider).detail),
                            )
                                .then((value) {
                              if (context.mounted) {
                                Flushbar(
                                  flushbarPosition: FlushbarPosition.TOP,
                                  title: "Notification",
                                  message:
                                      "Feed has been added successfully!!!",
                                  duration: const Duration(seconds: 3),
                                ).show(context).then((v) {
                                  if (context.mounted) {
                                    context.pop();
                                  }
                                });
                              }
                            });
                          },
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
