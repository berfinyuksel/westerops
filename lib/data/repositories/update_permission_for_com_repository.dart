import 'dart:convert';

import 'package:dongu_mobile/data/model/user_control.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_email_control_cubit.dart';

import '../../utils/network_error.dart';
import '../services/locator.dart';
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

    switch (response.statusCode) {
      case 200:
        return StatusCode.success;
      case 401:
        return StatusCode.unauthecticated;
      default:
        return StatusCode.error;
    }
  }

//TODO User social login control continue - received object of wrong instance error
  Future<List<UserControl>> userSocialControl() async {
    final response = await http.get(
      Uri.parse("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("userSocialControl: ${response.body}");
    print("STATUS CODE: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      //utf8.decode for turkish characters
      List<UserControl> emailList = [];
      UserControl email = UserControl.fromJson(jsonBody);
      emailList.add(email);
      
      if (email.appleEmail != null) {
      sl<UserEmailControlCubit>().setStateEmail(email.appleEmail);
      }else if(email.googleEmail != null){
      sl<UserEmailControlCubit>().setStateEmail(email.googleEmail);
      }else if(email.facebookEmail != null ){
      sl<UserEmailControlCubit>().setStateEmail(email.facebookEmail);
      }
      print("GOOGLE EMAIL : ${email.googleEmail}");
      print("FACEBOOK EMAIL : ${email.facebookEmail}");
      print("APPLE EMAIL : ${email.appleEmail}");

      return emailList;
    }
    throw NetworkError(response.statusCode.toString(), response.body);

  }
}
