import 'dart:convert';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/box_order.dart';
import '../shared/shared_prefs.dart';

abstract class OrderRepository {
  Future<List<BoxOrder>> deleteBasket(String boxId);

  Future<List<BoxOrder>> getBasket();
  Future<List<BoxOrder>> clearBasket();
}

class SampleOrderRepository implements OrderRepository {
  final url = "${UrlConstant.EN_URL}order/basket/";

  Future<List<BoxOrder>> deleteBasket(String boxId) async {
    String json = '{"box_id":"$boxId" }';
    final response = await http.post(
        Uri.parse("${UrlConstant.EN_URL}order/basket/remove_box_from_basket/"),
        headers: {
          'Authorization': 'JWT ${SharedPrefs.getToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    print("DELETE BASKET ${response.statusCode}");

    if (response.statusCode == 200) {
      // var jsonResults = jsonBody['boxes'];
      // print(jsonResults);
      List<BoxOrder> boxes = [];
      // for (int i = 0; i < jsonResults.length; i++) {
      //   boxes.add(BoxOrder.fromJson(jsonResults[i]));
      // }
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<BoxOrder>> getBasket() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}order/basket/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("GET BASKET STATUS ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<BoxOrder> boxes = [];
      print(jsonBody);

      if (jsonBody.isEmpty) {
        return boxes;
      } else if ('Y' == jsonBody[0] ||
          "Sepetinde ürün bulunmamaktadır!" == jsonBody) {
        return boxes;
      } else {
        for (int i = 0; i < jsonBody.length; i++) {
          //orderrr
          boxes.add(BoxOrder.fromJson(jsonBody[i]));
        }
        return boxes;
      }
    } else if (response.statusCode == 401) {
      List<BoxOrder> boxes = [];
      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<BoxOrder>> clearBasket() async {
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/basket/remove_all_boxes/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("CLEAR BASKET STATUS ${response.statusCode}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonBody); //utf8.decode for turkish characters
      List<BoxOrder> boxes = [];
      return boxes;
    }
    if (response.statusCode == 401) {
      List<BoxOrder> boxes = [];
      return boxes;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
