import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../core/config/color_palette.dart';
import '../../../data/data_source/api_manager.dart';
import '../../../models/article_model.dart';
import 'article_item_widget.dart';

class ArticleView extends StatelessWidget {
  final List<Article> articleList;
  ArticleView({super.key, required this.articleList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) =>
            ArticleItemWidget(article: articleList[index],),
        itemCount: articleList.length,
      ),
    );
  }
}
