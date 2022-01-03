import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/user.dart';
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

    print(response.statusCode);
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
    String json =
        '{"first_name":"$firstName", "last_name": "$lastName", "email": "$email", "phone_number": "$phone"}'; // "birthdate": "$birthday"
    final response = await http.patch(
      Uri.parse("${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print(SharedPrefs.getUserPassword);
    print(response.statusCode);

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
    //print("RESET PASSWORD STATUS: ${json}");
    print("RESET PASSWORD STATUS: ${response.statusCode}");
    print("RESET PASSWORD STATUS: ${response.request}");
    print("RESET PASSWORD STATUS: ${response.toString()}");
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

    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      var jsonResults = jsonBody['user'];

      SharedPrefs.setToken(jsonBody['token']);

      User user = User.fromJson(jsonResults);
      SharedPrefs.setUserId(jsonResults['id']);
      //  SharedPrefs.setUserAddress(jsonResults['address']);
      SharedPrefs.setUserBirth(jsonResults['birthday'] == null
          ? "dd-mm-yyyy"
          : "${jsonResults['birthday']}");
      SharedPrefs.setUserEmail(user.email!);
      SharedPrefs.setUserName(user.firstName!);
      SharedPrefs.setUserLastName(user.lastName!);
      SharedPrefs.setUserPhone(phone);
      SharedPrefs.login();
      print("User ID: ${SharedPrefs.getUserId}");

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
    print(response.statusCode);
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
      print("User ID: ${SharedPrefs.getUserId}");

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
    print(response.statusCode);
    if (response.statusCode == 200) {
      // SharedPrefs.setUserPassword(password);

      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
/**  @override
  Future<List<String>> updateUser(String firstName, String lastName,
      String email, String phone, String address, String birthday) async {
    String json = '{"password":"$firstName"}';
    final response = await http.patch(
      Uri.parse("$urlUpdate${SharedPrefs.getUserId}/"),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'JWT ${SharedPrefs.getToken}'
      },
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      SharedPrefs.setUserEmail(email);
      SharedPrefs.setUserName(firstName);
      SharedPrefs.setUserLastName(lastName);
      SharedPrefs.setUserPhone(phone);
      SharedPrefs.setUserAddress(address);
      //SharedPrefs.setUserBirth(birthday);
      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
 */