import 'package:dongu_mobile/data/model/notification.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';

import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class NotificationRepository {
  Future<List<Notification>> postNotification(
      String registrationId, String type);
        Future<List<Notification>> getNotification(
      );
}

class SampleNotificationRepository implements NotificationRepository {
  @override
  Future<List<Notification>> postNotification(
      String registrationId, String type) async {
    String json = '{"registration_id": "$registrationId", "type": "$type"}';
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}devices/"),
      body: json,
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Notification StatusCode " + response.statusCode.toString());
    print("Notification Body " + response.body);

    if (response.statusCode == 201) {
      List<Notification> boxess = [];

      return boxess;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
    @override
  Future<List<Notification>> getNotification() async {
   
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
      List<Notification> boxes = [];

      return boxes;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
