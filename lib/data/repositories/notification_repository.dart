import 'package:dongu_mobile/data/model/notification.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class NotificationRepository {
  Future<List<MyNotification>> postNotification(
      String registrationId, String type);
}

class SampleNotificationRepository implements NotificationRepository {
  @override
  Future<List<MyNotification>> postNotification(
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
      List<MyNotification> boxess = [];

      return boxess;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

}