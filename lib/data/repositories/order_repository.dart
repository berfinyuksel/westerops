import 'dart:convert';

import '../model/box.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class OrderRepository {
  Future<List<String>> addToBasket(int boxId);
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
      headers: {'Content-Type': 'application/json', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    print(response.statusCode);
    if (response.statusCode == 201) {
      List<String> boxes = [];
      boxes.add("box");
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<Box>> getBasket() async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMCwidXNlcm5hbWUiOiJ6ZXluZXBAZ21haWwuY29tIiwiZXhwIjoxNjIwNDczNzg5LCJlbWFpbCI6InpleW5lcEBnbWFpbC5jb20iLCJvcmlnX2lhdCI6MTYyMDIxNDU4OX0.VF5uuE68eth7ab7WbHQ-bBUbERJwQi0I53e2T7wlPu8'
      },
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
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
