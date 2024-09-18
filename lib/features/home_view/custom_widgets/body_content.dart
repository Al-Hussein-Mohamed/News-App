import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../models/article_model.dart';
import '../../../models/category_model.dart';
import '../article_details_view/article_details_view.dart';
import 'article_view.dart';

class BodyContent extends StatefulWidget {
  final Function({CategoryModel? categoryModel, bool? bottomSheetOpen, bool? articleOpen}) update;
  List<Article> articleList;
  bool isBottomSheetOpened;

  BodyContent({
    super.key,
    required this.update,
    required this.isBottomSheetOpened,
    required this.articleList,
  });

  @override
  State<BodyContent> createState() => _BodyContentState();

}

class _BodyContentState extends State<BodyContent> {
  bool isArticleOpened = false;
  int articleIdx = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    return Stack(
      children: [
        // SizedBox(width: screenWidth,),
        AnimatedPositioned(
          height: screenHeight - 35 - 50,
          width: screenWidth,
          top: widget.isBottomSheetOpened ? 600 : 35,
          left: isArticleOpened ? -1*screenWidth : 0,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 700),
          child: ArticleView(
            articleList: widget.articleList,
            articleOnClicked: articleOnClicked,
          ),
        ),
        AnimatedPositioned(
          height: screenHeight - 35 - 70,
          width: screenWidth,
          top: widget.isBottomSheetOpened ? 600 : 35,
          right: isArticleOpened ? 0 : -1.5*screenWidth,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 700),
          child: ArticleDetailsView(
            article: widget.articleList[articleIdx],
            closeArticle: closeArticle,
          ),
        ),
      ],
    );
  }

  void articleOnClicked(int idx) {
    setState(
      () {
        articleIdx = idx;
        isArticleOpened = true;
        widget.update(articleOpen: true);
      },
    );
  }

  void closeArticle() {
    setState(() {
      isArticleOpened = false;
      widget.update(articleOpen: false);
    });
  }
}
