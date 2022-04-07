import 'dart:convert';
import 'dart:developer';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_create_order_with_3d.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/error_message.cubit.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';

class IyzicoCreateOrderWith3DRepository {
  Future<List<IyzicoOrderCreateWith3D>> createOrderWith3D(
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
        '{"delivery_type":"$deliveryType","address":"$addressId","billing_address":"$billingAddressId","cardAlias":"$cardAlias","cardHolderName":"$cardHolderName","ip":"$ip","threeD":true,"cardNumber":"$cardNumber","expireMonth":"$expireMonth","expireYear":"$expireYear","cvc":"$cvc","registerCard":$registerCard}';
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}order/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );

    log("3D PAYMENT BODY : ${response.body}");
    sl<ErrorMessageCubit>().setStateMessage(response.body);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(
          utf8.decode(response.bodyBytes)); //utf8.decode for turkish characters
      List<IyzicoOrderCreateWith3D> cardLists = [];
      IyzicoOrderCreateWith3D cardListElement =
          IyzicoOrderCreateWith3D.fromJson(jsonBody);
      cardLists.add(cardListElement);
      return cardLists;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
