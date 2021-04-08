import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static double? latitude;
  static double? longitude;
  static List<Placemark>? placeMarks;

  static Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getDetails() async {
    placeMarks = await placemarkFromCoordinates(latitude!, longitude!);
  }
}
