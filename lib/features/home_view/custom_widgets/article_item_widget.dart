import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Add the shimmer package

import '../../../core/config/color_palette.dart';
import '../../../models/article_model.dart';

class ArticleItemWidget extends StatelessWidget {
  final Article article;
  const ArticleItemWidget({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.parse(article.publishedAt);
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);

    return Container(
      color: Colors.black.withOpacity(.6),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20,
      ),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: article.urlToImage,
            imageBuilder: (context, imageProvider) => Container(
              height: 230,
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
        ],
      ),
    );
  }

  String calcTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    if (dateTime.year != DateTime.now().year) {
      int difference = DateTime.now().year - dateTime.year;
      return "$difference year${difference > 1 ? "s" : ""} ago";
    }
    if (dateTime.month != DateTime.now().month) {
      int difference = DateTime.now().month - dateTime.month;
      return "$difference month${difference > 1 ? "s" : ""} ago";
    }
    if (dateTime.day != DateTime.now().day) {
      int difference = DateTime.now().day - dateTime.day;
      return "$difference day${difference > 1 ? "s" : ""} ago";
    }
    if (dateTime.hour != DateTime.now().hour) {
      int difference = DateTime.now().hour - dateTime.hour;
      return "$difference hour${difference > 1 ? "s" : ""} ago";
    }
    if (dateTime.minute != DateTime.now().minute) {
      int difference = DateTime.now().minute - dateTime.minute;
      return "$difference minute${difference > 1 ? "s" : ""} ago";
    }

    int difference = DateTime.now().second - dateTime.second;
    return "$difference second${difference > 1 ? "s" : ""} ago";
  }
}
