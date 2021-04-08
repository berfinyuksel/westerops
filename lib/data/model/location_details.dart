class LocationDetails {
  final double? lat;
  final double? lng;

  LocationDetails({this.lat, this.lng});

  factory LocationDetails.fromJson(Map<dynamic, dynamic> parsedJson) {
    return LocationDetails(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}
