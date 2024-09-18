import 'package:flutter/material.dart';

import '../../data/data_source/api_manager.dart';
import '../../models/category_model.dart';
import '../../models/source_model.dart';
import '../home_view/custom_widgets/tab_item_widget.dart';

class SourceTabBar extends StatefulWidget {
  final Function(
      {CategoryModel? categoryModel,
      bool? bottomSheetOpen,
      bool? articleOpen,
      bool? categoryChanged}) update;
  final Function(String?, String?) loadArticleList;
  CategoryModel? selectedCategory;
  bool isBottomSheetOpened;
  bool isArticleOpened;
  bool isCategoryChanged;

  SourceTabBar({
    super.key,
    required this.update,
    required this.selectedCategory,
    required this.loadArticleList,
    required this.isArticleOpened,
    required this.isBottomSheetOpened,
    required this.isCategoryChanged,
  });

  @override
  State<SourceTabBar> createState() => _SourceTabBarState();
}

class _SourceTabBarState extends State<SourceTabBar> {
  List<Source> sourcesList = [];
  int sourceIdx = 0;
  bool isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    if (widget.selectedCategory != null) {
      loadSourcesList(widget.selectedCategory!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    // Check if the category has changed and reload sources
    if (widget.isCategoryChanged) {
      sourceIdx = 0;
      loadSourcesList(widget.selectedCategory!.id);
      widget.update(categoryChanged: false);
    }

    // Show a loading indicator if data is being fetched
    if (isLoading) {
      return const Center(
        child: SizedBox(), // Display a loading indicator
      );
    }

    // Show a message if there are no sources
    if (sourcesList.isEmpty) {
      return const Center(
        child: Text(
          "No Data",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      );
    }

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
          bottom: widget.isArticleOpened || widget.isBottomSheetOpened ? -120 : 80,
          // left: widget.isArticleOpened ? 25 : 0,
          duration: const Duration(milliseconds: 800),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: DefaultTabController(
              length: sourcesList.length,
              child: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(),
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                tabAlignment: TabAlignment.start,
                onTap: (value) {
                  sourceIdx = value;
                  widget.loadArticleList(sourcesList[sourceIdx].id, null);
                },
                tabs: sourcesList
                    .map(
                      (e) => TabItemWidget(
                        source: e,
                        isSelected: sourceIdx == sourcesList.indexOf(e),
                      ),
                    )
                    .toList(),
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

  Future<void> loadSourcesList(String id) async {
    setState(() {
      isLoading = true; // Start loading
    });

    final List<Source> newSourceList = await ApiManager.fetchSourcesList(id);

    setState(() {
      sourcesList = newSourceList;
      isLoading = false; // Stop loading when data is fetched
    });

    // Load articles for the first source, if any
    if (sourcesList.isNotEmpty) {
      widget.loadArticleList(sourcesList[sourceIdx].id, null);
    }
  }
}
