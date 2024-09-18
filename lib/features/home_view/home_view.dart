import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/core/config/color_palette.dart';
import 'package:news_app/data/data_source/api_manager.dart';
import 'package:news_app/features/home_view/article_details_view/article_details_view.dart';
import 'package:news_app/features/home_view/custom_widgets/article_view.dart';
import 'package:news_app/features/home_view/custom_widgets/body_content.dart';
import 'package:news_app/features/home_view/custom_widgets/category_bottom_sheet.dart';
import 'package:news_app/features/navigation_bar/navigation_bar.dart';
import 'package:news_app/features/navigation_bar/source_tab_bar.dart';
import 'package:news_app/models/category_model.dart';

import '../../models/article_model.dart';
import '../../models/source_model.dart';
import 'custom_widgets/tab_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Article> articleList = [];
  bool isBottomSheetOpened = false;
  bool isArticleOpened = false;
  bool isCategoryChanged = false;
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

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
            if (articleList.isNotEmpty)
              BodyContent(
                isBottomSheetOpened: isBottomSheetOpened,
                articleList: articleList,
                update: update,
              ),

            SourceTabBar(
              update: update,
              selectedCategory: selectedCategory,
              loadArticleList: loadArticleList,
              isArticleOpened: isArticleOpened,
              isBottomSheetOpened: isBottomSheetOpened,
              isCategoryChanged: isCategoryChanged,
            ),
            CustomNavigationBar(
              loadArticleList: loadArticleList,
              update: update,
              isArticleOpened: isArticleOpened,
              isBottomSheetOpened: isBottomSheetOpened,
            ),
            Container(
              width: screenWidth,
              height: 80,
              color: Colors.black.withOpacity(.82),
            ),
            AnimatedPositioned(
              width: isBottomSheetOpened ? 160 : 80,
              top: isBottomSheetOpened ? 50 : 35,
              left: isBottomSheetOpened ? screenWidth / 2 - 80 : 30,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 600),
              child: Image.asset(
                "assets/icons/homeLogo.png",
              ),
            ),
            AnimatedPositioned(
              top: isBottomSheetOpened ? -100 : 47,
              right: 30,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 600),
              child: Text(
                selectedCategory?.title ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loadArticleList(String? sourceID, String? q) async {
    articleList = await ApiManager.fetchArticleList(sourceID, q);
    setState(() {});
  }

  void update(
      {CategoryModel? categoryModel,
      bool? bottomSheetOpen,
      bool? articleOpen,
      bool? categoryChanged}) {
    setState(() {
      if (categoryModel != null) {
        selectedCategory = categoryModel;
      }
      if (bottomSheetOpen != null) {
        isBottomSheetOpened = bottomSheetOpen;
      }
      if (articleOpen != null) {
        isArticleOpened = articleOpen;
      }
      if (categoryChanged != null) {
        isCategoryChanged = categoryChanged;
      }
    });
  }
}
