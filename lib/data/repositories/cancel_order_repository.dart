import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class CancelOrderRepository {
  Future<StatusCode> cancelOrder(int id) async {
    final response = await http.delete(
      Uri.parse("${UrlConstant.EN_URL}order/$id/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("Delete Order status ${response.statusCode}");

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
