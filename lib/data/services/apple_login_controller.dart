import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/constants/url_constant.dart';
import '../model/auth_token.dart';
import '../shared/shared_prefs.dart';

class AppleSignInController with ChangeNotifier {
  late AuthorizationCredentialAppleID userData;

  login() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    debugPrint(credential.authorizationCode);
    if (credential.authorizationCode.isNotEmpty) {
      userData = credential;
      final String accessToken = credential.authorizationCode;

      String json = '{"auth_token":"$accessToken"}';
      final response = await http.post(Uri.parse("${UrlConstant.EN_URL}social_auth/apple/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        debugPrint(jsonBody);
        var authtokenList = AuthToken.fromJson(jsonBody);
        SharedPrefs.setToken(jsonBody['token']);

        SharedPrefs.setUserId(jsonBody["user"]['id']);
        //  SharedPrefs.setUserAddress(jsonResults['address']);
        SharedPrefs.setUserBirth(jsonBody["user"]['birthday'] == null ? "dd/mm/yyyy" : "${jsonBody['birthday']}");
        SharedPrefs.setUserEmail(jsonBody["user"]["email"]);
        SharedPrefs.setUserName(jsonBody["user"]["first_name"]);
        SharedPrefs.setUserLastName(jsonBody["user"]["last_name"]);
        SharedPrefs.setUserPhone(jsonBody["user"]["phone_number"] ?? "");
        SharedPrefs.login();
        List<AuthToken> result = [];
        result.add(authtokenList);
        return result;
      }
    }
    notifyListeners();
  }

  logOut() async {
    notifyListeners();
  }
}
