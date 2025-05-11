import 'dart:typed_data';

class FeedsModel {
  final String? uid;
  final String category;
  final String subCategoryCollections;
  final String subCategory;
  final String image;
  final String title;
  final String detail;
  final bool? slider;
  Uint8List? imagePicker;
  bool? isLoading;
  final String module;

  FeedsModel(
      {required this.category,
      this.uid,
      this.slider = true,
      this.imagePicker,
      required this.module,
      required this.title,
      required this.detail,
      required this.subCategory,
      required this.image,
      required this.subCategoryCollections,
      this.isLoading});

  Map<String, dynamic> toMap() {
    return {
      'module': module,
      'category': category,
      'image': image,
      'sub-category-collections': subCategoryCollections,
      'sub-category': subCategory,
      'slider': slider,
      'title': title,
      'detail': detail,
    };
  }

  FeedsModel.fromMap(Map<String, dynamic> data, this.uid)
      : category = data['category'],
        module = data['module'],
        image = data['image'],
        subCategoryCollections = data['sub-category-collections'],
        subCategory = data['sub-category'],
        slider = data['slider'],
        title = data['title'],
        detail = data['detail'];

  FeedsModel copyWith(
      {String? uid,
      String? category,
      String? subCategoryCollections,
      String? subCategory,
      String? image,
      String? title,
      bool? isLoading,
      String? module,
      String? detail,
      bool? slider,
      Uint8List? imagePicker}) {
    return FeedsModel(
      module: module ?? this.module,
      uid: uid ?? this.uid,
      isLoading: isLoading ?? isLoading,
      imagePicker: imagePicker ?? this.imagePicker,
      category: category ?? this.category,
      subCategoryCollections:
          subCategoryCollections ?? this.subCategoryCollections,
      subCategory: subCategory ?? this.subCategory,
      image: image ?? this.image,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      slider: slider ?? this.slider,
    );
  }
}
