import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class AvgReviewRepository {
  Future<StatusCode> postReview(
    int mealPoint,
    int servicePoint,
    int qualityPoint,
    int orderId,
    int userId,
    int storeId,
  ) async {
    String json =
        '{"meal_point":$mealPoint,"service_point":$servicePoint,"quality_point":$qualityPoint,"order":$orderId,"user":$userId,"store":$storeId}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}store/review/"),
      body: json,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("avg review added status ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

  Future<StatusCode> getReview(String boxId) async {
    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}store​/review​/"),
      headers: {
        'Authorization': 'JWT ${SharedPrefs.getToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print("avg review get status ${response.statusCode}");
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
