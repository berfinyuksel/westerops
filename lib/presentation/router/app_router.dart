import 'package:dongu_mobile/presentation/screens/address_view/address_view.dart';
import 'package:dongu_mobile/presentation/screens/agreement_view/agreement_view.dart';
import 'package:dongu_mobile/presentation/screens/change_password_view/change_password_view.dart';
import 'package:dongu_mobile/presentation/screens/filter_view/filter_view.dart';
import 'package:dongu_mobile/presentation/screens/food_waste_views/food_waste_expanded_view.dart';
import 'package:dongu_mobile/presentation/screens/food_waste_views/food_waste_view.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/language_settings_view/language_settings_view.dart';
import 'package:dongu_mobile/presentation/screens/login_view/login_view.dart';
import 'package:dongu_mobile/presentation/screens/my_information_view/my_information_view.dart';
import 'package:dongu_mobile/presentation/screens/onboardings_view/onboardings_view.dart';
import 'package:dongu_mobile/presentation/screens/past_order_view/past_order_view.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/location_view/location.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/notification_view/notification.dart';
import 'package:dongu_mobile/presentation/screens/register_view/register_view.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ONBOARDINGS_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingsView());
      case RouteConstant.ADDRESS_VIEW:
        return MaterialPageRoute(builder: (_) => AddressView());
      case RouteConstant.AGREEMENT_VIEW:
        return MaterialPageRoute(builder: (_) => AgreementView());
      case RouteConstant.CHANGE_PASSWORD_VIEW:
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case RouteConstant.FILTER_VIEW:
        return MaterialPageRoute(builder: (_) => FilterView());
      case RouteConstant.FOOD_WASTE_VIEW:
        return MaterialPageRoute(builder: (_) => FoodWasteView());
      case RouteConstant.FOOD_WASTE_EXPANDED_VIEW:
        return MaterialPageRoute(builder: (_) => FoodWasteExpandedView());
      case RouteConstant.FORGOT_PASSWORD_VIEW:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case RouteConstant.LANGUAGE_SETTINGS_VIEW:
        return MaterialPageRoute(builder: (_) => LanguageSettingsView());
      case RouteConstant.LOGIN_VIEW:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RouteConstant.MY_INFORMATION_VIEW:
        return MaterialPageRoute(builder: (_) => MyInformationView());
      case RouteConstant.PAST_ORDER_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderView());
      case RouteConstant.LOCATION_VIEW:
        return MaterialPageRoute(builder: (_) => LocationView());
      case RouteConstant.NOTIFICATION_VIEW:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case RouteConstant.REGISTER_VIEW:
        return MaterialPageRoute(builder: (_) => RegisterView());

      default:
        return null;
    }
  }
}
