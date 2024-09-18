import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/config/color_palette.dart';
import '../../data/data_source/api_manager.dart';
import '../../models/category_model.dart';
import '../../models/source_model.dart';
import '../home_view/custom_widgets/category_bottom_sheet.dart';
import '../home_view/custom_widgets/tab_item_widget.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(String?, String?) loadArticleList;
  final Function(
      {CategoryModel? categoryModel, bool? bottomSheetOpen, bool? articleOpen, bool? categoryChanged}) update;
  bool isBottomSheetOpened;
  bool isArticleOpened;

  CustomNavigationBar({
    super.key,
    required this.loadArticleList,
    required this.update,
    required this.isArticleOpened,
    required this.isBottomSheetOpened,
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

    return AnimatedPositioned(
        curve: Curves.easeInOut,
        right: 15,
        bottom: widget.isBottomSheetOpened ? 15 - 100 : 15,
        duration: const Duration(milliseconds: 700),
        child: Container(
          width: screenWidth - 30,
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 8),
          decoration: BoxDecoration(
            color: ColorPalette.primaryColor,
            borderRadius: BorderRadius.circular(25),
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
        ));
  }

  Future<void> showCategoryBottomSheet(BuildContext context) async {
    final AnimationController animationController = AnimationController(
      vsync: Navigator.of(context),
      // Ensures animations sync with the app's frame rate
      duration: const Duration(
          milliseconds: 800), // Slows down the animation (2 seconds)
    );

    widget.update(bottomSheetOpen: true);
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
    ).then((_) => widget.update(bottomSheetOpen: false));
  }

  Future<void> categoryOnClicked(CategoryModel categoryModel) async {
    Navigator.pop(context);
    widget.isBottomSheetOpened = false;
    widget.update(categoryModel: categoryModel, categoryChanged: true, bottomSheetOpen: false);
  }

}
