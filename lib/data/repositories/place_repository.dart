import 'dart:convert' as convert;

import 'package:dongu_mobile/data/model/place.dart';
import 'package:http/http.dart' as http;

abstract class PlaceRepository {
  Future<Place> getPlace(String placeId);
}

class SamplePlaceRepository implements PlaceRepository {
  final key = "AIzaSyDmbISvHTI8ohyLzmek96__1ACHqTNkPLg";

  Future<Place> getPlace(String placeId) async {
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }
}

class PlaceNetworkError implements Exception {
  final String statusCode;
  final String message;
  PlaceNetworkError(this.statusCode, this.message);
}
