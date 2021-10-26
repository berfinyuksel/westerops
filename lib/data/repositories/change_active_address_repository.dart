import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:http/http.dart' as http;

enum StatusCode { success, error, unauthecticated }

class ChangeActiveAddressRepository {
  Future<StatusCode> changeActiveAddress(int activeAddressId) async {
    //  List<String> group = [];
    String json = '{"active_address": "$activeAddressId"}';

    final response = await http.post(
      Uri.parse("${UrlConstant.EN_URL}user/address/change_address/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    switch (response.statusCode) {
      case 200:
        return StatusCode.success;

      default:
        return StatusCode.error;
    }
  }
}
