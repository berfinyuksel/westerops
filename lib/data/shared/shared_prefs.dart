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

  static Future<void> clearCache() async {
    _prefs.clear();
  }

  static bool get getIsLogined => _prefs.getBool('login') ?? false;
  static bool get getIsOnboardingShown => _prefs.getBool('onboarding') ?? false;
}
