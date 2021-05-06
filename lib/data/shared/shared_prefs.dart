import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;
  static initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> onboardingShown() async {
    _prefs.setBool('onboarding', true);
  }

  static Future<void> login() async {
    _prefs.setBool('login', true);
  }

  static Future<void> setToken(String token) async {
    _prefs.setString('token', token);
  }

  static Future<void> clearCache() async {
    _prefs.clear();
  }

  static bool get getIsLogined => _prefs.getBool('login') ?? false;
  static bool get getIsOnboardingShown => _prefs.getBool('onboarding') ?? false;
  static String get getToken => _prefs.getString('token') ?? "";
}
