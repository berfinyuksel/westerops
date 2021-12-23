import 'dart:convert';

import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_registered_card.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class IyzicoCardRepository {
  Future<StatusCode> addCard(String cardAlias, String cardHolderName,
      String cardNumber, String expireMonth, String expireYear) async {
    String json =
        '{"cardAlias":"$cardAlias","cardHolderName":"$cardHolderName","cardNumber":"$cardNumber","expireMonth":"$expireMonth","expireYear":"$expireYear"}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/cards/register"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );
    print("ADD Card status ${response.statusCode}");
    print(response.body);
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> deleteCard(String cardToken) async {
    String json = '{"cardToken":$cardToken}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/cards/delete"),
      body: json,
      headers: {'Authorization': 'JWT ${SharedPrefs.getToken}'},
    );
    print("Delete Card status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<List<CardDetail>> getCards() async {
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/cards/list"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );
    print("get Card status ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters

      List<CardDetail> cardLists = List<CardDetail>.from(
          jsonBody.map((model) => CardDetail.fromJson(model)));

      return cardLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
