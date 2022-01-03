import 'dart:convert';
import '../model/order_received.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

abstract class OrderReceivedRepository {
  Future<List<OrderReceived>> getOrder();
  Future<List<OrderReceived>> createOrder(
      int deliveryTyp, int addressId, int billingAddressIde);
  Future<List<OrderReceived>> getOrderById(int id);

}

class SampleOrderReceivedRepository implements OrderReceivedRepository {
  @override
  Future<List<OrderReceived>> createOrder(
      int deliveryType, int addressId, int billingAddressId) async {
    String json =
        '{"delivery_type":"${deliveryType.toString()}","address":"$addressId","billing_address":"$billingAddressId"}';
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
      List<OrderReceived> list = [];
      return list;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<OrderReceived>> getOrder() async {
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
      List<OrderReceived> orderReceivedList = List<OrderReceived>.from(
          jsonBody.map((model) => OrderReceived.fromJson(model))).toList();
      //print(boxLists[].text_name);
      return orderReceivedList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<OrderReceived>> getOrderById(int id) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}order/$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("GET Order By Id STATUS ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonBody); //utf8.decode for turkish characters
      OrderReceived orderReceivedListItem = OrderReceived.fromJson(jsonBody);
      //print(boxLists[].text_name);
      List<OrderReceived> orderReceivedList = [];
      orderReceivedList.add(orderReceivedListItem);
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
