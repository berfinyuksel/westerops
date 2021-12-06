import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class UpdatePermissonRepository {
  Future<StatusCode> updateEmailPermission(bool updateBool) async {
    String json = '{"allow_email": $updateBool}';

    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("Update Email Permission status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> updatePhoneCallPermission(bool updateBool) async {
    String json = '{"allow_phone": $updateBool}';

    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("Update Phone Permission status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }
}
