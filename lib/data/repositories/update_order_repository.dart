import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class UpdateOrderRepository {
  Future<StatusCode> cancelOrder(int id, String description) async {
    String json =
        '{"description": "$description","ip":"${SharedPrefs.getIpV4}","reason":"$description"}';

    final response = await http.delete(
      Uri.parse("${UrlConstant.EN_URL}order/$id/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    response.statusCode == 200
        ? SharedPrefs.setDeleteOrder(true)
        : SharedPrefs.setDeleteOrder(false);
    print(SharedPrefs.getToken);
    print(SharedPrefs.getIpV4);
    print(id);
    print("CANCEL ORDER STATUS: ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> updateOrderStatus(int id, int status) async {
    String json = '{"status": $status}';

    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}order/$id/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );

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
