import 'package:flutter/material.dart';

import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated, noAddress }

class BasketRepository {
  Future<StatusCode> addToBasket(
      String boxId, int addressID, int billingAddressId) async {
    String json =
        '{"box_id":"$boxId","billing_address":$billingAddressId,"address":$addressID}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/basket/add_box_to_basket/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    debugPrint("ADD BASKET status ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      case 406:
        return StatusCode.noAddress;
      default:
        return StatusCode.error;
    }
  }
}
