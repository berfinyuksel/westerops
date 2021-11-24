import 'dart:convert';

import 'package:dongu_mobile/data/model/favourite.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';

import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class FavoriteRepository {
  Future<List<Favourite>> addFavorite(int? id);
  Future<List<Favourite>> deleteFavorite(int? id);
  Future<List<Favourite>> getFavorites();
}

class SampleFavoriteRepository implements FavoriteRepository {
  @override
  Future<List<Favourite>> addFavorite(int? id) async {
    final response = await http.put(
      Uri.parse("${UrlConstant.EN_URL}store/favourite_store/$id/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<Favourite> boxes = [];

      return boxes;
    }
    if (response.statusCode == 400) {
      List<Favourite> boxes = [];

      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<Favourite>> deleteFavorite(int? id) async {
    final response = await http.delete(
      Uri.parse("${UrlConstant.EN_URL}store/favourite_store/$id/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      List<Favourite> boxes = [];

      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<Favourite>> getFavorites() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}store/favourite_store/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json',
      },
    );
    print('object');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Favourite> favoritesList = List<Favourite>.from(
          jsonBody.map((model) => Favourite.fromJson(model)));
      print("Response: $response");
      print(jsonBody);
      return favoritesList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}