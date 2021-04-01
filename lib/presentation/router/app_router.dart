import 'package:dongu_mobile/presentation/screens/about_app_view/about_app_view.dart';
import 'package:dongu_mobile/presentation/screens/address_view/address_view.dart';
import 'package:dongu_mobile/presentation/screens/agreement_kvkk_view/agreement_kvkk_view.dart';
import 'package:dongu_mobile/presentation/screens/agreement_view/agreement_view.dart';
import 'package:dongu_mobile/presentation/screens/cart_view/cart_view.dart';
import 'package:dongu_mobile/presentation/screens/change_location_view/change_location_view.dart';
import 'package:dongu_mobile/presentation/screens/change_password_view/change_password_view.dart';
import 'package:dongu_mobile/presentation/screens/contact_view/contact_view.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/filter_view.dart';
import 'package:dongu_mobile/presentation/screens/food_waste_views/food_waste_expanded_view.dart';
import 'package:dongu_mobile/presentation/screens/food_waste_views/food_waste_view.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/general_settings_view/general_settings_view.dart';
import 'package:dongu_mobile/presentation/screens/help_center_view/help_center_view.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/home_page_view.dart';
import 'package:dongu_mobile/presentation/screens/language_settings_view/language_settings_view.dart';
import 'package:dongu_mobile/presentation/screens/login_view/login_view.dart';
import 'package:dongu_mobile/presentation/screens/my_favorites_view/my_favorites_view.dart';
import 'package:dongu_mobile/presentation/screens/my_information_view/my_information_view.dart';
import 'package:dongu_mobile/presentation/screens/my_near_view/my_near_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboardings_view.dart';
import 'package:dongu_mobile/presentation/screens/past_order_detail_view/past_order_detail_view.dart';
import 'package:dongu_mobile/presentation/screens/past_order_view/past_order_view.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_views.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/location_view/location.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/notification_view/notification.dart';
import 'package:dongu_mobile/presentation/screens/register_view/register_view.dart';
import 'package:dongu_mobile/presentation/screens/search_view/search.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ABOUT_APP_VIEW:
        return MaterialPageRoute(builder: (_) => AboutAppView());
      case RouteConstant.ADDRESS_VIEW:
        return MaterialPageRoute(builder: (_) => AddressView());
      case RouteConstant.AGREEMENT_KVKK_VIEW:
        return MaterialPageRoute(builder: (_) => AgreementKvkkView());
      case RouteConstant.AGREEMENT_VIEW:
        return MaterialPageRoute(builder: (_) => AgreementView());
      case RouteConstant.CART_VIEW:
        return MaterialPageRoute(builder: (_) => CartView());
      case RouteConstant.CHANGE_LOCATION_VIEW:
        return MaterialPageRoute(builder: (_) => ChangeLocationView());
      case RouteConstant.CHANGE_PASSWORD_VIEW:
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case RouteConstant.CONTACT_VIEW:
        return MaterialPageRoute(builder: (_) => ContactView());
      case RouteConstant.FILTER_VIEW:
        return MaterialPageRoute(builder: (_) => FilterView());
      case RouteConstant.FOOD_WASTE_EXPANDED_VIEW:
        return MaterialPageRoute(builder: (_) => FoodWasteExpandedView());
      case RouteConstant.FOOD_WASTE_VIEW:
        return MaterialPageRoute(builder: (_) => FoodWasteView());
      case RouteConstant.FORGOT_PASSWORD_VIEW:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case RouteConstant.GENERAL_SETTINGS_VIEW:
        return MaterialPageRoute(builder: (_) => GeneralSettingsView());
      case RouteConstant.HELP_CENTER_VIEW:
        return MaterialPageRoute(builder: (_) => HelpCenterView());
      case RouteConstant.HOME_PAGE_VIEW:
        return MaterialPageRoute(builder: (_) => HomePageView());
      case RouteConstant.LANGUAGE_SETTINGS_VIEW:
        return MaterialPageRoute(builder: (_) => LanguageSettingsView());
      case RouteConstant.LOCATION_VIEW:
        return MaterialPageRoute(builder: (_) => LocationView());
      case RouteConstant.LOGIN_VIEW:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RouteConstant.MY_FAVORITES_VIEW:
        return MaterialPageRoute(builder: (_) => MyFavoritesView());
      case RouteConstant.MY_INFORMATION_VIEW:
        return MaterialPageRoute(builder: (_) => MyInformationView());
      case RouteConstant.MY_NEAR_VIEW:
        return MaterialPageRoute(builder: (_) => MyNearView());
      case RouteConstant.NOTIFICATION_VIEW:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case RouteConstant.ONBOARDINGS_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingsView());
      case RouteConstant.PAST_ORDER_DETAIL_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderDetailView());
      case RouteConstant.PAST_ORDER_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderView());
      case RouteConstant.PAYMENTS_VIEW:
        return MaterialPageRoute(builder: (_) => PaymentViews());
      case RouteConstant.MY_INFORMATION_VIEW:
        return MaterialPageRoute(builder: (_) => MyInformationView());
      case RouteConstant.REGISTER_VIEW:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RouteConstant.RESTAURANT_DETAIL:
        return MaterialPageRoute(builder: (_) => Text(""));
      case RouteConstant.SEARCH_VIEW:
        return MaterialPageRoute(builder: (_) => SearchView());

      default:
        return null;
    }
  }
}
