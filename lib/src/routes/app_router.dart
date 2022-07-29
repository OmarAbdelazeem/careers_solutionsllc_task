import 'package:careers_solutionsllc_task/src/presentation/screens/home_screen/home_screen.dart';
import 'package:careers_solutionsllc_task/src/presentation/screens/weight_screen/edit_weight_screen.dart';
import 'package:careers_solutionsllc_task/src/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/auth_screen/auth_screen.dart';
import '../presentation/screens/splash_screen/splash_screen.dart';
import '../presentation/screens/unknown_route_screen.dart';

class AppRouter {
  // AppRouter._();

   Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return _customMaterialPageRoute(const SplashScreen(), settings);
      case AppRoutes.homeScreen:
        return _customMaterialPageRoute(const HomeScreen(), settings);
      case AppRoutes.authScreen:
        return _customMaterialPageRoute( AuthScreen(), settings);
        case AppRoutes.editWeightScreen:
        return _customMaterialPageRoute(const EditWeightScreen(), settings);
        case AppRoutes.addWeightScreen:
        return _customMaterialPageRoute( AuthScreen(), settings);
      default:
        return _customMaterialPageRoute(const UnKnownRouteScreen(), settings);
    }
  }

   MaterialPageRoute _customMaterialPageRoute(Widget widget,
          [RouteSettings? settings]) =>
      MaterialPageRoute(builder: (context) => widget, settings: settings);
}
