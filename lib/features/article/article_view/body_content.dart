import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/config/color_palette.dart';

import '../../../../core/config/constants.dart';
import '../../home/home_manager/home_cubit.dart';
import '../../source_bar/source_manager/source_cubit.dart';
import '../article_manager/article_cubit.dart';
import '../article_manager/article_states.dart';
import 'article_details_view.dart';
import 'articles_list_view.dart';

class BodyContent extends StatefulWidget {
  const BodyContent({
    super.key,
  });

  @override
  State<BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<BodyContent> {
  int articleIdx = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    var articleCubit = ArticleCubit.get(context);
    var homeCubit = HomeCubit.get(context);
    var theme = Theme.of(context);

    return BlocBuilder<ArticleCubit, ArticleState>(
      builder: (context, state) {
        switch (state) {
          case LoadingArticleState():
            {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorPalette.primaryColor,
                ),
              );
            }

          case ErrorArticleState():
            {
              return Center(
                child: Text(state.error ?? "Error"),
              );
            }

          case SuccessWithNoData():
            {
              return Center(
                child: Text(
                  "There is no Data, try another thing...",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              );
            }

          case SuccessArticleState():
            {
              return Stack(
                children: [
                  // SizedBox(width: screenWidth,),
                  AnimatedPositioned(
                    height: screenHeight - 35 - 50,
                    width: screenWidth,
                    top: homeCubit.isCategorySheetOpened ? 1000 : 35,
                    left: articleCubit.isArticleOpened ? -1 * screenWidth : 0,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 700),
                    child: ArticleListView(
                      articlesList: state.articlesList,
                      articleOnClicked: articleOnClicked,
                    ),
                  ),
                  AnimatedPositioned(
                    height: screenHeight - 35 - 70,
                    width: screenWidth,
                    top: homeCubit.isCategorySheetOpened ? 1000 : 35,
                    right:
                        articleCubit.isArticleOpened ? 0 : -1.5 * screenWidth,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 700),
                    child: ArticleDetailsView(
                      article: state.articlesList[articleCubit.idx],
                      closeArticle: closeArticle,
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }

  void articleOnClicked(BuildContext context, int idx) {
    var articleCubit = context.read<ArticleCubit>();
    var sourceCubit = SourceCubit.get(context);

    articleCubit.idx = idx;
    sourceCubit.hide = true;
  }

  void closeArticle(BuildContext context) {
    var articleCubit = ArticleCubit.get(context);
    var sourceCubit = SourceCubit.get(context);

    articleCubit.isArticleOpened = false;
    sourceCubit.hide = false;
  }
}
