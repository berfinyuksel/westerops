import 'dart:convert';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

abstract class OrderReceivedRepository {
  Future<List<IyzcoOrderCreate>> getOrder();
  Future<List<IyzcoOrderCreate>> createOrderWithRegisteredCard(
    int deliveryType,
    int addressId,
    int billingAddressId,
    String cardToken,
    String ip,
  );
}

class SampleOrderReceivedRepository implements OrderReceivedRepository {
  @override
  Future<List<IyzcoOrderCreate>> createOrderWithRegisteredCard(
    int deliveryType,
    int addressId,
    int billingAddressId,
    String cardToken,
    String ip,
  ) async {
    String json =
        '{"delivery_type":"${deliveryType.toString()}","address":"$addressId","billing_address":"$billingAddressId","cardToken":"$cardToken","ip":"$ip","threeD":"false"}';
    print("Hİİ");

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("Create Order status ${response.statusCode}");
    if (response.statusCode == 201) {
      print('order created');
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonBody); //utf8.decode for turkish characters
      List<IyzcoOrderCreate> orderReceivedList = [];
      IyzcoOrderCreate orderItem = IyzcoOrderCreate.fromJson(jsonBody);
      orderReceivedList.add(orderItem);
      //print(boxLists[].text_name);
      return orderReceivedList;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<IyzcoOrderCreate>> getOrder() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("GET Order STATUS ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonBody); //utf8.decode for turkish characters
      List<IyzcoOrderCreate> orderReceivedList = List<IyzcoOrderCreate>.from(
          jsonBody.map((model) => IyzcoOrderCreate.fromJson(model))).toList();
      //print(boxLists[].text_name);
      return orderReceivedList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
