import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;
  static initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> onboardingShown(bool isSeen) async {
    _prefs.setBool('onboarding', isSeen);
  }

  static Future<void> login() async {
    _prefs.setBool('login', true);
  }

  static Future<void> logoutControl() async {
    _prefs.setBool('login', false);
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

  static Future<void> setCounterNotifications(int counter) async {
    _prefs.setInt('notificationCounter', counter);
  }

  static Future<void> setMenuId(int menuId) async {
    _prefs.setInt('menuId', menuId);
  }

  static Future<List<String>> setMenuList(List<String> menuList) async {
    _prefs.setStringList('menuList', menuList);
    return menuList;
  }
  //my registered card info
  static Future<List<String>> setRegisterCards(List<String> cardsList) async {
    _prefs.setStringList('cardsList', cardsList);
    return cardsList;
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

  static Future<void> setDeliveredRestaurantAddressId(int id) async {
    _prefs.setInt('deliveredRestaurantId', id);
  }

  static Future<List<String>> setFavoriteIdList(List<String> favorites) async {
    _prefs.setStringList('favorites', favorites);
    return favorites;
  }

  //filters
  static Future<void> setSortByDistance(bool sortByDistance) async {
    _prefs.setBool('sortByDistance', sortByDistance);
  }

  static Future<void> setMyFavorites(String myFavorites) async {
    _prefs.setString('myFavorites', myFavorites);
  }

  static Future<void> setUserRating(String userRating) async {
    _prefs.setString('userRating', userRating);
  }

  static Future<void> setNewUser(String newUser) async {
    _prefs.setString('newUser', newUser);
  }

  static Future<void> setMinPrice(String minPrice) async {
    _prefs.setString('minPrice', minPrice);
  }

  static Future<void> setMaxPrice(String maxPrice) async {
    _prefs.setString('maxPrice', maxPrice);
  }

  static Future<void> setCourierHourId(int id) async {
    _prefs.setInt('courierHourId', id);
  }

  static Future<void> setOldSumPrice(int price) async {
    _prefs.setInt('oldSumOfPrice', price);
  }

  static Future<void> setSumPrice(int price) async {
    _prefs.setInt('sumOfPrice', price);
  }

  static Future<void> setDeliveryType(int deliveryType) async {
    _prefs.setInt('deliveryType', deliveryType);
  }

  static Future<void> setTimeIntervalForGetIt(
      String timeIntervalForGetIt) async {
    _prefs.setString('timeIntervalForGetIt', timeIntervalForGetIt);
  }

  static Future<void> setCountDownString(String countDownString) async {
    _prefs.setString('countDownString', countDownString);
  }

  static Future<void> setOrderBar(bool orderActive) async {
    _prefs.setBool('orderActive', orderActive);
  }

  static Future<void> setOrderRefCode(int orderRefCode) async {
    _prefs.setInt('orderRefCode', orderRefCode);
  }

  static Future<void> setBoxIdForDeliver(int boxIdForDeliver) async {
    _prefs.setInt('boxIdForDeliver', boxIdForDeliver);
  }

  static Future<void> setPermissionForEmail(
      bool updatePermissionForEmail) async {
    _prefs.setBool('updatePermissionForEmail', updatePermissionForEmail);
  }

  static Future<void> setPermissionForPhone(
      bool updatePermissionForPhone) async {
    _prefs.setBool('updatePermissionForPhone', updatePermissionForPhone);
  }

  static Future<void> setIpV4(String ipv4) async {
    _prefs.setString('ipv4', ipv4);
  }

  static Future<void> setBoolForRegisteredCard(
      bool boolForRegisteredCard) async {
    _prefs.setBool('boolForRegisteredCard', boolForRegisteredCard);
  }

  static Future<void> setCardToken(String cardToken) async {
    _prefs.setString('cardToken', cardToken);
  }

  static Future<void> setActiveAddressId(int activeAddressId) async {
    _prefs.setInt('activeAddressId', activeAddressId);
  }

  static Future<void> setCardRegisterBool(bool cardRegisterBool) async {
    _prefs.setBool('cardRegisterBool', cardRegisterBool);
  }

  static Future<void> setThreeDBool(bool threeDBool) async {
    _prefs.setBool('threeDBool', threeDBool);
  }

  static Future<void> setCardAlias(String cardAlias) async {
    _prefs.setString('cardAlias', cardAlias);
  }

  static Future<void> setCardHolderName(String cardHolderName) async {
    _prefs.setString('cardHolderName', cardHolderName);
  }

  static Future<void> setCardNumber(String cardNumber) async {
    _prefs.setString('cardNumber', cardNumber);
  }

  static Future<void> setExpireMonth(String expireMonth) async {
    _prefs.setString('expireMonth', expireMonth);
  }

  static Future<void> setExpireYear(String expireYear) async {
    _prefs.setString('expireYear', expireYear);
  }

  static Future<void> setCVC(String cvc) async {
    _prefs.setString('cvc', cvc);
  }

  static Future<void> setConversationId(String conversationId) async {
    _prefs.setString('conversationId', conversationId);
  }

  static Future<void> setCourierHourText(String courierHourText) async {
    _prefs.setString('courierHourText', courierHourText);
  }

  static Future<void> setNotificationsIsRead(bool isRead) async {
    _prefs.setBool('notificationsIsRead', isRead);
  }

  static Future<void> setRegisterPhone(String registerPhone) async {
    _prefs.setString('registerPhone', registerPhone);
  }
//change password
    static Future<void> setNewPassword(String newPassword) async {
    _prefs.setString('newPassword', newPassword);
  }
      static Future<void> setOldPassword(String oldPassword) async {
    _prefs.setString('oldPassword', oldPassword);
  }
  static bool get getIsLogined => _prefs.getBool('login') ?? false;
  static bool get getIsOnboardingShown => _prefs.getBool('onboarding') ?? false;
  static bool get getNotificationsIsRead =>
      _prefs.getBool('notificationsIsRead') ?? false;
  static String get getToken => _prefs.getString('token') ?? "";
  static int get getUserId => _prefs.getInt('userId') ?? 0;
  static int get getOldSumPrice => _prefs.getInt('oldSumOfPrice') ?? 0;
  static int get getSumPrice => _prefs.getInt('sumOfPrice') ?? 0;
  static String get getUserEmail => _prefs.getString('userEmail') ?? "";
  static String get getUserPhone => _prefs.getString('userPhone') ?? "";
  static String get getUserName => _prefs.getString('userName') ?? "";
  static String get getUserBirth =>
      _prefs.getString('userBirth') ?? "dd/mm/yyyy";
  static String get getUserAddress =>
      _prefs.getString('userAddress') ?? "İstanbul";
  static String get getUserLastName => _prefs.getString('userLastName') ?? "";
  static String get getUserPassword => _prefs.getString('userPassword') ?? "";
  static int get getCounter => _prefs.getInt('counter') ?? 0;
  static int get getNotificationCounter =>
      _prefs.getInt('notificationCounter') ?? 0;
  static int get getMenuId => _prefs.getInt('menuId') ?? 0;
  static List<String> get getMenuList => _prefs.getStringList('menuList') ?? [];
  static List<String> get getCardsList => _prefs.getStringList('cardsList') ?? [];
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
  static int get getDeliveredRestaurantAddressId =>
      _prefs.getInt('deliveredRestaurantId') ?? 0;
  static List<String> get getFavorites =>
      _prefs.getStringList('favorites') ?? [];
  static int get getCourierHourId => _prefs.getInt('courierHourId') ?? 0;
  static int get getDeliveryType => _prefs.getInt('deliveryType') ?? 0;
  static String get getTimeIntervalForGetIt =>
      _prefs.getString('timeIntervalForGetIt') ?? "";
  static String get getCountDownString =>
      _prefs.getString('countDownString') ?? "";
  static bool get getOrderBar => _prefs.getBool('orderActive') ?? false;
  static bool get getSortByDistance => _prefs.getBool('sortByDistance') ?? true;
  static String get getMyFavorites => _prefs.getString('myFavorites') ?? "";
  static String get getUserRating => _prefs.getString('userRating') ?? "";
  static String get getNewUser => _prefs.getString('newUser') ?? "";
  static String get getMinPrice => _prefs.getString('minPrice') ?? "";
  static String get getMaxPrice => _prefs.getString('maxPrice') ?? "";
  static int get getOrderRefCode => _prefs.getInt('orderRefCode') ?? 0;
  static int get getBoxIdForDeliver => _prefs.getInt('boxIdForDeliver') ?? 0;
  static bool get getPermissionForEmail =>
      _prefs.getBool('updatePermissionForEmail') ?? true;
  static bool get getPermissionForPhone =>
      _prefs.getBool('updatePermissionForPhone') ?? true;
  static String get getIpV4 => _prefs.getString('ipv4') ?? "";
  static bool get getBoolForRegisteredCard =>
      _prefs.getBool('boolForRegisteredCard') ?? false;
  static String get getCardToken => _prefs.getString('cardToken') ?? "";
  static int get getActiveAddressId => _prefs.getInt('activeAddressId') ?? 0;
  static bool get getCardRegisterBool =>
      _prefs.getBool('cardRegisterBool') ?? false;
  static bool get getThreeDBool => _prefs.getBool('threeDBool') ?? true;
  static String get getCardAlias => _prefs.getString('cardAlias') ?? "";
  static String get getCardHolderName =>
      _prefs.getString('cardHolderName') ?? "";
  static String get getCardNumber => _prefs.getString('cardNumber') ?? "";
  static String get getExpireMonth => _prefs.getString('expireMonth') ?? "";
  static String get getExpireYear => _prefs.getString('expireYear') ?? "";
  static String get getCVC => _prefs.getString('cvc') ?? "";
  static String get getConversationId =>
      _prefs.getString('conversationId') ?? "";
  static String get getCourierHourText =>
      _prefs.getString('courierHourText') ?? "";
  static String get getRegisterPhone => _prefs.getString('registerPhone') ?? "";
  static String get getNewCardNumber => _prefs.getString('newCardNumber') ?? "";
  static String get getNewPassword => _prefs.getString('newPassword') ?? "";
  static String get getOldPassword => _prefs.getString('oldPassword') ?? "";
}
