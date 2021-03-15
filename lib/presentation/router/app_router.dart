import 'package:dongu_mobile/presentation/screens/onboardings_view/onboarding_view/onboarding_view.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ONBOARDING_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingView());

      default:
        return null;
    }
  }
}
