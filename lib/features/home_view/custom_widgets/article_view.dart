import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/view_model/article_view_model.dart';
import 'package:provider/provider.dart';

import '../../../models/article_model.dart';
import 'article_item_widget.dart';

class ArticleView extends StatefulWidget {
  final ArticleViewModel articleViewModel;
  final void Function(int)? articleOnClicked;

  const ArticleView({
    super.key,
    required this.articleViewModel,
    required this.articleOnClicked,
  });

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    log("article view: ${widget.articleViewModel.articleList.length.toString()}");
    return ListView.builder(
      itemBuilder: (context, index) => ArticleItemWidget(
        idx: index,
        article: widget.articleViewModel.articleList[index],
        articleOnClicked: widget.articleOnClicked,
      ),
      itemCount: widget.articleViewModel.articleList.length,
    );
  }
}
