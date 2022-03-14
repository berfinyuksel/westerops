import 'dart:convert';
import '../../logic/cubits/login_status_cubit/login_status_cubit.dart';
import '../model/auth_token.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'dart:developer';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

import 'locator.dart';

class AuthService {

  logOutFromGmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      await googleSignIn.disconnect();
    } catch (error) {
  
    }
  }

  loginWithGmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      await googleSignIn.signIn();
      SharedPrefs.setUserName(googleSignIn.currentUser!.displayName.toString());
      SharedPrefs.setUserLastName(googleSignIn.currentUser!.displayName.toString());
      SharedPrefs.setUserEmail(googleSignIn.currentUser!.email);
      //SharedPrefs.setUserPhone(googleSignIn.currentUser!);

     
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignIn.currentUser!.authentication;
      // SharedPrefs.setToken(googleSignInAuthentication.idToken!);

      log(googleSignInAuthentication.idToken!);
      String json = '{"auth_token":"${googleSignInAuthentication.idToken}"}';
      final response =
          await http.post(Uri.parse("${UrlConstant.EN_URL}social_auth/google/"), body: json, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      sl<LoginStatusCubit>().loginStatus(response.statusCode);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
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
      throw NetworkError(response.statusCode.toString(), response.body);
    } catch (error) {
    }
  }

  Future postGoogleToken() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignIn.currentUser!.authentication;
    String json = '{"auth_token":"$googleSignInAuthentication.idToken"}';
    final response = await http.post(Uri.parse("${UrlConstant.EN_URL}social_auth/google"), body: json);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<AuthToken> authToken = List<AuthToken>.from(jsonBody.map((model) => AuthToken.fromJson(model)));
      SharedPrefs.setUserName(googleSignIn.currentUser!.displayName.toString());
      return authToken;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
