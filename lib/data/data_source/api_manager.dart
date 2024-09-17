import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../core/config/constants.dart';
import '../../models/article_model.dart';
import '../../models/source_model.dart';

class ApiManager {
  static Future<List<Source>> fetchSourcesList(String categoryID) async {
    final url = Uri.https(
      Constants.domain,
      "/v2/top-headlines/sources",
      {
        "apiKey": Constants.apiKey,
        "category": categoryID,
      },
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SourceModel.fromJson(jsonDecode(response.body)).sourcesList;
    } else {
      throw ("failed to fetch the sources list");
    }
  }

  static Future<List<Article>> fetchArticleList(String? sourceID, String? q) async {
    final url = Uri.https(
      Constants.domain,
      "/v2/top-headlines",
      {
        "apiKey": Constants.apiKey,
        if(sourceID != null)
          "sources": sourceID,
        if(q != null)
          "q": q,
      },
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return ArticleModel.fromJson(jsonDecode(response.body)).articleList;
    } else {
      throw ("failed to fetch the article listtt");
    }
  }
}
