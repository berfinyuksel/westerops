
import 'package:dongu_mobile/data/model/results_notification.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class PutNotificationRepository {
  Future<List<Result>> putNotification(String notificationId);
}

class SamplePutNotificationRepository implements PutNotificationRepository {
  @override
  Future<List<Result>> putNotification(String notificationId) async {
       String json = '{"is_read": "true"}';
    final response = await http.put(
      Uri.parse("${UrlConstant.EN_URL}notification/$notificationId/"),
      body: json,
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      //final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Result> notificationList = [];
      // List<Result> boxes = [];

      return notificationList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
