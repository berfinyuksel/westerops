import 'dart:convert';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';
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
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
    //utf8.decode for turkish characters
      List<OrderReceived> orderReceivedList = [];
      OrderReceived orderItem = OrderReceived.fromJson(jsonBody);
      orderReceivedList.add(orderItem);
      return orderReceivedList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}