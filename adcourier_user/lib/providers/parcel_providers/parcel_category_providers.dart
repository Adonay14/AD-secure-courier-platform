import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:user_web/model/parcel_category.dart';
part 'parcel_category_providers.g.dart';

@riverpod
Future<List<ParcelCategoriesModel>> getParcelCategoriesByModel(Ref ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Parcel Categories').get();
  return snapshot.docs
      .map((e) => ParcelCategoriesModel.fromMap(e.data(), e.id))
      .toList();
}
