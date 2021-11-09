import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class BasketRepository {
  final url = "${UrlConstant.EN_URL}order/basket/";

  Future<StatusCode> addToBasket(String boxId) async {
    String json = '{"box_id":"$boxId","billing_address":"","address":""}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/basket/add_box_to_basket/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("ADD BASKET status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> deleteBasket(String boxId) async {
    String json = '{"box_id":"$boxId" }';
    final response = await http.post(
        Uri.parse("${UrlConstant.EN_URL}order/basket/remove_box_from_basket/"),
        headers: {
          'Authorization': 'JWT ${SharedPrefs.getToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json);

    print("DELETE BASKET ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      default:
        return StatusCode.error;
    }
  }
}
