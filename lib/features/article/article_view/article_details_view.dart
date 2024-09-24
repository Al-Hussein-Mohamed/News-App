import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/config/color_palette.dart';
import 'package:news_app/core/config/page_route_names.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/utils.dart';
import '../../../../models/article_model.dart';

class ArticleDetailsView extends StatelessWidget {
  final Article article;
  final Function(BuildContext) closeArticle;

  const ArticleDetailsView({
    super.key,
    required this.article,
    required this.closeArticle,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    var screenHeight = mediaQuery.size.height;
    var screenWidth = mediaQuery.size.width;
    String art = article.description + article.content;

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 10) { // Increase threshold if needed
          // Swipe right detected
          closeArticle(context);
          // closeArticle.call(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CachedNetworkImage(
              imageUrl: article.urlToImage,
              imageBuilder: (context, imageProvider) => Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.source,
                    style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    article.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      calcTime(article.publishedAt),
                      style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                decoration: BoxDecoration(
                  color: ColorPalette.primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          art,
                          style: theme.textTheme.displaySmall?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(25),
                            child: InkWell(
                              onTap: () => closeArticle(context),
                              borderRadius: BorderRadius.circular(25),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                child: Text(
                                  "Back",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, PageRouteNames.web, arguments: article.url),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "View Full Article ",
                                    style: theme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }


}
