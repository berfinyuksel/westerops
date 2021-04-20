import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  GoogleSignInAccount? currentUser;
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<AccessToken?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // get the user data
      // by default we get the userId, email,name and picture
      final userData = await FacebookAuth.instance.getUserData();
      print(userData);
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
  }

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
