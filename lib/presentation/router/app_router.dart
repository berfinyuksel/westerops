import 'package:dongu_mobile/presentation/screens/address_update_view/address_update_view.dart';
import 'package:dongu_mobile/presentation/screens/freeze_account_view/freeze_account_view.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/about_working_hours/about_working_hours_view.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/store_info_view/store_info_view.dart';
import 'package:dongu_mobile/presentation/screens/splash_view/splash_view.dart';
import 'package:dongu_mobile/presentation/screens/swipe_view/swipe_view.dart';
import 'package:dongu_mobile/presentation/screens/was_delivered_view/was_delivered_view.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../data/shared/shared_prefs.dart';
import '../../utils/constants/route_constant.dart';
import '../screens/about_app_view/about_app_view.dart';
import '../screens/address_detail_view/address_detail_view.dart';
import '../screens/address_detail_view/string_arguments/string_arguments.dart';
import '../screens/address_from_map_view/address_from_map_view.dart';
import '../screens/address_view/address_view.dart';
import '../screens/agreement_kvkk_view/agreement_kvkk_view.dart';
import '../screens/agreement_view/agreement_view.dart';
import '../screens/cart_view/cart_view.dart';
import '../screens/change_location_view/change_location_view.dart';
import '../screens/change_password_view/change_password_view.dart';
import '../screens/contact_view/contact_view.dart';
import '../screens/delete_account_view/delete_account_view.dart';
import '../screens/filter_view/filter_view.dart';
import '../screens/food_waste_views/food_waste_expanded_view.dart';
import '../screens/food_waste_views/food_waste_view.dart';
import '../screens/forgot_password_view/forgot_password_view.dart';
import '../screens/general_settings_view/general_settings_view.dart';
import '../screens/help_center_view/help_center_view.dart';
import '../screens/home_page_view/home_page_view.dart';
import '../screens/language_settings_view/language_settings_view.dart';
import '../screens/login_view/login_view.dart';
import '../screens/my_favorites_view/my_favorites_view.dart';
import '../screens/my_information_view/my_information_view.dart';
import '../screens/my_near_view/my_near_view.dart';
import '../screens/onboardings_view/onboardings_view.dart';
import '../screens/order_delivered_view/order_delivered_view.dart';
import '../screens/order_received_view/order_received_view.dart';
import '../screens/order_receiving_view/order_receiving_view.dart';
import '../screens/past_order_detail_view/past_order_detail_view.dart';
import '../screens/past_order_view/past_order_view.dart';
import '../screens/payment_views/payment_views.dart';
import '../screens/permissions_views/location_view/location.dart';
import '../screens/permissions_views/notification_view/notification.dart';
import '../screens/register_view/register_view.dart';
import '../screens/restaurant_details_views/food_categories/food_categories_view.dart';
import '../screens/restaurant_details_views/restaurant_detail_view/restaurant_detail_view.dart';
import '../screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../screens/search_view/search.dart';
import '../screens/surprise_pack_canceled_view/surprise_pack_canceled_view.dart';
import '../screens/surprise_pack_view/surprise_pack_view.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ABOUT_APP_VIEW:
        return MaterialPageRoute(builder: (_) => AboutAppView());
      case RouteConstant.ADDRESS_UPDATE_VIEW:
        final ScreenArguments args = routeSettings.arguments as ScreenArguments;

        return MaterialPageRoute(
          builder: (_) => AddressUpdateView(
            addressList: args.list!,
          ),
        );
      case RouteConstant.ADDRESS_DETAIL_VIEW:
        final ScreenArguments args = routeSettings.arguments as ScreenArguments;

        return MaterialPageRoute(
          builder: (_) => AddressDetailView(
            title: args.title!,
            address: args.description!,
            district: args.district!,
          ),
        );
      case RouteConstant.ADDRESS_FROM_MAP_VIEW:
        return MaterialPageRoute(builder: (_) => AddressFromMapView());
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
      case RouteConstant.CUSTOM_SCAFFOLD:
        return MaterialPageRoute(builder: (_) => CustomScaffold());
      case RouteConstant.DELETE_ACCOUNT_VIEW:
        return MaterialPageRoute(builder: (_) => DeleteAccountView());
      case RouteConstant.FILTER_VIEW:
        return MaterialPageRoute(builder: (_) => FilterView());
      case RouteConstant.FREEZE_ACCOUNT_VIEW:
        return MaterialPageRoute(builder: (_) => FreezeAccountView());
      case RouteConstant.FOOD_CATEGORIES_VIEW:
        return MaterialPageRoute(builder: (_) => FoodCategories());
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
        return MaterialPageRoute(
            builder: (_) => SharedPrefs.getIsOnboardingShown
                ? CustomScaffold()
                : OnboardingsView());
      case RouteConstant.ORDER_DELIVERED_VIEW:
        return MaterialPageRoute(builder: (_) => OrderDeliveredView());
      case RouteConstant.ORDER_RECEIVED_VIEW:
        return MaterialPageRoute(builder: (_) => OrderReceivedView());
      case RouteConstant.ORDER_RECEIVING_VIEW:
        return MaterialPageRoute(builder: (_) => OrderReceivingView());
      case RouteConstant.PAST_ORDER_DETAIL_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderDetailView());
      case RouteConstant.ABOUT_WORKING_HOUR_VIEW:
        return MaterialPageRoute(builder: (_) => AboutWorkingHourView());
      case RouteConstant.PAST_ORDER_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderView());
      case RouteConstant.PAYMENTS_VIEW:
        return MaterialPageRoute(builder: (_) => PaymentViews());
      case RouteConstant.REGISTER_VIEW:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RouteConstant.RESTAURANT_DETAIL:
        final ScreenArgumentsRestaurantDetail args =
            routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => RestaurantDetailView(
            restaurant: args.restaurant,
          ),
        );
      // case RouteConstant.SEARCH_VIEW:
      //   return MaterialPageRoute(builder: (_) => SearchView());
      case RouteConstant.SURPRISE_PACK_CANCELED_VIEW:
        return MaterialPageRoute(builder: (_) => SurprisePackCanceled());
      case RouteConstant.SURPRISE_PACK_VIEW:
        return MaterialPageRoute(builder: (_) => SurprisePackView());
      case RouteConstant.SPLASH_VIEW:
        return MaterialPageRoute(
            builder: (_) => SharedPrefs.getIsOnboardingShown
                ? CustomScaffold()
                : SplashView());
      case RouteConstant.SPLASH_VIEW:
        return MaterialPageRoute(
            builder: (_) => SharedPrefs.getIsOnboardingShown
                ? CustomScaffold()
                : SplashView());
      case RouteConstant.SWIPE_VIEW:
        return MaterialPageRoute(builder: (_) => SwipeView());
      case RouteConstant.WAS_DELIVERED_VIEW:
        return MaterialPageRoute(builder: (_) => WasDeliveredView());
      case RouteConstant.STORE_INFO_VIEW:
        return MaterialPageRoute(builder: (_) => StoreInfoView());
      default:
        return null;
    }
  }
}
