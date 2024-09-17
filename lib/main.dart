import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/application_theme_manager.dart';

import 'core/page_route_names.dart';
import 'core/page_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'News App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ApplicationThemeManager.lightTheme,
      initialRoute: PageRouteNames.init,
      onGenerateRoute: PageRouter.onGenerateRoute,
    );
  }
}
