import 'package:flutter/material.dart';

import '../../../models/article_model.dart';
import 'article_item_widget.dart';

class ArticleView extends StatelessWidget {
  final List<Article> articleList;
  final void Function(int)? articleOnClicked;

  ArticleView({
    super.key,
    required this.articleList,
    required this.articleOnClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => ArticleItemWidget(
          idx: index,
          article: articleList[index],
          articleOnClicked: articleOnClicked,
        ),
        itemCount: articleList.length,
      ),
    );
  }
}
