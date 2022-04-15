import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:dongu_mobile/utils/network_error.dart';
import '../../utils/constants/url_constant.dart';
import '../model/user.dart';
import '../services/locator.dart';
import '../shared/shared_prefs.dart';

abstract class UserAuthenticationRepository {
  Future<List<User>> registerUser(String firstName, String lastName,
      String email, String phone, String password);
  Future<List<String>> updateUser(String firstName, String lastName,
      String email, String phone, String address, String birthday);
  Future<List<User>> loginUser(String email, String password);

  Future<List<String>> resetPassword(
      String verificationId, String otpCode, String newPassword, String phone);
  Future<List<String>> changePassword(String newPassword, String oldPassword);
  Future<List<String>> deleteAccountUser(String deletionReason);
}

class SampleUserAuthenticationRepository
    implements UserAuthenticationRepository {
  final url = "${UrlConstant.EN_URL}user/";
  final urlUpdate = "${UrlConstant.EN_URL}user/";
  final urlLogin = "${UrlConstant.EN_URL}user/login/";

  @override
  Future<List<User>> registerUser(String firstName, String lastName,
      String email, String phone, String password) async {
    //  List<String> group = [];

    String json =
        '{"first_name":"$firstName","last_name":"$lastName","email": "$email", "password": "$password","password2": "$password","phone_number": "$phone", "groups":["Customer"]}';
    final response = await http.post(
      Uri.parse(url),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'JWT ${SharedPrefs.setToken}'
      },
    );

    if (response.statusCode == 201) {
      SharedPrefs.setUserPhone(phone);
      return loginUser(phone, password);
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<String>> updateUser(String firstName, String lastName,
      String email, String phone, String address, String birthday) async {
    // List<String> group = ["Customer"];
    // List<int> address = [1];
    // List<int>? adminRole;
    // String password = "12345678Q";
    String year;
    String month;
    String day;
    year = birthday.split('/')[2];
    month = birthday.split('/')[1];
    day = birthday.split('/')[0];
    String phoneNumber = phone.contains('+90') ? phone : '+90$phone';
    String json =
        '{"first_name":"$firstName", "last_name": "$lastName", "email": "$email", "phone_number": "$phoneNumber", "birthdate": "$year-$month-$day"}';
    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print("USER TOKEN: ${SharedPrefs.getToken}");
    print("USER ID: ${SharedPrefs.getUserId}");
    print(json);
    print("UPDATE USER STATUS: ${response.statusCode}");
  

    if (response.statusCode == 200) {
      SharedPrefs.setUserEmail(email);
      SharedPrefs.setUserName(firstName);
      SharedPrefs.setUserLastName(lastName);
      SharedPrefs.setUserPhone(phone);
      //SharedPrefs.setUserAddress(address);
      SharedPrefs.setUserBirth(birthday);
      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<String>> resetPassword(String verificationId, String otpCode,
      String newPassword, String phone) async {
    String json = ""
        '{"verification_id": "$verificationId", "otp_code": "$otpCode", "new_password": "$newPassword", "phone_number": "$phone"}';
    final response = await http.post(
      Uri.parse(
        ("${UrlConstant.EN_URL}user/reset-password/mobile/"),
      ),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    if (response.statusCode == 200) {
      SharedPrefs.setUserPassword(newPassword);

      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<User>> loginUser(String phone, String password) async {
    String json = '{"credential": "$phone", "password": "$password"}';
    final response = await http.post(
      Uri.parse(urlLogin),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
     
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      var jsonResults = jsonBody['user'];
      String year = "yyyy";
      String month = "mm";
      String day = "dd";
      if(jsonResults['birthdate'] != null) {
        year = jsonResults['birthdate'].split("-")[0];
        month = jsonResults['birthdate'].split("-")[1];
        day= jsonResults['birthdate'].split("-")[2];
      }
     
      SharedPrefs.setToken(jsonBody['token']);
      User user = User.fromJson(jsonResults);
      SharedPrefs.setUserId(jsonResults['id']);
      //  SharedPrefs.setUserAddress(jsonResults['address']);
      SharedPrefs.setUserBirth("$day/$month/$year");
      SharedPrefs.setUserEmail(user.email!);
      SharedPrefs.setUserName(user.firstName!);
      SharedPrefs.setUserLastName(user.lastName!);
      SharedPrefs.setUserPhone(phone);
      SharedPrefs.login();

      List<User> users = [];
      users.add(user);
      return users;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<String>> changePassword(
      String oldPassword, String newPassword) async {
    String json =
        '{"old_password": "$oldPassword", "new_password": "$newPassword"}';
    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/change-password/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    if (response.statusCode == 200) {
      //  SharedPrefs.setUserAddress(jsonResults['address']);
      // SharedPrefs.setUserBirth(jsonResults['birthday'] == null
      //     ? "yyyy-mm-dd"
      //     : "${jsonResults['birthday']}");
      // SharedPrefs.setUserEmail(user.email!);
      // SharedPrefs.setUserName(user.firstName!);
      // SharedPrefs.setUserLastName(user.lastName!);
      // SharedPrefs.setUserPhone(phone);
      // SharedPrefs.login();

      List<String> users = [];
      return users;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<String>> deleteAccountUser(String deletionReason) async {
    String json = '{"deletion_reason": "$deletionReason"}';
    final response = await http.delete(
      Uri.parse(
        ("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/user-deletion/"),
      ),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );

    if (response.statusCode == 200) {
      // SharedPrefs.setUserPassword(password);

      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  Future<User> getUser(int id) async {
    final response = await http.get(
      Uri.parse("$url$id/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      User user = User.fromJson(jsonBody);
      return user;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
