import 'dart:convert';
import '../model/auth_token.dart';
import '../shared/shared_prefs.dart';
import '../../utils/constants/url_constant.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'dart:developer';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;

class AuthService {
  /*GoogleSignInAccount? currentUser;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<AccessToken?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
      print(result.accessToken!.token.toString());
      return result.accessToken;
    }

    print(result.status);
    print(result.message);
    return null;
  }

  static void registerUser(String email, String password, String phone, String name) async {
    final User? user = (await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    user!.updateProfile(displayName: name);
    /*FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (credential) async {
          await (FirebaseAuth.instance.currentUser!).updatePhoneNumber(credential);
          // either this occurs or the user needs to manually enter the SMS code
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, [forceResendingToken]) async {
          String? smsCode;
          // get the SMS code from the user somehow (probably using a text field)
          final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode!);
          await (FirebaseAuth.instance.currentUser!).updatePhoneNumber(credential);
        },
        codeAutoRetrievalTimeout: (String a) {});*/
  }*/

  logOutFromGmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      await googleSignIn.disconnect();
    } catch (error) {
      print(error);
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
      print(googleSignIn.currentUser!.displayName);
      SharedPrefs.setUserName(googleSignIn.currentUser!.displayName.toString());
      SharedPrefs.setUserLastName(googleSignIn.currentUser!.displayName.toString());
      SharedPrefs.setUserEmail(googleSignIn.currentUser!.email);
      //SharedPrefs.setUserPhone(googleSignIn.currentUser!);

      print(googleSignIn.currentUser!.email);
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignIn.currentUser!.authentication;
      // SharedPrefs.setToken(googleSignInAuthentication.idToken!);
      print(googleSignInAuthentication.idToken);

      log(googleSignInAuthentication.idToken!);
      String json = '{"auth_token":"${googleSignInAuthentication.idToken}"}';
      final response =
          await http.post(Uri.parse("${UrlConstant.EN_URL}social_auth/google/"), body: json, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        print(jsonBody);
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
      print(error);
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

    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<AuthToken> authToken = List<AuthToken>.from(jsonBody.map((model) => AuthToken.fromJson(model)));
      SharedPrefs.setUserName(googleSignIn.currentUser!.displayName.toString());
      return authToken;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}
