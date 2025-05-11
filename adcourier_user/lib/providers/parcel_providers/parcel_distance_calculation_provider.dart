import 'dart:math';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'parcel_distance_calculation_provider.g.dart';

@riverpod
double calculateDistance(Ref ref, lat1, lon1, lat2, lon2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  double dLat = _degToRad(lat2 - lat1);
  double dLon = _degToRad(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degToRad(lat1)) *
          cos(_degToRad(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double _degToRad(double deg) {
  return deg * (pi / 180);
}
