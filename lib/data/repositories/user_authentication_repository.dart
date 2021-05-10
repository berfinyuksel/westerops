import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/user.dart';
import '../shared/shared_prefs.dart';

abstract class UserAuthenticationRepository {
  Future<List<User>> registerUser(String firstName, String lastName, String email, String phone, String password);
  Future<List<String>> updateUser(String firstName, String lastName, String email, String phone);
  Future<List<User>> loginUser(String email, String password);
}

class SampleUserAuthenticationRepository implements UserAuthenticationRepository {
  final url = "${UrlConstant.EN_URL}user/";
  final urlUpdate = "${UrlConstant.EN_URL}user/${SharedPrefs.getUserId}/";
  final urlLogin = "${UrlConstant.EN_URL}user/login/";

  @override
  Future<List<User>> registerUser(String firstName, String lastName, String email, String phone, String password) async {
    String json =
        '{"first_name":"$firstName","last_name":"$lastName","email": "$email", "password": "$password","password2": "$password","phone_number": "$phone"}';
    final response = await http.post(
      Uri.parse(url),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      return loginUser(phone, password);
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<String>> updateUser(String firstName, String lastName, String email, String phone) async {
    String json = '{"first_name":"$firstName","last_name":"$lastName","email": "$email","phone_number": "$phone"}';
    final response = await http.put(
      Uri.parse(urlUpdate),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      SharedPrefs.setUserEmail(email);
      SharedPrefs.setUserName(firstName);
      SharedPrefs.setUserLastName(lastName);
      SharedPrefs.setUserPhone(phone);
      List<String> result = [];
      return result;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }

  @override
  Future<List<User>> loginUser(String phone, String password) async {
    String json = '{"phone_number": "$phone", "password": "$password"}';
    final response = await http.post(
      Uri.parse(urlLogin),
      body: json,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      var jsonResults = jsonBody['user'];
      SharedPrefs.setToken(jsonBody['token']);

      User user = User.fromJson(jsonResults);
      SharedPrefs.setUserId(jsonResults['id']);
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
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
