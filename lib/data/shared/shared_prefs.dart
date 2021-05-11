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

  static Future<void> setUserId(int userId) async {
    _prefs.setInt('userId', userId);
  }

  static Future<void> setUserEmail(String email) async {
    _prefs.setString('userEmail', email);
  }

  static Future<void> setUserPhone(String phone) async {
    _prefs.setString('userPhone', phone);
  }

  static Future<void> setUserName(String name) async {
    _prefs.setString('userName', name);
  }

  static Future<void> setUserAddress(String address) async {
    _prefs.setString('userAddress', address);
  }

  static Future<void> setUserBirth(String birth) async {
    _prefs.setString('userBirth', birth);
  }

  static Future<void> setUserLastName(String lastName) async {
    _prefs.setString('userLastName', lastName);
  }

  static Future<void> clearCache() async {
    _prefs.clear();
  }

  static bool get getIsLogined => _prefs.getBool('login') ?? false;
  static bool get getIsOnboardingShown => _prefs.getBool('onboarding') ?? false;
  static String get getToken => _prefs.getString('token') ?? "";
  static int get getUserId => _prefs.getInt('userId') ?? 0;
  static String get getUserEmail => _prefs.getString('userEmail') ?? "";
  static String get getUserPhone => _prefs.getString('userPhone') ?? "";
  static String get getUserName => _prefs.getString('userName') ?? "";
  static String get getUserBirth => _prefs.getString('userBirth') ?? "yyyy-mm-dd";
  static String get getUserAddress => _prefs.getString('userAddress') ?? "";
  static String get getUserLastName => _prefs.getString('userLastName') ?? "";
}
