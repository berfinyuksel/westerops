import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  static Future<void> loginWithFacebook() async {
    try {
      AccessToken accessToken = (await FacebookAuth.instance.login());
      print(accessToken.toJson());
      // get the user data
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
    } on FacebookAuthException catch (e) {
      switch (e.errorCode) {
        case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
          print("You have a previous login operation in progress");
          break;
        case FacebookAuthErrorCode.CANCELLED:
          print("login cancelled");
          break;
        case FacebookAuthErrorCode.FAILED:
          print("login failed");
          break;
      }
    }
  }
}
