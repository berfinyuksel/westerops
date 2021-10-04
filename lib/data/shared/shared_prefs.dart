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

  static Future<void> setUserPassword(String password) async {
    _prefs.setString('userPassword', password);
  }

  static Future<void> clearCache() async {
    _prefs.clear();
  }

  static Future<void> setCounter(int counter) async {
    _prefs.setInt('counter', counter);
  }

  static Future<void> setMenuId(int menuId) async {
    _prefs.setInt('menuId', menuId);
  }

  static Future<List<String>> setMenuList(List<String> menuList) async {
    _prefs.setStringList('menuList', menuList);
    return menuList;
  }

  static bool get getIsLogined => _prefs.getBool('login') ?? false;
  static bool get getIsOnboardingShown => _prefs.getBool('onboarding') ?? false;
  static String get getToken => _prefs.getString('token') ?? "";
  static int get getUserId => _prefs.getInt('userId') ?? 0;
  static String get getUserEmail => _prefs.getString('userEmail') ?? "";
  static String get getUserPhone => _prefs.getString('userPhone') ?? "";
  static String get getUserName => _prefs.getString('userName') ?? "";
  static String get getUserBirth =>
      _prefs.getString('userBirth') ?? "dd-mm-yyyy";
  static String get getUserAddress =>
      _prefs.getString('userAddress') ?? "Adana";
  static String get getUserLastName => _prefs.getString('userLastName') ?? "";
  static String get getUserPassword => _prefs.getString('userPassword') ?? "";
  static int get getCounter => _prefs.getInt('counter') ?? 0;
  static int get getMenuId => _prefs.getInt('menuId') ?? 0;
  static List<String> get getMenuList => _prefs.getStringList('menuList') ?? [];
}
