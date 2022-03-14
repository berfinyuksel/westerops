import 'dart:convert';
import 'dart:developer';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:flutter/material.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';

abstract class OrderReceivedRepository {
  Future<List<IyzcoOrderCreate>> getOrder();
  Future<List<IyzcoOrderCreate>> createOrderWithRegisteredCard(
    int deliveryType,
    int addressId,
    int billingAddressId,
    String cardToken,
    String ip,
  );
  Future<List<IyzcoOrderCreate>> createOrderWithout3D(
    int deliveryType,
    int addressId,
    int billingAddressId,
    String cardAlias,
    String cardHolderName,
    String cardNumber,
    String expireMonth,
    String expireYear,
    int registerCard,
    String cvc,
    String ip,
  );
  Future<List<IyzcoOrderCreate>> getOrderById(int id);
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

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      body: json,
      headers: {'Content-Type': 'application/json', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    log("Create Order with Registered Card status ${response.statusCode}");
    if (response.statusCode == 201) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<IyzcoOrderCreate> orderReceivedList = [];
      IyzcoOrderCreate orderItem = IyzcoOrderCreate.fromJson(jsonBody);
      orderReceivedList.add(orderItem);
      return orderReceivedList;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<IyzcoOrderCreate>> createOrderWithout3D(
    int deliveryType,
    int addressId,
    int billingAddressId,
    String cardAlias,
    String cardHolderName,
    String cardNumber,
    String expireMonth,
    String expireYear,
    int registerCard,
    String cvc,
    String ip,
  ) async {
    String json =
        '{"delivery_type":"$deliveryType","address":"$addressId","billing_address":"$billingAddressId","cardAlias":"$cardAlias","cardHolderName":"$cardHolderName","ip":"$ip","threeD":false,"cardNumber":"$cardNumber","expireMonth":"$expireMonth","expireYear":"$expireYear","cvc":"$cvc","registerCard":$registerCard}';
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      body: json,
      headers: {'Content-Type': 'application/json', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    log("Create Order Without 3D status ${response.statusCode}");
    if (response.statusCode == 201) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<IyzcoOrderCreate> orderReceivedList = [];
      IyzcoOrderCreate orderItem = IyzcoOrderCreate.fromJson(jsonBody);
      orderReceivedList.add(orderItem);
      return orderReceivedList;
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<IyzcoOrderCreate>> getOrder() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    debugPrint("GET Order STATUS ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<IyzcoOrderCreate> orderReceivedList =
          List<IyzcoOrderCreate>.from(jsonBody.map((model) => IyzcoOrderCreate.fromJson(model))).toList();
      return orderReceivedList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<List<IyzcoOrderCreate>> getOrderById(int id) async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}order/$id"),
      headers: {'Content-Type': 'application/json', 'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    log("GET Order By Id STATUS ${response.statusCode}");

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      IyzcoOrderCreate orderReceivedListItem = IyzcoOrderCreate.fromJson(jsonBody);
      //print(boxLists[].text_name);
      List<IyzcoOrderCreate> orderReceivedList = [];
      orderReceivedList.add(orderReceivedListItem);
      return orderReceivedList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
