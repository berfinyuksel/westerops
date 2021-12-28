import 'dart:convert';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

abstract class SendRequestRepository {
  Future<List<OrderReceived>> sendRequest(String conversationId);
}

class SampleSendRequestRepository implements SendRequestRepository {
  @override
  Future<List<OrderReceived>> sendRequest(String conversationId) async {
    String json =
        '{"conversationId":"${conversationId.toString()}","ip":"${SharedPrefs.getIpV4}"}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}iyzico/payment/inquiry"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("Send Request Status: ${response.statusCode}");
    if (response.statusCode == 201) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonBody); //utf8.decode for turkish characters
      List<OrderReceived> orderReceivedList = List<OrderReceived>.from(
          jsonBody.map((model) => OrderReceived.fromJson(model))).toList();
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
