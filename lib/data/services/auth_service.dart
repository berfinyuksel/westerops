import 'dart:convert';

import 'package:dongu_mobile/data/model/auth_token.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/url_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static Future<void> loginWithGmail() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
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
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignIn.currentUser!.authentication;
      // SharedPrefs.setToken(googleSignInAuthentication.idToken!);
      print("token: " + googleSignInAuthentication.idToken!);
    } catch (error) {
      print(error);
    }
  }

  Future postGoogleToken() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignIn.currentUser!.authentication;
    String json = '{"auth_token":"$googleSignInAuthentication.idToken"}';
    final response = await http
        .post(Uri.parse("${UrlConstant.EN_URL}social_auth/google"), body: json);
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
      List<AuthToken> authToken = List<AuthToken>.from(
          jsonBody.map((model) => AuthToken.fromJson(model)));
      SharedPrefs.setUserName(googleSignIn.currentUser!.displayName.toString());
      return authToken;
    }
    throw NetworkError(response.statusCode.toString(), response.body);
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;
  NetworkError(this.statusCode, this.message);
}
