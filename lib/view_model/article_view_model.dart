import 'dart:developer';

import 'package:flutter/material.dart';

import '../data/data_source/api_manager.dart';
import '../models/article_model.dart';

class ArticleViewModel extends ChangeNotifier{
  List<Article> _articleList = [];
  int _idx = 0;


  int get idx => _idx;
  List<Article> get articleList => _articleList;


  set idx(int value) {
    _idx = value;
    notifyListeners();
  }

  Future<void> fetchArticleList(String? sourceID, String? q) async {
    idx = 0;
    _articleList = await ApiManager.fetchArticleList(sourceID, q);
    log("artical view model: ${_articleList.length.toString()}");
    notifyListeners();
  }
}