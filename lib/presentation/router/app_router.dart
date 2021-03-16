import 'package:dongu_mobile/presentation/screens/onboarding_first_view/onboarding_first_view.dart';
import 'package:dongu_mobile/presentation/screens/onboarding_view/onboarding_view.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/location_view/location.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/notification_view/notification.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ONBOARDING_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case RouteConstant.ONBOARDING_FIRST_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingFirstView());
      case RouteConstant.NOTIFICATION_PERMISSON_VIEW:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case RouteConstant.LOCATION_PERMISSON_VIEW:
        return MaterialPageRoute(builder: (_) => LocationView());
      default:
        return null;
    }
  }
}
