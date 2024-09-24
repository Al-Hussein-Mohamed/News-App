import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/data_source/api_manager.dart';

import '../../../../models/article_model.dart';
import 'article_states.dart';

class ArticleCubit extends Cubit<ArticleState> {

  ArticleCubit() : super(LoadingArticleState());

  bool _isArticleOpened = false;
  int _idx = 0;
  List<Article> _articlesList = [];

  static ArticleCubit get(context) => BlocProvider.of<ArticleCubit>(context);


  bool get isArticleOpened => _isArticleOpened;
  int get idx => _idx;

  set idx(int value) {
    _idx = value;
    _isArticleOpened = true;
    log("idx setter : $isArticleOpened");

    emit(SuccessArticleState(_articlesList));
  }


  set isArticleOpened(bool value) {
    _isArticleOpened = value;
    log("is art setter: $isArticleOpened");
    emit(SuccessArticleState(_articlesList));
  }

  Future<void> fetchArticlesList(String? sourceID, String? q) async{
    _isArticleOpened = false;
    _idx = 0;
    emit(LoadingArticleState());

    try {
      _articlesList = await ApiManager.fetchArticleList(sourceID, q);
      if(_articlesList.isEmpty) {
        emit(SuccessWithNoData());
      } else {
        emit(SuccessArticleState(_articlesList));
      }
    } catch (error) {
      emit(ErrorArticleState(error.toString()));
    }
  }

  void loading(){
    emit(LoadingArticleState());
  }

}