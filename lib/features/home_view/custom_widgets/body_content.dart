import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/article_model.dart';
import '../../../models/category_model.dart';
import '../../../view_model/article_view_model.dart';
import '../article_details_view/article_details_view.dart';
import 'article_view.dart';

class BodyContent extends StatefulWidget {
  final ArticleViewModel articleViewModel;

  final Function(
      {CategoryModel? categoryModel,
      bool? bottomSheetOpen,
      bool? articleOpen}) update;
  bool isBottomSheetOpened;
  bool isArticleOpened;

  BodyContent({
    super.key,
    required this.articleViewModel,
    required this.update,
    required this.isBottomSheetOpened,
    required this.isArticleOpened,
  });

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  int articleIdx = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return ChangeNotifierProvider(
      create: (context) => widget.articleViewModel,
      child: Consumer<ArticleViewModel>(
        builder: (context, vm, _) => Expanded(
            child: vm.articleList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Stack(
                    children: [
                      // SizedBox(width: screenWidth,),
                      AnimatedPositioned(
                        height: screenHeight - 35 - 50,
                        width: screenWidth,
                        top: widget.isBottomSheetOpened ? 600 : 35,
                        left: widget.isArticleOpened ? -1 * screenWidth : 0,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 700),
                        child: ArticleView(
                          articleViewModel: widget.articleViewModel,
                          articleOnClicked: articleOnClicked,
                        ),
                      ),
                      AnimatedPositioned(
                        height: screenHeight - 35 - 70,
                        width: screenWidth,
                        top: widget.isBottomSheetOpened ? 600 : 35,
                        right: widget.isArticleOpened ? 0 : -1.5 * screenWidth,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 700),
                        child: ArticleDetailsView(
                          article:
                              widget.articleViewModel.articleList[widget.articleViewModel.idx],
                          closeArticle: closeArticle,
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  void articleOnClicked(int idx) {
    widget.articleViewModel.idx = idx;
    setState(
      () {
        widget.update(articleOpen: true);
      },
    );
  }

  void closeArticle() {
    setState(() {
      widget.update(articleOpen: false);
    });
  }
}
