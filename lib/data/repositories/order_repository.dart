import 'dart:convert';

import '../model/box.dart';

import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class OrderRepository {
  Future<List<String>> addToBasket(int boxId);
  Future<List<Box>> deleteBasket(int boxId);
  Future<List<Box>> getBasket();
}

class SampleOrderRepository implements OrderRepository {
  final url = "${UrlConstant.EN_URL}order/basket/";

  @override
  Future<List<String>> addToBasket(int boxId) async {
    String json = '{"box":"$boxId"}';

    final response = await http.post(
      Uri.parse(url),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      List<String> boxes = [];
      boxes.add("box");
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<Box>> deleteBasket(int boxId) async {
    print("http://localhost:8000/en/order/basket/$boxId/");
    final response = await http.delete(
      Uri.parse("$url$boxId/"),
      headers: {'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      final jsonBody = jsonDecode(response.body);
      var jsonResults = jsonBody['boxes'];
      print(jsonResults);
      List<Box> boxes = [];
      for (int i = 0; i < jsonResults.length; i++) {
        boxes.add(Box.fromJson(jsonResults[i]));
      }
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<Box>> getBasket() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<Box> boxes = [];
      for (int i = 0; i < jsonBody.length; i++) {
        boxes.add(Box.fromJson(jsonBody[i]));
      }
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
