import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../configuration/color_palette.dart';
import '../../core/page_route_names.dart';

class DrawerView extends StatelessWidget {
  void Function() categoryDrawBarOnClicked;

  DrawerView(this.categoryDrawBarOnClicked, {super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Container(
      height: screenHeight,
      width: screenWidth * .7,
      color: Colors.white,
      child: Column(children: [
        Container(
          height: screenHeight * .2,
          color: ColorPalette.primaryColor,
          child: Center(
            child: Text(
              "${lang.newsApp}!",
              style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 45,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            categoryDrawBarOnClicked();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              const Icon(
                Icons.view_list,
                size: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                lang.category,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 28),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, PageRouteNames.settings);
          },
          child: Row(
            children: [
              const SizedBox(
                width: 18,
              ),
              const Icon(
                Icons.settings,
                size: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                lang.settings,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 28),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
