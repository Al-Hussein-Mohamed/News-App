import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/features/article/article_manager/article_cubit.dart';
import 'package:news_app/features/home/home_manager/home_cubit.dart';
import 'package:news_app/features/navigation_bar/custom_search_bar/custom_serach_bar.dart';
import 'package:news_app/features/navigation_bar/settings/settings_bottom_sheet.dart';
import 'package:news_app/features/title/title_manager/title_cubit.dart';
import 'package:provider/provider.dart';

import '../../core/config/color_palette.dart';
import '../../core/config/constants.dart';
import '../../models/category_model.dart';
import '../source_bar/source_manager/source_cubit.dart';
import 'category_bottom_sheet/category_bottom_sheet_view/category_bottom_sheet.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCategoryBottomSheet(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var homeCubit = Provider.of<HomeCubit>(context);

    return AnimatedPositioned(
      curve: Curves.easeInOut,
      right: 15,
      bottom: homeCubit.isCategorySheetOpened ? 15 - 100 : 15,
      duration: const Duration(milliseconds: 700),
      child: Container(
        width: screenWidth - 30,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        decoration: BoxDecoration(
          color: ColorPalette.primaryColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => showSettingsBottomSheet(context),
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
              onPressed: () => showSearchBar(context),
              icon: Image.asset(
                "assets/icons/search.png",
                scale: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCategoryBottomSheet(BuildContext context) async {
    var homeCubit = context.read<HomeCubit>();

    final AnimationController animationController = AnimationController(
      vsync: Navigator.of(context),
      // Ensures animations sync with the app's frame rate
      duration: Constants.duration,
    );

    homeCubit.openCategorySheet();
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
    ).then((_) => homeCubit.closeCategorySheet());
  }

  Future<void> categoryOnClicked(CategoryModel categoryModel) async {
    Navigator.pop(context);
    var homeCubit = context.read<HomeCubit>();
    var titleCubit = context.read<TitleCubit>();
    var sourceCubit = SourceCubit.get(context);
    var articleCubit = ArticleCubit.get(context);

    titleCubit.title = categoryModel.title;
    articleCubit.loading();
    sourceCubit.fetchSourcesList(categoryModel.id, true);
    homeCubit.isSearch = false;
    homeCubit.selectedCategory = categoryModel;
    homeCubit.closeCategorySheet();
  }

  Future<void> showSettingsBottomSheet(BuildContext context) async {
    final AnimationController animationController = AnimationController(
      vsync: Navigator.of(context),
      // Ensures animations sync with the app's frame rate
      duration: Constants.duration,
    );

    // widget.update(bottomSheetOpen: true);
    await showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withOpacity(.8),
      backgroundColor: ColorPalette.primaryColor,
      transitionAnimationController: animationController,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      builder: (context) => const SettingsBottomSheet(),
    );
    // .then((_) => widget.update(bottomSheetOpen: false));
  }

  Future<void> showSearchBar(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const CustomSearchBar(),
    );
  }
}
