import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/config/application_theme_manager.dart';
import 'package:news_app/core/settings_provider.dart';
import 'package:provider/provider.dart';

import 'core/config/page_route_names.dart';
import 'core/config/page_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ChangeNotifierProvider(
        create: (BuildContext context) => SettingsProvider(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'News App',
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ApplicationThemeManager.lightTheme,
      initialRoute: PageRouteNames.init,
      onGenerateRoute: PageRouter.onGenerateRoute,
    );
  }
}
