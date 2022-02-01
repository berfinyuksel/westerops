import 'package:dongu_mobile/data/model/results_notification.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error }

abstract class BulkUpdateNotificationRepository {
  Future<List<Result>> bulkUpdateNotification(String notificationId);
}

class SampleBulkUpdateNotificationRepository implements BulkUpdateNotificationRepository {
  @override
  Future<List<Result>> bulkUpdateNotification(String notificationId) async {
    String json = '[{"id": $notificationId, "is_deleted": "true"}]';
    final response = await http.put(
      Uri.parse("${UrlConstant.EN_URL}notification/bulk-update/"),
      body: json,
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Notification BLUK UPDATE StatusCode " + response.statusCode.toString());
    print("Notification Body BLUK UPDATE " + response.body);

    if (response.statusCode == 200) {
      //final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

      List<Result> notificationList = [];
      // List<Result> boxes = [];

      return notificationList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
