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

  static Future<void> setAddressName(String name) async {
    _prefs.setString('addressName', name);
  }

  static Future<void> setAddressType(int type) async {
    _prefs.setInt('addressType', type);
  }

  static Future<void> setAddress(String address) async {
    _prefs.setString('address', address);
  }

  static Future<void> setAddressDescription(String description) async {
    _prefs.setString('addressDescription', description);
  }

  static Future<void> setAddressCountry(String country) async {
    _prefs.setString('addressCountry', country);
  }

  static Future<void> setAddressCity(String city) async {
    _prefs.setString('addressCity', city);
  }

  static Future<void> setAddressProvince(String province) async {
    _prefs.setString('addressProvince', province);
  }

  static Future<void> setAddressTcknVkn(String tcknVkn) async {
    _prefs.setString('addressTcknVkn', tcknVkn);
  }

  static Future<void> setAddressPhoneNumber(String phoneNumber) async {
    _prefs.setString('addressPhoneNumber', phoneNumber);
  }

  static Future<void> setAddressLatitude(double latitude) async {
    _prefs.setDouble('addressLatitude', latitude);
  }

  static Future<void> setAddressLongitude(double longitude) async {
    _prefs.setDouble('addressLongitude', longitude);
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
  static String get getAdressName => _prefs.getString('addressName') ?? "";
  static int get getAddressType => _prefs.getInt('addressType') ?? 0;
  static String get getAddress => _prefs.getString('address') ?? "";
  static String get getAddressDescription =>
      _prefs.getString('addressDescription') ?? "";
  static String get getAddressCountry =>
      _prefs.getString('addressCountry') ?? "";
  static String get getAddressCity => _prefs.getString('addressCity') ?? "";
  static String get getAddressProvince =>
      _prefs.getString('addressProvince') ?? "";
  static String get getAddressTcknVkn =>
      _prefs.getString('addressTcknVkn') ?? "";
  static String get getAddressPhoneNumber =>
      _prefs.getString('addressPhoneNumber') ?? "";
  static double get getAddressLatitude =>
      _prefs.getDouble('addressLatitude') ?? 0.0;
  static double get getAddressLongitude =>
      _prefs.getDouble('addressLongitude') ?? 0.0;
}
