import 'location_details.dart';

class Geometry {
  final LocationDetails? locationDetails;

  Geometry({this.locationDetails});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson) : locationDetails = LocationDetails.fromJson(parsedJson['location']);
}
