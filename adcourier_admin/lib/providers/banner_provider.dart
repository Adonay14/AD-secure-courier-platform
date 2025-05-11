import 'dart:typed_data';
import 'package:admin/models/feeds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'banner_provider.g.dart';

@riverpod
class AllBanner extends _$AllBanner {
  @override
  FeedsModel build() {
    return FeedsModel(
        module: '',
        category: '',
        title: '',
        detail: '',
        subCategory: '',
        image: '',
        subCategoryCollections: '');
  }

  // @riverpod
  // Stream<List<FeedsModel>> feeds() {
  //   return FirebaseFirestore.instance.collection('Banners').snapshots().map(
  //     (snapshot) {
  //       if (snapshot.docs.isEmpty) {
  //         return [];
  //       } else {
  //         return snapshot.docs.map((doc) {
  //           return FeedsModel.fromMap(doc.data(), doc.id);
  //         }).toList();
  //       }
  //     },
  //   );
  // }

  Future<void> addBanner(FeedsModel feedsModel) async {
    await FirebaseFirestore.instance
        .collection('Banners')
        .add(feedsModel.toMap())
        .then((value) {});
  }

  getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;

      state = state.copyWith(imagePicker: fileBytes);

      // Upload file
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref('uploads/${DateTime.now()}')
          .putData(fileBytes!);
      String url = await upload.ref.getDownloadURL();

      state = state.copyWith(image: url);
    }
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDetail(String detail) {
    state = state.copyWith(detail: detail);
  }

  void updateModule(String module) {
    state = state.copyWith(module: module);
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateSubCategory(String subcategory) {
    state = state.copyWith(subCategory: subcategory);
  }

  void updateSubCategoryCollection(String subcategorycollection) {
    state = state.copyWith(subCategoryCollections: subcategorycollection);
  }

  void updateSlider(bool slider) {
    state = state.copyWith(slider: slider);
  }
}

@riverpod
Future<List<String>> getCategoriesForBanner(Ref ref, String module) async {
  var cat = await FirebaseFirestore.instance
      .collection('Categories')
      .where('module', isEqualTo: module)
      .get();
  return cat.docs.map((doc) => doc['category'] as String).toList();
}

@riverpod
Future<List<String>> getSubCategoriesForBanner(
  Ref ref,
  String category,
) async {
  // if (category != '' && selected == true) {
  var sub = await FirebaseFirestore.instance
      .collection('Sub Categories')
      .where('category', isEqualTo: category)
      .get();
  return sub.docs.map((doc) => doc['name'] as String).toList();
}

@riverpod
Future<List<String>> getSubCategoriesCollectionsForBanner(
    Ref ref, String subcategory) async {
  var sub = await FirebaseFirestore.instance
      .collection('Sub categories collections')
      .where('sub-category', isEqualTo: subcategory)
      .get();
  return sub.docs.map((e) => e['name'] as String).toList();
}

@riverpod
Stream<List<FeedsModel>> getBanners(Ref ref) {
  return FirebaseFirestore.instance.collection('Banners').snapshots().map(
    (snapshot) {
      if (snapshot.docs.isEmpty) {
        return [];
      } else {
        return snapshot.docs.map((doc) {
          return FeedsModel.fromMap(doc.data(), doc.id);
        }).toList();
      }
    },
  );
}
