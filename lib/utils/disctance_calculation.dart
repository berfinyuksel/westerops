import 'dart:math';

import '../data/model/search_store.dart';
import '../data/services/location_service.dart';


class DistanceCalculation{
String buildDistance(List<SearchStore> restaurants, int index) {
    double? restaurantLat = restaurants[index].latitude;
    double? restaurantLong = restaurants[index].longitude;
    double? currentLat = LocationService.latitude;
    double? currentLong = LocationService.longitude;

    return (sqrt(
      ((restaurantLat! - currentLat) * (restaurantLat - currentLat)) +
          ((restaurantLong! - currentLong) * (restaurantLong - currentLong)),
    ).toStringAsFixed(2).toString());
  }
}