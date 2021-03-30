//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleSignInAccount? currentUser;

  static Future<AccessToken?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by the fault we request the email and the public profile
    if (result.status == LoginStatus.success) {
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      print(userData);
      return result.accessToken;
    }

    print(result.status);
    print(result.message);
    return null;
  }

  /*static Future<void> loginWithFacebook() async {
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
      print(googleSignIn.currentUser!.email);
    } catch (error) {
      print(error);
    }
  }
}
