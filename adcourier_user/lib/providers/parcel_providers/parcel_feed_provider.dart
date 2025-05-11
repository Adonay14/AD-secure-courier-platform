import 'package:riverpod/riverpod.dart';
import 'package:user_web/model/feeds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'parcel_feed_provider.g.dart';


@riverpod
Stream<List<FeedsModel>> parcelFeeds(Ref ref) {
  return FirebaseFirestore.instance
      .collection('Sliders')
      .where('module', isEqualTo: 'Parcel Delivery')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => FeedsModel(
                slider: doc['slider'],
                isBanner: false,
                category: doc['category'],
                title: doc['title'],
                detail: doc['detail'],
                subCategory: doc['sub-category'],
                image: doc['image'],
                subCategoryCollections: doc['sub-category-collections'],
              ))
          .toList());
}
