import 'package:dongu_mobile/presentation/screens/onboardings_view/onboardings_view.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ONBOARDINGS_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingsView());

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
