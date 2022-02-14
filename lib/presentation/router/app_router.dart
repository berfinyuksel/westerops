import 'package:dongu_mobile/presentation/screens/change_password_view/verify_view_change_password.dart';
import 'package:dongu_mobile/presentation/screens/clarification_view/clarification_view.dart';
import 'package:dongu_mobile/presentation/screens/my_information_view/verify_information.dart';
import 'package:dongu_mobile/presentation/screens/order_receiving_view/order_receiving_registered_card.dart';
import 'package:dongu_mobile/presentation/screens/order_receiving_view/order_receiving_without3d.dart';
import 'package:dongu_mobile/presentation/screens/register_view/register_verify.dart';
import 'package:dongu_mobile/presentation/screens/sms_verify_view/sms_verify_view.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_canceled_view/components/screen_arguments_surprise_cancel.dart';
import 'package:flutter/material.dart';

import '../../data/shared/shared_prefs.dart';
import '../../utils/constants/route_constant.dart';
import '../screens/about_app_view/about_app_view.dart';
import '../screens/address_detail_view/address_detail_view.dart';
import '../screens/address_detail_view/string_arguments/string_arguments.dart';
import '../screens/address_from_map_view/address_from_map_view.dart';
import '../screens/address_update_view/address_update_view.dart';
import '../screens/address_view/address_view.dart';
import '../screens/agreement_kvkk_view/agreement_kvkk_view.dart';
import '../screens/agreement_view/agreement_view.dart';
import '../screens/cart_view/cart_view.dart';
import '../screens/categories_view/categories_view.dart';
import '../screens/categories_view/screen_arguments_categories/screen_arguments_categories.dart';
import '../screens/change_location_view/change_location_view.dart';
import '../screens/change_password_view/change_password_view.dart';
import '../screens/contact_view/contact_view.dart';
import '../screens/delete_account_view/delete_account_view.dart';
import '../screens/filter_view/filter_view.dart';
import '../screens/food_waste_views/food_waste_expanded_view.dart';
import '../screens/food_waste_views/food_waste_view.dart';
import '../screens/forgot_password_view/forgot_password_view.dart';
import '../screens/freeze_account_view/freeze_account_view.dart';
import '../screens/general_settings_view/general_settings_view.dart';
import '../screens/help_center_view/help_center_view.dart';
import '../screens/home_page_view/home_page_view.dart';
import '../screens/language_settings_view/language_settings_view.dart';
import '../screens/login_view/login_view.dart';
import '../screens/my_favorites_view/my_favorites_view.dart';
import '../screens/my_information_view/my_information_view.dart';
import '../screens/my_near_view/my_near_view.dart';
import '../screens/my_registered_cards_update_view/my_registered_cards_update_view.dart';
import '../screens/my_registered_cards_view/my_registered_cards_view.dart';
import '../screens/onboardings_view/onboardings_view.dart';
import '../screens/order_delivered_view/order_delivered_view.dart';
import '../screens/order_received_view/order_received_view.dart';
import '../screens/order_receiving_view/order_receiving_view_with3d.dart';
import '../screens/past_order_detail_view/past_order_detail_view.dart';
import '../screens/past_order_view/past_order_view.dart';
import '../screens/payment_views/payment_views.dart';
import '../screens/permissions_views/location_view/location.dart';
import '../screens/permissions_views/notification_view/notification.dart';
import '../screens/register_view/register_view.dart';
import '../screens/restaurant_details_views/about_working_hours/about_working_hours_view.dart';
import '../screens/restaurant_details_views/food_categories/food_categories_view.dart';
import '../screens/restaurant_details_views/restaurant_detail_view/restaurant_detail_view.dart';
import '../screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../screens/restaurant_details_views/store_info_view/store_info_view.dart';
import '../screens/splash_view/splash_view.dart';
import '../screens/surprise_pack_canceled_view/surprise_pack_canceled_view.dart';
import '../screens/surprise_pack_view/surprise_pack_view.dart';
import '../screens/swipe_view/swipe_view.dart';
import '../screens/was_delivered_view/was_delivered_view.dart';
import '../widgets/scaffold/custom_scaffold.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ABOUT_APP_VIEW:
        return MaterialPageRoute(builder: (_) => AboutAppView());
      case RouteConstant.ADDRESS_UPDATE_VIEW:
        final ScreenArguments args = routeSettings.arguments as ScreenArguments;

        return MaterialPageRoute(
          builder: (_) => AddressUpdateView(addressList: args.list!),
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
      case RouteConstant.CLARIFICATION_VIEW:
        return MaterialPageRoute(builder: (_) => ClarificationView());
      case RouteConstant.CONTACT_VIEW:
        return MaterialPageRoute(builder: (_) => ContactView());
      case RouteConstant.CUSTOM_SCAFFOLD:
        return MaterialPageRoute(builder: (_) => CustomScaffold());
      case RouteConstant.DELETE_ACCOUNT_VIEW:
        return MaterialPageRoute(builder: (_) => DeleteAccountView());
      case RouteConstant.MY_REGISTERED_CARD_VIEW:
        return MaterialPageRoute(builder: (_) => MyRegisteredCardsView());
      case RouteConstant.MY_REGISTERED_CARD_UPDATE_VIEW:
        return MaterialPageRoute(builder: (_) => MyRegisteredCardsUpdateView());
      case RouteConstant.FILTER_VIEW:
        return MaterialPageRoute(builder: (_) => FilterView());
      case RouteConstant.FREEZE_ACCOUNT_VIEW:
        return MaterialPageRoute(builder: (_) => FreezeAccountView());
      case RouteConstant.FOOD_CATEGORIES_VIEW:
        final ScreenArgumentsCategories args = routeSettings.arguments as ScreenArgumentsCategories;

        return MaterialPageRoute(builder: (_) => FoodCategories(categories: args.categoriesList));
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
      // case RouteConstant.LANGUAGE_SETTINGS_VIEW:
      //   return MaterialPageRoute(builder: (_) => LanguageSettingsView());
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
      case RouteConstant.CATEGORIES_VIEW:
        final ScreenArgumentsCategories args = routeSettings.arguments as ScreenArgumentsCategories;

        return MaterialPageRoute(
          builder: (_) => CategoriesView(
            category: args.categories,
          ),
        );
      case RouteConstant.ONBOARDINGS_VIEW:
        return MaterialPageRoute(
            builder: (_) => SharedPrefs.getIsOnboardingShown ? CustomScaffold() : OnboardingsView());
      case RouteConstant.ORDER_DELIVERED_VIEW:
        return MaterialPageRoute(builder: (_) => OrderDeliveredView());
      case RouteConstant.ORDER_RECEIVED_VIEW:
        return MaterialPageRoute(builder: (_) => OrderReceivedView());

      case RouteConstant.ORDER_RECEIVING_VIEW_WITH3D:
        return MaterialPageRoute(builder: (_) => OrderReceivingViewWith3D());

      case RouteConstant.ORDER_RECEIVING_VIEW_WITHOUT3D:
        return MaterialPageRoute(builder: (_) => OrderReceivingViewWithout3D());
      case RouteConstant.ORDER_RECEIVING_VIEW_REGISTERED_CARD:
        return MaterialPageRoute(builder: (_) => OrderReceivingViewWithRegisteredCard());
      case RouteConstant.PAST_ORDER_DETAIL_VIEW:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => PastOrderDetailView(
            orderInfo: args.orderInfo,
          ),
        );
      case RouteConstant.ABOUT_WORKING_HOUR_VIEW:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => AboutWorkingHourView(
            restaurant: args.restaurant,
          ),
        );
      case RouteConstant.PAST_ORDER_VIEW:
        return MaterialPageRoute(builder: (_) => PastOrderView());
      case RouteConstant.PAYMENTS_VIEW:
        return MaterialPageRoute(builder: (_) => PaymentViews());
      case RouteConstant.SMS_VERIFY_VIEW:
        return MaterialPageRoute(builder: (_) => SmsVerify());
      case RouteConstant.REGISTER_VERIFY_VIEW:
        return MaterialPageRoute(builder: (_) => RegisterVerify());
          case RouteConstant.CHANGE_PASSWORD_VERIFY:
        return MaterialPageRoute(builder: (_) => ChangePasswordVerify());
      case RouteConstant.VERIFY_INFORMATION:
        return MaterialPageRoute(builder: (_) => VerifyInformation());
      case RouteConstant.REGISTER_VIEW:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RouteConstant.RESTAURANT_DETAIL:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => RestaurantDetailView(
            restaurant: args.restaurant,
          ),
        );
      // case RouteConstant.SEARCH_VIEW:
      //   return MaterialPageRoute(builder: (_) => SearchView());
      case RouteConstant.SURPRISE_PACK_CANCELED_VIEW:
        final ScreenArgumentsSurpriseCancel args = routeSettings.arguments as ScreenArgumentsSurpriseCancel;

        return MaterialPageRoute(
          builder: (_) => SurprisePackCanceled(
            orderInfo: args.orderInfo,
          ),
        );
      case RouteConstant.SURPRISE_PACK_VIEW:
        return MaterialPageRoute(builder: (_) => SurprisePackView());
      case RouteConstant.SPLASH_VIEW:
        return MaterialPageRoute(builder: (_) => SplashView());
      // case RouteConstant.SPLASH_VIEW:
      //   return MaterialPageRoute(
      //       builder: (_) => SharedPrefs.getIsOnboardingShown
      //           ? CustomScaffold()
      //           : SplashView());
      case RouteConstant.SWIPE_VIEW:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => SwipeView(
            orderInfo: args.orderInfo,
          ),
        );
      case RouteConstant.WAS_DELIVERED_VIEW:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => WasDeliveredView(
            orderInfo: args.orderInfo,
          ),
        );
      case RouteConstant.STORE_INFO_VIEW:
        final ScreenArgumentsRestaurantDetail args = routeSettings.arguments as ScreenArgumentsRestaurantDetail;

        return MaterialPageRoute(
          builder: (_) => StoreInfoView(
            restaurant: args.restaurant,
          ),
        );
      default:
        return null;
    }
  }
}
