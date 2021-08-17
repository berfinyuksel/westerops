import 'dart:convert';

import '../model/box.dart';

import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class OrderRepository {
  Future<List<String>> addToBasket(String boxId);
  Future<List<Box>> deleteBasket(String boxId, List<int> allBoxId);
  Future<List<Box>> getBasket();
}

class SampleOrderRepository implements OrderRepository {
  final url = "${UrlConstant.EN_URL}order/basket/";

  @override
  Future<List<String>> addToBasket(String boxId) async {
    String json = '{"box_id":"$boxId"}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/basket/add_box_to_basket/"),
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

  Future<List<Box>> deleteBasket(String boxId, List<int> allBoxId) async {
    String json = '{"box_id":"$boxId", "all_box_ids": "$allBoxId" }';
    final response = await http.post(
        Uri.parse("${UrlConstant.EN_URL}order/basket/remove_box_from_basket/"),
        headers: {'Authorization': 'JWT ${SharedPrefs.getToken}'},
        body: json);

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
      Uri.parse("${UrlConstant.EN_URL}order/basket/"),
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
        print(jsonBody[i]);


        // boxes.add(Box.fromJson(jsonBody[i]));

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
