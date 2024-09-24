import '../../../../models/article_model.dart';

sealed class ArticleState {}

class LoadingArticleState extends ArticleState {}

class ErrorArticleState extends ArticleState {
  final String? error;

  ErrorArticleState(this.error);
}

class SuccessArticleState extends ArticleState {
  final List<Article> articlesList;

  SuccessArticleState(this.articlesList);
}

class SuccessWithNoData extends ArticleState {}
