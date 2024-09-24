import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/features/home/home_manager/home_cubit.dart';
import 'package:news_app/features/home/home_manager/home_states.dart';
import 'package:news_app/features/navigation_bar/navigation_bar.dart';
import 'package:news_app/features/title/title_view/title_view.dart';

import '../../../core/config/constants.dart';
import '../../article/article_view/body_content.dart';
import '../../source_bar/source_bar_view/source_bar_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            body: Stack(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                ),
                if (homeCubit.selectedCategory != null)
                  const BodyContent(),
                if (homeCubit.selectedCategory != null)
                  const SourceBarView(),
                const CustomNavigationBar(),
                Container(
                  width: screenWidth,
                  height: 80,
                  color: Colors.black.withOpacity(.82),
                ),
                AnimatedPositioned(
                  width: homeCubit.isCategorySheetOpened ? 160 : 80,
                  top: homeCubit.isCategorySheetOpened ? 50 : 35,
                  left: homeCubit.isCategorySheetOpened ? screenWidth / 2 - 80 : 30,
                  curve: Curves.easeInOut,
                  duration: Constants.duration,
                  child: Image.asset(
                    "assets/icons/homeLogo.png",
                  ),
                ),
                const TitleView(),
              ],
            ),
          ),
        );
      },
    );
  }
}
