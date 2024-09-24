import 'package:flutter/material.dart';
import 'package:news_app/core/config/page_route_names.dart';
import 'package:news_app/features/splash_view/splash_view.dart';

import '../../features/home/home_view/home_view.dart';
import '../../features/web_view/web_view.dart';

class PageRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteNames.init:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );

      case PageRouteNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: settings,
        );

      case PageRouteNames.web:
        return MaterialPageRoute(
          builder: (context) => WebView(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
    }
  }
}
