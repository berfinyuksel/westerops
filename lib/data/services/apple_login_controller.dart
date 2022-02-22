import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/constants/url_constant.dart';
import '../model/auth_token.dart';
import '../shared/shared_prefs.dart';

class AppleSignInController with ChangeNotifier {
  Map? userData;

  login() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print(credential);
    notifyListeners();
  }

  logOut() async {
    notifyListeners();
  }
}
