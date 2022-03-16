import 'dart:convert';
import 'dart:developer';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_registered_card.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated, noCard }

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
    String json = '{"cardToken":"$cardToken"}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/cards/delete"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );


    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<List<IyzcoRegisteredCard>> getCards() async {
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/cards/list"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );

    log(response.body);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<IyzcoRegisteredCard> cardLists = [];

      if (response.body == "\"KayÄ±tlÄ± kart bulunmamaktadÄ±r.\"") {
        return cardLists;
      } else {
        IyzcoRegisteredCard cardItem = IyzcoRegisteredCard.fromJson(jsonBody);
        cardLists.add(cardItem);
        return cardLists;
      }
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}