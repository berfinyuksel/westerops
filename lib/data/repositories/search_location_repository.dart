import 'dart:convert' as convert;
import '../model/searched_locations.dart';
import 'package:http/http.dart' as http;

abstract class SearchLocationRepository {
  Future<List<SearchedLocations>> getLocations(String search);
}

class SampleSearchLocationRepository implements SearchLocationRepository {
  final key = "AIzaSyDlcgkT0cnXnxEg36EVpWzRv2ZZTPiXmzs";

  @override
  Future<List<SearchedLocations>> getLocations(String search) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=address&components=country:tr&language=tr&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults
        .map((place) => SearchedLocations.fromJson(place))
        .toList();
  }
}

