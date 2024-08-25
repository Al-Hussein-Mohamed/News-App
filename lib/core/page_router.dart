import 'package:flutter/material.dart';
import 'package:news_app/core/page_route_names.dart';
import 'package:news_app/features/home_view/home_view.dart';
import 'package:news_app/features/settings_view/settings_view.dart';
import 'package:news_app/features/splash_view/splash_view.dart';

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

      case PageRouteNames.settings:
        return MaterialPageRoute(
          builder: (context) => const SettingsView(),
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
