import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/core/settings_provider.dart';
import 'package:news_app/view_model/source_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/data_source/api_manager.dart';
import '../../models/category_model.dart';
import '../../models/source_model.dart';
import '../../view_model/article_view_model.dart';
import '../home_view/custom_widgets/tab_item_widget.dart';

class SourceTabBar extends StatefulWidget {
  final SourceViewModel sourceViewModel;
  final ArticleViewModel articleViewModel;

  final Function(
      {CategoryModel? categoryModel,
      bool? bottomSheetOpen,
      bool? articleOpen,
      bool? categoryChanged}) update;
  CategoryModel? selectedCategory;
  bool isBottomSheetOpened;
  bool isArticleOpened;
  bool isCategoryChanged;

  SourceTabBar({
    super.key,
    required this.articleViewModel,
    required this.sourceViewModel,
    required this.update,
    required this.selectedCategory,
    required this.isArticleOpened,
    required this.isBottomSheetOpened,
    required this.isCategoryChanged,
  });

  @override
  State<SourceTabBar> createState() => _SourceTabBarState();
}

class _SourceTabBarState extends State<SourceTabBar> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Stack(
      children: [
        AnimatedPositioned(
          width: screenWidth,
          height: widget.isArticleOpened ? 0 : 140,
          bottom: widget.isBottomSheetOpened ? -160 : 0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Container(
            color: Colors.black.withOpacity(.78),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.easeInOut,
          width: screenWidth,
          bottom:
              widget.isArticleOpened || widget.isBottomSheetOpened ? -120 : 80,
          // left: widget.isArticleOpened ? 25 : 0,
          duration: const Duration(milliseconds: 800),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ChangeNotifierProvider(
              create: (context) => widget.sourceViewModel..fetchSourcesList(widget.selectedCategory?.id),
              child: Consumer<SourceViewModel>(
                builder: (context, vm, _) => DefaultTabController(
                  length: vm.sourcesList.length,
                  child: TabBar(
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    tabAlignment: TabAlignment.start,
                    onTap: (value) {
                      vm.idx = value;
                      widget.articleViewModel.fetchArticleList(vm.sourcesList[vm.idx].id, null);
                    },
                    tabs: vm.sourcesList
                        .map(
                          (e) => TabItemWidget(
                            source: e,
                            isSelected: vm.idx == vm.sourcesList.indexOf(e),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          width: screenWidth,
          height: 90,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
