import 'package:dongu_mobile/presentation/screens/onboardings_view/onboardings_view.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteConstant.ONBOARDINGS_VIEW:
        return MaterialPageRoute(builder: (_) => OnboardingsView());

      default:
        return null;
    }
  }
}
