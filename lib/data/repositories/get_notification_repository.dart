import 'dart:convert';
import 'package:dongu_mobile/data/model/results_notification.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';

import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class GetNotificationRepository {
  Future<List<Result>> getNotification();
}

class SampleGetNotificationRepository implements GetNotificationRepository {
  @override
  Future<List<Result>> getNotification() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}notification/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Notification StatusCode " + response.statusCode.toString());
    print("Notification Body GET " + response.body);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Result> notificationList = List<Result>.from(
          jsonBody["results"].map((model) => Result.fromJson(model)));
      // List<Result> boxes = [];

      return notificationList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
