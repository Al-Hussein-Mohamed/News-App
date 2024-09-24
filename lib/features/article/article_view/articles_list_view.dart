import 'dart:developer';

import 'package:flutter/material.dart';


import '../../../../models/article_model.dart';
import '../custom_widgets/article_item_widget.dart';

class ArticleListView extends StatefulWidget {
  final List<Article> articlesList;
  final void Function(BuildContext, int) articleOnClicked;

  const ArticleListView({
    super.key,
    required this.articlesList,
    required this.articleOnClicked,
  });

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ArticleItemWidget(
        idx: index,
        article: widget.articlesList[index],
        articleOnClicked: widget.articleOnClicked,
      ),
      itemCount: widget.articlesList.length,
    );
  }
}
