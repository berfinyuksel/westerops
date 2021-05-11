import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../shared/shared_prefs.dart';

abstract class UserOperationsRepository {
  Future<List<String>> addToFavorites(int storeId);
  Future<List<String>> deleteFromFavorites(int favoriteId);
}

class SampleUserOperationsRepository implements UserOperationsRepository {
  final url = "${UrlConstant.EN_URL}store/favourite/";

  Future<List<String>> addToFavorites(int storeId) async {
    String json = '{"store":"$storeId"}';
    final response = await http.post(
      Uri.parse(url),
      body: json,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    print("adawd" + response.body + "${response.statusCode}");
    if (response.statusCode == 201) {
      List<String> result = [];
      result.add("created");
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<String>> deleteFromFavorites(int favoriteId) async {
    final response = await http.delete(
      Uri.parse("$url$favoriteId/"),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    if (response.statusCode == 201) {
      List<String> result = [];
      result.add("created");
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
