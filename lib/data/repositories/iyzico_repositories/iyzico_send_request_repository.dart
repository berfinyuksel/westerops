import 'dart:convert';
import 'dart:developer';
import 'package:dongu_mobile/data/model/error_message.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/payment_cubit/error_message.cubit.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';

import '../../services/locator.dart';

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
    sl<ErrorMessageCubit>().setStateMessage(response.body);
    log("SEND REQUEST BODY : ${response.body}");
    log("SEND REQUEST STATUS : ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      //utf8.decode for turkish characters
      List<OrderReceived> orderReceivedList = [];
      OrderReceived orderItem = OrderReceived.fromJson(jsonBody);
      orderReceivedList.add(orderItem);
      return orderReceivedList;
    }else if(response.statusCode!=200){
         final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      //utf8.decode for turkish characters
      List<ErrorMessage> errorList = [];
      ErrorMessage errorMessageItem = ErrorMessage.fromJson(jsonBody);
      errorList.add(errorMessageItem);
    log("SEND REQUEST ERROR MESSAGE : ${errorMessageItem.errorMessage!}");
     sl<ErrorMessageCubit>().setStateMessage(errorMessageItem.errorMessage!);
    }

    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
