class ArticleModel {
  final String status;
  final int totalResults;
  final List<Article> articleList;

  ArticleModel({
    required this.status,
    required this.totalResults,
    required this.articleList,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articleList: List.from(json["articles"]).map((e) => Article.fromJson(e),).toList(),
      );
}

class Article {
  final String source;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"]["name"] ?? "",
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"] ?? "",
        publishedAt: json["publishedAt"] ?? "",
        content: json["content"] ?? "",
      );
}
