import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/config/application_theme_manager.dart';
import 'package:news_app/core/settings_provider.dart';
import 'package:news_app/features/home/home_manager/home_cubit.dart';
import 'package:news_app/features/title/title_manager/title_cubit.dart';
import 'package:provider/provider.dart';

import 'core/config/page_route_names.dart';
import 'core/config/page_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/article/article_manager/article_cubit.dart';
import 'features/source_bar/source_manager/source_cubit.dart';

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
    return MultiProvider(
      providers: [
        BlocProvider<SourceCubit>(
          create: (context) => SourceCubit(),
        ),
        BlocProvider<ArticleCubit>(
          create: (context) => ArticleCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<TitleCubit>(
          create: (context) => TitleCubit(),
        )
      ],
      child: MaterialApp(
        title: 'News App',
        locale: Locale(provider.currentLanguage),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: ApplicationThemeManager.lightTheme,
        initialRoute: PageRouteNames.init,
        onGenerateRoute: PageRouter.onGenerateRoute,
      ),
    );
  }
}
