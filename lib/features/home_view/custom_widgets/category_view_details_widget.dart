// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:news_app/data/data_source/api_manager.dart';
// import 'package:news_app/features/home_view/custom_widgets/article_item_widget.dart';
// import 'package:news_app/features/home_view/custom_widgets/tab_item_widget.dart';
// import 'package:news_app/models/article_model.dart';
//
// import '../../../core/config/color_palette.dart';
// import '../../../models/source_model.dart';
//
// class CategoryViewDetailsWidget extends StatefulWidget {
//   final List<Source> sourcesList;
//   Function(String)? getArticleList;
//
//   CategoryViewDetailsWidget({
//     super.key,
//     required this.sourcesList,
//     required this.getArticleList,
//   });
//
//   @override
//   State<CategoryViewDetailsWidget> createState() =>
//       _CategoryViewDetailsWidgetState();
// }
//
// class _CategoryViewDetailsWidgetState extends State<CategoryViewDetailsWidget> {
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: widget.sourcesList.length,
//       child: TabBar(
//         isScrollable: true,
//         dividerColor: Colors.transparent,
//         indicator: const BoxDecoration(),
//         labelPadding: const EdgeInsets.symmetric(horizontal: 6),
//         tabAlignment: TabAlignment.start,
//         onTap: (value) {
//           widget.getArticleList!(widget.sourcesList[value].id);
//           setState(() => selectedIdx = value);
//         },
//         tabs: widget.sourcesList
//             .map(
//               (e) => TabItemWidget(
//                 source: e,
//                 isSelected: selectedIdx == widget.sourcesList.indexOf(e),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }
