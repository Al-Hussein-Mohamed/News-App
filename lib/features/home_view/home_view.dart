import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/core/config/color_palette.dart';
import 'package:news_app/data/data_source/api_manager.dart';
import 'package:news_app/features/home_view/custom_widgets/article_view.dart';
import 'package:news_app/features/home_view/custom_widgets/category_bottom_sheet.dart';
import 'package:news_app/features/home_view/custom_widgets/selected_category_view.dart';
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
  CategoryModel? selectedCategory;
  List<Source> sourcesList = [];
  List<Article> articleList = [];
  bool isBottomSheetOpened = false;
  int sourceIdx = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCategoryBottomSheet(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/images/pattern.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                ),
                if (articleList.isNotEmpty)
                  AnimatedPositioned(
                      height: screenHeight - 65 - 70,
                      width: screenWidth,
                      top: isBottomSheetOpened ? 600 : 50,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 600),
                      child: ArticleView(
                        articleList: articleList,
                      )),
                Container(
                  width: screenWidth,
                  height: 110,
                  color: Colors.black.withOpacity(.8),
                ),
                Positioned(
                  bottom: 0,
                  height: 145,
                  width: screenWidth,
                  child: Container(
                    color: Colors.black.withOpacity(.8),
                  ),
                ),
                Positioned(
                  width: screenWidth,
                  bottom: 20,
                  child: Column(
                    children: [
                      if (selectedCategory != null)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DefaultTabController(
                            length: sourcesList.length,
                            child: TabBar(
                              isScrollable: true,
                              dividerColor: Colors.transparent,
                              indicator: const BoxDecoration(),
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              tabAlignment: TabAlignment.start,
                              onTap: (value) {
                                sourceIdx = value;
                                setState(() {
                                  articleList.clear();
                                });
                                loadArticleList(
                                    sourcesList[sourceIdx].id, null);
                              },
                              tabs: sourcesList
                                  .map(
                                    (e) => TabItemWidget(
                                      source: e,
                                      isSelected:
                                          sourceIdx == sourcesList.indexOf(e),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      Container(
                        width: screenWidth - 20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 8),
                        decoration: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/icons/settings.png",
                                scale: 1.2,
                              ),
                            ),
                            IconButton(
                              onPressed: () => showCategoryBottomSheet(context),
                              icon: Image.asset(
                                "assets/icons/selectCategory.png",
                                scale: 1.2,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                "assets/icons/search.png",
                                scale: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedPositioned(
                  width: isBottomSheetOpened ? 160 : 120,
                  top: isBottomSheetOpened ? 50 : 45,
                  left: isBottomSheetOpened ? screenWidth / 2 - 80 : 25,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 600),
                  child: Image.asset(
                    "assets/icons/homeLogo.png",
                  ),
                ),
                AnimatedPositioned(
                  top: isBottomSheetOpened ? -100 : 65,
                  right: isBottomSheetOpened ? 25 : 25,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    selectedCategory?.title ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCategoryBottomSheet(BuildContext context) async {
    final AnimationController animationController = AnimationController(
      vsync: Navigator.of(context),
      // Ensures animations sync with the app's frame rate
      duration: const Duration(
          milliseconds: 600), // Slows down the animation (2 seconds)
    );

    setState(() => isBottomSheetOpened = true);
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: ColorPalette.primaryColor,
      transitionAnimationController: animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (context) => CategoryBottomSheet(
        categoryOnClicked: categoryOnClicked,
      ),
    ).then(
      (value) => setState(
        () => isBottomSheetOpened = false,
      ),
    );
  }

  Future<void> categoryOnClicked(CategoryModel categoryModel) async {
    Navigator.pop(context);
    selectedCategory = categoryModel;
    isBottomSheetOpened = false;
    await loadSourcesList(categoryModel.id);
    sourceIdx = 0;
    await loadArticleList(sourcesList[0].id, null);
  }

  loadSourcesList(String id) async {
    sourcesList = await ApiManager.fetchSourcesList(id);
  }

  loadArticleList(String? sourceID, String? q) async {
    articleList = await ApiManager.fetchArticleList(sourceID, q);
    setState(() {});
  }
}
