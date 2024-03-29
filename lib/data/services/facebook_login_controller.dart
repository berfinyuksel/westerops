import 'dart:convert';

import 'package:dongu_mobile/logic/cubits/login_status_cubit/login_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/url_constant.dart';
import '../model/auth_token.dart';
import '../shared/shared_prefs.dart';
import 'locator.dart';

class FacebookSignInController with ChangeNotifier {
  Map? userData;

  login() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name",
      );
      userData = requestData;
      final AccessToken accessToken = result.accessToken!;

      SharedPrefs.setUserEmail(userData!["email"]);
      SharedPrefs.setUserName(userData!["name"]);

      String json = '{"auth_token":"${accessToken.token.toString()}"}';
      final response = await http.post(
          Uri.parse("${UrlConstant.EN_URL}social_auth/facebook/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);

      sl<LoginStatusCubit>().loginStatus(response.statusCode);
      if (response.statusCode == 200) {
        SharedPrefs.setSocialLogin(true);
        final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        var authtokenList = AuthToken.fromJson(jsonBody);
        SharedPrefs.setToken(jsonBody['token']);

        SharedPrefs.setUserId(jsonBody["user"]['id']);
        //  SharedPrefs.setUserAddress(jsonResults['address']);
        SharedPrefs.setUserBirth(jsonBody["user"]['birthday'] == null
            ? "dd/mm/yyyy"
            : "${jsonBody['birthday']}");
        SharedPrefs.setUserEmail(jsonBody["user"]["email"]);
        SharedPrefs.setUserName(jsonBody["user"]["first_name"]);
        SharedPrefs.setUserLastName(jsonBody["user"]["last_name"]);
        SharedPrefs.setUserPhone(jsonBody["user"]["phone_number"] ?? "");
        SharedPrefs.login();
        List<AuthToken> result = [];
        result.add(authtokenList);
        return result;
      }

      notifyListeners();
    }
  }

  logOut() async {
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }
}
