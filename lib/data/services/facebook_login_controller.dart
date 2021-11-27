import 'package:dongu_mobile/data/model/auth_token.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/social_login_cubit/social_login_cubit.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      print(userData);
      final AccessToken accessToken = result.accessToken!;
      print(accessToken.token.toString());
      SharedPrefs.setUserEmail(userData!["email"]);
      SharedPrefs.setUserName(userData!["name"]);

      String json = '{"auth_token":"${accessToken.token.toString()}"}';
      final response = await http.post(
          Uri.parse("${UrlConstant.EN_URL}social_auth/facebook/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json);
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        print(jsonBody);
        var authtokenList = AuthToken.fromJson(jsonBody);
        SharedPrefs.setToken(jsonBody['token']);

        SharedPrefs.setUserId(jsonBody["user"]['id']);
        //  SharedPrefs.setUserAddress(jsonResults['address']);
        SharedPrefs.setUserBirth(jsonBody["user"]['birthday'] == null
            ? "dd-mm-yyyy"
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
