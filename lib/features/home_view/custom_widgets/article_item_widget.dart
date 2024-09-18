import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Add the shimmer package

import '../../../core/utils.dart';
import '../../../models/article_model.dart';

class ArticleItemWidget extends StatelessWidget {
  final int idx;
  final Article article;
  final void Function(int)? articleOnClicked;
  const ArticleItemWidget({
    super.key,
    required this.idx,
    required this.article,
    required this.articleOnClicked
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),

      child: InkWell(

        onTap: ()=>articleOnClicked!(idx),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.black.withOpacity(.4),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: article.urlToImage,
                imageBuilder: (context, imageProvider) => Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Replace CircularProgressIndicator with a Shimmer effect
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.source,
                      style:
                          theme.textTheme.titleSmall?.copyWith(color: Colors.white),
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
                        style: theme.textTheme.titleSmall
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
